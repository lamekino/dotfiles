#Requires -PSEdition Core
$settings = @{
    highlightColor = "White"

    environmentVars = @{
        PAGER = "less"
        EDITOR = "nvim"
        VISUAL = "nvim-qt"
        MSYS2_ROOT = "C:\tools\msys64"
        UNIX_TOOLCHAIN = "C:\tools\msys64"
    }

    additionalPaths = @(
        "$env:USERPROFILE\.cargo\bin"
        "C:\Program Files\LLVM\bin"
        "C:\Program Files\CMake\bin"
    )

    removeAliases = @(
        "dir", "dir", "sl", "cls"
    )

    sourceDirs = @(
        Split-Path -Parent $profile
    )

    excludeSourceFiles = @(
        Split-Path -Leaf $profile
    )

    unixCmds = @{
        "\usr\bin\" = @(
            "rm", "find", "grep", "file"
        )
    }
}

function Prompt {
    $dir = $(Get-Location).tostring().replace($env:USERPROFILE, "~")
    $branch = (git branch --show-current 2>nul)

    if ($branch.Length -gt 0) {
        $unstaged = (git status --short | Measure-Object -Line).Lines
        if ($unstaged -gt 0) {
            $branch = ("`e[1;35m@{0}+{1}`e[0m:" -f $branch, $unstaged)
        }
        else {
            $branch = ("`e[1;32m@{0}`e[0m:" -f $branch)
        }
    }
    return ("{0}`e[1;34m{1}`e[0m> " -f $branch, $dir)
}

# set colors to be the same
Get-PSReadLineOption
    | Get-Member
    | Where-Object { $_.Name -like "*Color" }
    | ForEach-Object {
        (Get-PSReadLineOption).($_.Name) = $settings.highlightColor
    }
Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -PredictionSource None
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

$settings.environmentVars.Keys | ForEach-Object {
    [void](New-Item -Path "Env:\$_" -Value $settings.environmentVars[$_])
}

$settings.additionalPaths | ForEach-Object {
    $env:PATH += (";{0}" -f $_)
}

$settings.unixCmds.GetEnumerator() | ForEach-Object {
    $path = $_.Key
    $_.Value | ForEach-Object {
        Set-Alias $_ ($env:UNIX_TOOLCHAIN + $path + $_ + ".exe")
    }
}

Set-Alias vim "nvim.exe"
Set-Alias sudo "gsudo.exe"
Set-Alias open "explorer.exe"

Set-Alias lsblk Get-PSDrive
Set-Alias realpath Resolve-Path
Set-Alias reboot Restart-Computer
Set-Alias poweroff Stop-Computer

$settings.removeAliases | ForEach-Object {
    if (Test-Path -Path "Alias:\$_") {
        Remove-Alias -Force $_
    }
}

Get-ChildItem `
    -File `
    -Filter "*.ps1" `
    -Path $settings.sourceDirs `
    -Exclude $settings.excludeSourceFiles `
| ForEach-Object {
    . $_
}

# Remove-Variable settings

if (Get-Command -ErrorAction SilentlyContinue "zoxide") {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
