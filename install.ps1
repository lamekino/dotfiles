#Requires -PSEdition Core
<#
    Script that installs/uninstalls configs for windows
#>
param (
    [bool] $Uninstall = $false,
    [System.Path] $UtilDir = "C:\utils"
)

$configFiles = @{
    "nvim" = @{
        src  = ".\nvim\.config\nvim"
        dest = "$env:APPDATA\..\Local\nvim"
    }
    "powershell" = @{
        src  = ".\powershell\Microsoft.PowerShell_profile.ps1"
        dest = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    }
    "alacritty" = @{
        src  = ".\alacritty\.config\alacritty"
        dest = "$env:APPDATA\alacritty"
    }
    "autohotkey" = @{
        src  = ".\autohotkey"
        dest = "$UtilDir\autohotkey"
    }
}


if (-not $isWindows)
{
    Write-Host -ForegroundColor Red `
        "This needs to be ran on a windows host!"
    Exit
}

# The function to run for installation
$installCmd = {
    $srcPath = $arg[0]
    $destPath = $arg[1]

    if (Test-Path -Path $srcPath)
    {
        Write-Host -ForegroundColor Red ("Skipping:`t{0}" -f $destPath)
        return
    }

    New-Item `
        -Type SymbolicLink `
        -Path $destPath `
        -Target (Resolve-Path $srcPath) `
    | Out-Null
    Write-Host -ForegroundColor Green  ("Installed:`t{0}" -f $destPath)
}

# The function to run for uninstallation
$uninstallCmd = {
    $srcPath = $arg[0]

    if (-Not (Test-Path -Path $srcPath))
    {
        Write-Host -ForegroundColor Red ("Skipping:`t{0}" -f $srcPath)
        return
    }
    Remove-Item -Recurse -Path $args[0] | Out-Null
    Write-Host -ForegroundColor Yellow ("Uninstalled:`t{0}" -f $srcPath)
}

action = $installCmd
if ($Uninstall)
{
    action = $uninstallCmd
}

# iterate over the config file map and perform the action specified
$configFiles.Keys | ForEach-Object {
    $srcPath  = $configFiles[$_].src
    $destPath = $configFiles[$_].dest

    action.Invoke($srcPath, $destPath)
}
