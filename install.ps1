#Requires -PSEdition Core
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
        dest = "C:\utils\autohotkey"
    }
}

$configFiles.Keys | ForEach-Object {
    $srcPath  = $configFiles[$_].src
    $destPath = $configFiles[$_].dest

    if (-Not (Test-Path -Path $destPath)) {
        New-Item `
            -Type SymbolicLink `
            -Path $destPath `
            -Target (Resolve-Path $srcPath) `
            | Out-Null

        Write-Host -ForegroundColor Green `
            ("Installed:`t{0}" -f $destPath)
    }
    else {
        Write-Host -ForegroundColor Red `
            ("Skipping:`t{0}" -f $destPath)
    }
}
