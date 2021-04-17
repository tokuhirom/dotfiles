# Init file for powershell

# $Env:Path で環境変数確認可能

Import-Module PSReadline

# Reload powershell profile:
#
#   & $profile

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
# Remove deafult Powershell's alias. It's too verbose and not useful.
remove-item alias:ls  -Recurse -ErrorAction Ignore

function l {
    ls
}
function s {
    l
}

# invoke commands
function cheat { perl $HOME/dotfiles/bin/cheat @Args }

# Setup environment variable Path
Set-Item Env:Path "$Env:Path;C:\Strawberry\perl\bin"

# Set EDITOR and PAGER as code(Visual Studio Code)
Set-Item Env:CHEAT_EDITOR "code"
Set-Item Env:CHEAT_PAGER "code"

# Login to LINE gateway
function kerb { ssh igw1.linecorp.com @Args }


# -----------------------------------------------------------------------------
#
# Prompt configuration
#
# -----------------------------------------------------------------------------

# Install:
#
#   Install-Module -Name posh-git

Import-Module posh-git

function prompt {
    $prompt = & $GitPromptScriptBlock
    if ($prompt) { "$prompt " } else { " " }
}

$global:GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
# $global:GitPromptSettings.DefaultPromptPath.ForegroundColor = 0xFFA500
# $global:GitPromptSettings.DefaultPromptWriteStatusFirst = $true
$global:GitPromptSettings.EnableFileStatus = $false

# -----------------------------------------------------------------------------
#
# ssline for powershell
#
# -----------------------------------------------------------------------------

function ss-farm-list() {
    $url = 'http://dav.navercorp.jp/data/facility/pmc.farm.active.info'
    return (Invoke-WebRequest $url).Content
}

function ss-login() {
    $hostname = $args[0]
    ssh -t tokuhirom@igw1.linecorp.com ssline $hostname
}

function ssline() {
    if ($args.Count -eq 1) {
        ss-login $args[0]
    } else {
        $local = perl -ale 'print $F[0], q/ /, $F[0]' $HOME\.itsc-servers
        $pmc = ss-farm-list | egrep 'cms|dmp|taxi|jrr|biz|connector|ansible|sticker|poi|bot-dispatcher|notify|switcher|adp|redirect|lad|lass|lasm|kakyoin'
        $hostname = $local + $pmc | peco | perl -lane 'print $F[1]'
        ss-login $hostname
    }
}

# -----------------------------------------------------------------------------
#
# Utils
#
# -----------------------------------------------------------------------------

function epoch() { perl $HOME/dotfiles/bin/epoch @Args }

# -----------------------------------------------------------------------------
#
# Environment variables
#
# -----------------------------------------------------------------------------
$env:Path += ";C:\Program Files\nodejs"
