# Init file for powershell

# https://qiita.com/smicle/items/0ca4e6ae14ea92000d18
Set-PSReadLineOption -EditMode Emacs -BellStyle None

# https://qiita.com/smicle/items/0ca4e6ae14ea92000d18
function prompt {
    $isRoot = (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
        $color  = if ($isRoot) {"Red"} else {"Green"}
    $marker = if ($isRoot) {"#"}   else {"$"}

    Write-Host "$env:USERNAME " -ForegroundColor $color -NoNewline
        Write-Host "$pwd " -ForegroundColor Magenta -NoNewline
        Write-Host $marker -ForegroundColor $color -NoNewline
        return " "
}

# ls shortcut
function l {
    Get-ChildItem $args -Exclude .*  | Format-Wide Name -AutoSize
}
function s {
    l
}
