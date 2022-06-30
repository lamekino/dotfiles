#Requires -PSEdition Core
# Powershell profile, because windows is the best OS ever... NOT
# Readline: {{{
Set-PSReadLineOption -Colors @{
    Command            = 'DarkGreen'
    Number             = 'Magenta'
    Member             = 'Yellow'
    Operator           = 'DarkYellow'
    Type               = 'DarkRed'
    Variable           = 'Green'
    Parameter          = 'DarkCyan'
    ContinuationPrompt = 'DarkGray'
    Default            = 'White'
    Comment            = 'Gray'
}
Set-PSReadlineOption -EditMode vi
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# }}}
# Variables: {{{
# append PATH
@(
    "$env:USERPROFILE\.cargo\bin"
    "C:\utils\ghcup\bin"
    "C:\Program Files\LLVM\bin"
    "C:\utils\chocolately\ghc-9.2.3\bin"
    "C:\Program Files\Rust stable MSVC 1.61\bin"
    "C:\Program Files\Go\bin"
    "C:\utils\luarocks-3.9.0"
    "C:\Program Files (x86)\Lua\5.1"
) | ForEach-Object {
    if (-not $env:PATH.contains($_)) {
        $env:PATH += (";{0}" -f $_)
    }
}

# Set misc env variables
$env:STACK_ROOT = "C:\utils\haskell-stack\root"
$env:NVIMFILES = "$env:userprofile\AppData\Local\nvim"
$env:EDITOR = "nvim"
$env:VISUAL = "nvim-qt"
$env:RIPGREP_CONFIG_PATH = "$env:userprofile\AppData\Roaming\ripgrep\config"
# }}}
# Prompt: {{{
function Prompt {
    $dir = $(Get-Location).tostring().replace($env:userprofile, "~")
    $user = $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name.toLower())
    return "`e[1;35m$user`e[0m `e[1;34m$dir`e[0m`e[0;33m>>`e[0m "
}
# }}}
# Functions: {{{
function ..() {
    $n = [int] $args[0] - 1
    $parents = "../"
    for ($i = 0; $i -lt $n; $i++) {
        $parents += "../"
    }

    Set-Location $parents
}

# Improved Get-Command
function which() {
    try {
        $cmd = (Get-Command $args[0])
    }
    catch {
        Write-Host "Not found."
    }
    switch ($cmd.CommandType) {
        "Application" { $cmd.Source.replace("\", "/") }
        "Alias"       { $cmd.DisplayName }
        "Function"    { $cmd.ScriptBlock | bat -P --style plain -l powershell }
        Default       { $cmd.CommandType }
    }
}

# function dos2unix() {
#     $args | ForEach-Object {
#         # need to check if folder or file and that it exists
#         nvim.exe -U NONE +':w ++ff=unix' +':q' "$_"
#     }
# }

function cite() { . $profile }
function linux() { wsl ~ -d $args[0] }
function lsusb() { Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } }
function ppath() { $env:path.replace(";", "`n") }
# }}}
# Aliases: {{{
Set-Alias vim "nvim.exe" # this needs to be in the $PATH
Set-Alias sudo "gsudo"
Set-Alias open "explorer.exe"
Set-Alias find "C:\Program Files\Git\usr\bin\find.exe"
Set-Alias rm "C:\Program Files\Git\usr\bin\rm.exe"
Set-Alias grep "rg.exe"
Set-Alias neofetch winfetch
Set-Alias lsblk Get-PSDrive
Set-Alias realpath Resolve-Path
Set-Alias reboot Restart-Computer
Set-Alias poweroff Stop-Computer
# remove all the aliases I don't like
{
    $args | ForEach-Object {
        if (Test-Path -Path "Alias:\$_") {
            Remove-Alias -Force $_
        }
    }
}.Invoke("sl", "dir", "dir") # this has to be done twice???
# }}}
# Startup: {{{
# NOTE: there is probably a better way to do this, ie check if in a script, this
# is how we'll go for now
# Write-Host -NoNewLine -ForegroundColor Red "¯\_(ツ)_/¯ "
# Write-Host -NoNewLine -ForegroundColor DarkYellow "¯\_(ツ)_/¯ "
# Write-Host -NoNewLine -ForegroundColor Yellow "¯\_(ツ)_/¯ "
# Write-Host -NoNewLine -ForegroundColor Green "¯\_(ツ)_/¯ "
# Write-Host -NoNewLine -ForegroundColor Blue "¯\_(ツ)_/¯ "
# Write-Host -NoNewLine -ForegroundColor Magenta "¯\_(ツ)_/¯ "
if (Test-Path -Path "$HOME\Documents\Powershell\Additional.ps1") {
    . "$HOME\Documents\Powershell\Additional.ps1"
}
# }}}
# vim:foldmethod=marker
