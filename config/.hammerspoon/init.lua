-- Hammerspoon 設定
-- aerospace からの移行: ウィンドウ配置とアプリ切り替え

--------------------------------------------------------------------------------
-- 設定
--------------------------------------------------------------------------------

local modifier = {"ctrl", "alt"}
local modifierShift = {"ctrl", "alt", "shift"}

-- アプリ定義: キー = {bundleId, appName}
local apps = {
    t = {"com.github.wez.wezterm", "WezTerm"},
    b = {"com.google.Chrome", "Google Chrome"},
    g = {"com.jetbrains.goland", "GoLand"},
    v = {"com.microsoft.VSCode", "Visual Studio Code"},
    m = {"com.wails.NoteBeam", "NoteBeam"},
    o = {"md.obsidian", "Obsidian"},
    s = {"com.tinyspeck.slackmacgap", "Slack"},
    l = {"jp.naver.line.mac", "LINE"},
    j = {"com.electron.logseq", "Logseq"},
    z = {"us.zoom.xos", "zoom.us"},
    c = {"com.apple.iCal", "Calendar"},
    ["1"] = {"com.1password.1password", "1Password"},
}

-- ウィンドウサイズのサイクル定義
local sizeCycle = {
    {x = 0,    y = 0, w = 0.5,  h = 1},    -- 左半分
    {x = 0.5,  y = 0, w = 0.5,  h = 1},    -- 右半分
    {x = 0.15, y = 0, w = 0.7,  h = 1},    -- 中央 70%
    {x = 0,    y = 0, w = 0.33, h = 1},    -- 左 1/3
    {x = 0.33, y = 0, w = 0.34, h = 1},    -- 中央 1/3
    {x = 0.67, y = 0, w = 0.33, h = 1},    -- 右 1/3
    {x = 0,    y = 0, w = 1,    h = 1},    -- フルスクリーン
}

--------------------------------------------------------------------------------
-- 状態管理
--------------------------------------------------------------------------------

-- 連打検出用: {bundleId = {lastTime, cycleIndex}}
local appState = {}
local DOUBLE_TAP_THRESHOLD = 0.5  -- 秒

--------------------------------------------------------------------------------
-- ユーティリティ関数
--------------------------------------------------------------------------------

-- ウィンドウを指定の位置・サイズに移動
local function moveWindow(win, rect)
    if not win then return end
    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x + frame.w * rect.x,
        y = frame.y + frame.h * rect.y,
        w = frame.w * rect.w,
        h = frame.h * rect.h,
    })
end

-- 現在のウィンドウ位置がサイクルのどのインデックスに近いか判定
local function getCurrentCycleIndex(win)
    if not win then return 0 end
    local screen = win:screen()
    local frame = screen:frame()
    local winFrame = win:frame()

    -- 正規化された位置
    local currentRect = {
        x = (winFrame.x - frame.x) / frame.w,
        y = (winFrame.y - frame.y) / frame.h,
        w = winFrame.w / frame.w,
        h = winFrame.h / frame.h,
    }

    -- 最も近いサイクルを探す
    local tolerance = 0.05
    for i, rect in ipairs(sizeCycle) do
        if math.abs(currentRect.x - rect.x) < tolerance and
           math.abs(currentRect.w - rect.w) < tolerance then
            return i
        end
    end
    return 0
end

--------------------------------------------------------------------------------
-- アプリトグル機能
--------------------------------------------------------------------------------

