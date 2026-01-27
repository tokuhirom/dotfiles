-- Hammerspoon 設定
-- aerospace からの移行: ウィンドウ配置とアプリ切り替え

--------------------------------------------------------------------------------
-- 設定
--------------------------------------------------------------------------------

local modifier = {"ctrl", "alt"}
local modifierShift = {"ctrl", "alt", "shift"}

-- アプリ定義: キー = {bundleId, appName, screen}
-- screen: 1 = メインモニター, 2 = サブモニター, nil = 移動しない
local apps = {
    t = {"org.alacritty", "Alacritty", 1},
    b = {"com.google.Chrome", "Google Chrome", 1},
    g = {"com.jetbrains.goland", "GoLand", 1},
    v = {"com.microsoft.VSCode", "Visual Studio Code", 1},
    m = {"com.wails.NoteBeam", "NoteBeam", 1},
    o = {"md.obsidian", "Obsidian", 2},
    s = {"com.tinyspeck.slackmacgap", "Slack", 2},
    l = {"jp.naver.line.mac", "LINE", 2},
    j = {"com.electron.logseq", "Logseq", 2},
    z = {"us.zoom.xos", "zoom.us", 2},
    c = {"com.apple.iCal", "Calendar", 2},
    ["1"] = {"com.1password.1password", "1Password", 2},
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
-- screen:frame() を使用してメニューバー・Dock を除いた領域に配置
local function moveWindow(win, rect)
    if not win then return end
    local screen = win:screen()
    -- frame() はメニューバーと Dock を除いた使用可能領域
    -- fullFrame() は画面全体
    local fullFrame = screen:fullFrame()
    local frame = screen:frame()

    -- デバッグ: メニューバーの高さを確認
    local menuBarHeight = frame.y - fullFrame.y
    hs.printf("fullFrame.y=%d, frame.y=%d, menuBarHeight=%d", fullFrame.y, frame.y, menuBarHeight)

    local newFrame = {
        x = frame.x + frame.w * rect.x,
        y = frame.y + frame.h * rect.y,
        w = frame.w * rect.w,
        h = frame.h * rect.h,
    }
    win:setFrame(newFrame)
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

-- ウィンドウを指定のスクリーンに移動
local function moveToScreen(win, screenIndex)
    if not win then return end
    local screens = hs.screen.allScreens()
    if screenIndex > #screens then return end

    local targetScreen = screens[screenIndex]
    local currentScreen = win:screen()

    if targetScreen:id() ~= currentScreen:id() then
        -- 現在のフレームを相対的に保持して移動
        local frame = win:frame()
        local currentFrame = currentScreen:frame()
        local targetFrame = targetScreen:frame()

        -- 相対位置を計算
        local relX = (frame.x - currentFrame.x) / currentFrame.w
        local relY = (frame.y - currentFrame.y) / currentFrame.h
        local relW = frame.w / currentFrame.w
        local relH = frame.h / currentFrame.h

        -- 新しいスクリーンに適用
        win:setFrame({
            x = targetFrame.x + targetFrame.w * relX,
            y = targetFrame.y + targetFrame.h * relY,
            w = targetFrame.w * relW,
            h = targetFrame.h * relH,
        })
    end
end

local function toggleApp(bundleId, appName, targetScreen)
    local now = hs.timer.secondsSinceEpoch()
    local app = hs.application.get(bundleId)

    if not app then
        -- アプリが起動していない場合は起動
        hs.application.launchOrFocusByBundleID(bundleId)
        -- 起動後にスクリーン移動（少し待つ）
        if targetScreen then
            hs.timer.doAfter(0.5, function()
                local newApp = hs.application.get(bundleId)
                if newApp then
                    local win = newApp:mainWindow()
                    moveToScreen(win, targetScreen)
                end
            end)
        end
        return
    end

    local win = app:mainWindow()
    local isFrontmost = app:isFrontmost()

    -- まずアクティベート
    app:activate()

    -- 指定スクリーンに移動（常に）
    if targetScreen and win then
        moveToScreen(win, targetScreen)
    end

    if not isFrontmost then
        -- 最前面でなかった場合: 状態リセット
        appState[bundleId] = {lastTime = now, cycleIndex = 0}
    else
        -- 既に最前面だった場合: 連打でサイズをサイクル
        local state = appState[bundleId] or {lastTime = 0, cycleIndex = 0}

        if (now - state.lastTime) < DOUBLE_TAP_THRESHOLD then
            -- 連打: 次のサイズへ
            local nextIndex = (state.cycleIndex % #sizeCycle) + 1
            moveWindow(win, sizeCycle[nextIndex])
            appState[bundleId] = {lastTime = now, cycleIndex = nextIndex}
        else
            -- 間隔が空いた: 状態リセットのみ
            appState[bundleId] = {lastTime = now, cycleIndex = 0}
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
        toggleApp(appInfo[1], appInfo[2], appInfo[3])
    end)
end

-- ウィンドウ配置: Ctrl+Alt+Shift+キー

-- 半分 (Z/X)
hs.hotkey.bind(modifierShift, "z", function()
    moveCurrentWindow({x = 0, y = 0, w = 0.5, h = 1})  -- 左半分
end)

hs.hotkey.bind(modifierShift, "x", function()
    moveCurrentWindow({x = 0.5, y = 0, w = 0.5, h = 1})  -- 右半分
end)

-- 1/3 (A/S/D)
hs.hotkey.bind(modifierShift, "a", function()
    moveCurrentWindow({x = 0, y = 0, w = 0.33, h = 1})  -- 左 1/3
end)

hs.hotkey.bind(modifierShift, "s", function()
    moveCurrentWindow({x = 0.33, y = 0, w = 0.34, h = 1})  -- 中央 1/3
end)

hs.hotkey.bind(modifierShift, "d", function()
    moveCurrentWindow({x = 0.67, y = 0, w = 0.33, h = 1})  -- 右 1/3
end)

-- フルスクリーン (F)
hs.hotkey.bind(modifierShift, "f", function()
    moveCurrentWindow({x = 0, y = 0, w = 1, h = 1})
end)

-- 中央 70% (C)
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
-- 起動完了
--------------------------------------------------------------------------------

hs.alert.show("Hammerspoon 設定を読み込みました")
