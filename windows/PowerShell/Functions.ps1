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