local function toggleApp(bundleId, appName)
    local now = hs.timer.secondsSinceEpoch()
    local app = hs.application.get(bundleId)

    if not app then
        -- アプリが起動していない場合は起動
        hs.application.launchOrFocusByBundleID(bundleId)
        return
    end

    local win = app:mainWindow()
    local isFrontmost = app:isFrontmost()

    if not isFrontmost then
        -- 最前面でない場合: 最前面に持ってくる
        app:activate()
        appState[bundleId] = {lastTime = now, cycleIndex = 0}
    else
        -- 既に最前面の場合: 連打でサイズをサイクル
        local state = appState[bundleId] or {lastTime = 0, cycleIndex = 0}

        if (now - state.lastTime) < DOUBLE_TAP_THRESHOLD then
            -- 連打: 次のサイズへ
            local nextIndex = (state.cycleIndex % #sizeCycle) + 1
            moveWindow(win, sizeCycle[nextIndex])
            appState[bundleId] = {lastTime = now, cycleIndex = nextIndex}
        else
            -- 間隔が空いた: 現在位置からサイクル開始
            local currentIndex = getCurrentCycleIndex(win)
            local nextIndex = (currentIndex % #sizeCycle) + 1
            moveWindow(win, sizeCycle[nextIndex])
            appState[bundleId] = {lastTime = now, cycleIndex = nextIndex}
        end
    end
end

--------------------------------------------------------------------------------
-- ウィンドウ配置（現在のウィンドウを移動）
--------------------------------------------------------------------------------

local function moveCurrentWindow(rect)
    local win = hs.window.focusedWindow()
    if win then
        moveWindow(win, rect)
    end
end

--------------------------------------------------------------------------------
-- キーバインド設定
--------------------------------------------------------------------------------

-- アプリトグル: Ctrl+Alt+キー
for key, appInfo in pairs(apps) do
    hs.hotkey.bind(modifier, key, function()
        toggleApp(appInfo[1], appInfo[2])
    end)
end

-- ウィンドウ配置: Ctrl+Alt+Shift+Z/X で左右半分
hs.hotkey.bind(modifierShift, "z", function()
    moveCurrentWindow({x = 0, y = 0, w = 0.5, h = 1})
end)

hs.hotkey.bind(modifierShift, "x", function()
    moveCurrentWindow({x = 0.5, y = 0, w = 0.5, h = 1})
end)

-- フルスクリーン: Ctrl+Alt+Shift+F
hs.hotkey.bind(modifierShift, "f", function()
    moveCurrentWindow({x = 0, y = 0, w = 1, h = 1})
end)

-- 中央配置: Ctrl+Alt+Shift+C
hs.hotkey.bind(modifierShift, "c", function()
    moveCurrentWindow({x = 0.15, y = 0, w = 0.7, h = 1})
end)

--------------------------------------------------------------------------------
-- 設定リロード
--------------------------------------------------------------------------------

hs.hotkey.bind(modifier, "r", function()
    hs.reload()
end)

--------------------------------------------------------------------------------
-- カレンダー表示（メニューバー）
--------------------------------------------------------------------------------

local calendarMenubar = hs.menubar.new()
local CALENDAR_NAME = "garoon sync"
local CALENDAR_UPDATE_INTERVAL = 300  -- 5分

local function updateCalendar()
    local script = [[
        set now to current date
        set endTime to now + (24 * 60 * 60)
        set todayStart to now - (time of now)
        set tomorrowStart to todayStart + (24 * 60 * 60)

        tell application "Calendar"
            try
                set targetCal to first calendar whose name is "]] .. CALENDAR_NAME .. [["
            on error
                return "ERROR|カレンダーが見つかりません"
            end try

            -- 進行中のイベント
            set ongoingEvents to (every event of targetCal whose start date <= now and end date >= now)

            if (count of ongoingEvents) > 0 then
                set currentEvent to item 1 of ongoingEvents
                set eventTitle to summary of currentEvent
                set eventEnd to end date of currentEvent

                set h to (hours of eventEnd) as string
                set m to (minutes of eventEnd) as string
                if length of h < 2 then set h to "0" & h
                if length of m < 2 then set m to "0" & m

                return "ONGOING|~" & h & ":" & m & " " & eventTitle
            end if

            -- 次のイベント
            set upcomingEvents to (every event of targetCal whose start date > now and start date <= endTime)

            if (count of upcomingEvents) = 0 then
                return "NONE|"
            end if

            set nextEvent to item 1 of upcomingEvents
            set minDate to start date of nextEvent

            repeat with evt in upcomingEvents
                if start date of evt < minDate then
                    set nextEvent to evt
                    set minDate to start date of evt
                end if
            end repeat

            set eventTitle to summary of nextEvent
            set eventStart to start date of nextEvent

            set h to (hours of eventStart) as string
            set m to (minutes of eventStart) as string
            if length of h < 2 then set h to "0" & h
            if length of m < 2 then set m to "0" & m

            set prefix to ""
            if eventStart >= tomorrowStart then
                set prefix to "明日 "
            end if

            return "UPCOMING|" & prefix & h & ":" & m & " " & eventTitle
        end tell
    ]]

    hs.osascript.applescript(script, function(success, result, raw)
        if not success then
            calendarMenubar:setTitle("📅 ❌")
            return
        end

        local status, info = result:match("([^|]+)|?(.*)")

        if status == "NONE" or info == "" then
            calendarMenubar:setTitle("📅 --")
        elseif status == "ERROR" then
            calendarMenubar:setTitle("📅 ❌")
        elseif status == "ONGOING" then
            -- 進行中は赤色で表示
            local styledText = hs.styledtext.new("🔴 " .. info:sub(1, 35))
            calendarMenubar:setTitle(styledText)
        else
            -- 次の予定
            local displayText = info:sub(1, 35)
            if #info > 35 then displayText = displayText .. "..." end
            calendarMenubar:setTitle("📅 " .. displayText)
        end
    end)
end

-- 初回実行と定期更新
updateCalendar()
calendarTimer = hs.timer.doEvery(CALENDAR_UPDATE_INTERVAL, updateCalendar)

-- クリックでカレンダーアプリを開く
calendarMenubar:setClickCallback(function()
    hs.application.launchOrFocus("Calendar")
end)

--------------------------------------------------------------------------------
-- 起動完了
--------------------------------------------------------------------------------

hs.alert.show("Hammerspoon 設定を読み込みました")
