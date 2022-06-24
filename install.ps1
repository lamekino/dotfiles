#Requires -PSEdition Core
$configFiles = @{
    "nvim" = @{
        src  = ".\nvim\.config\nvim"
        dest = "$env:APPDATA\..\Local\nvim"
    }
    "powershell" = @{
        src  = ".\powershell\.config\powershell\Microsoft.PowerShell_profile.ps1"
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
    if (-Not (Test-Path -Path $configFiles[$_].dest)) {
        New-Item -Type SymbolicLink `
            -Path $configFiles[$_].dest `
            -Target (Resolve-Path $configFiles[$_].src) `
            | Out-Null

        Write-Host -ForegroundColor Green `
            ("Installed:`t{0}" -f $configFiles[$_].dest)
    }
    else {
        Write-Host -ForegroundColor Red `
            ("Skipping:`t{0}" -f $configFiles[$_].dest)
    }
}
