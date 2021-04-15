# https://qiita.com/kumarstack55/items/06e1e7e4557a597e3768

# Toast通知のツール "toaster" をインストールする
# https://github.com/onokit/toaster を使わないのは、通知時間の有効期限切れの機能をPRしてマージいただくことができていないため。
# パス長が長くならないよう、ここではc:\を指定する。
cd c:\
git clone https://github.com/kumarstack55/toaster.git

# Toast通知用のXMLをインストールする
cd c:\
git clone https://github.com/kumarstack55/windows-toast-xml.git

# 作成するタスク名
$TaskName = "my-task-toast-hourly"

# タスクスケジューラーでタスク名の重複は許されないため、
# すでに同名のタスクがあれば消す
Get-ScheduledTask -TaskName $TaskName | Unregister-ScheduledTask

# パスを設定する
$LauncherPath = "C:\toaster\powershellLauncher.vbs"
$XmlPath = "C:\windows-toast-xml\xml\hourly-notification.xml"
$ToasterPath = "C:\toaster\toaster.ps1"
$WorkingDirectory = "C:\toaster"

# 毎時分のタスクスケジューラに登録する
$TriggerArray = @()
0..23 |
ForEach-Object {
    $Hour = $_
    @(0, 30) |
    ForEach-Object {
        $Minute = $_
        $At = Get-Date -Hour $Hour -Minute $Minute -Second 0 -Millisecond 0
        $TriggerArray += New-ScheduledTaskTrigger -Daily -At $At
    }
}
$Action = New-ScheduledTaskAction `
    -Execute $LauncherPath `
    -Argument "$ToasterPath -XmlPath $XmlPath -ExpirationDurationMinutes 55" `
    -WorkingDirectory $WorkingDirectory
Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $TriggerArray

# 次回実行時刻を確認する
Get-ScheduledTaskInfo -TaskName $TaskName
