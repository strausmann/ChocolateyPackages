$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/fosrl/newt/releases/download/1.17.0/newt_windows_amd64.exe'
$checksum64 = 'd4dfa24908d6f96e9cc4b1bbc03dbfb41ae5e25bff238dd01fabbc2bd45fea35'

$exe = Join-Path $toolsDir 'newt.exe'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exe
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

# Optionaler Windows-Dienst: nur wenn Id + Secret + Endpoint uebergeben wurden
$pp       = Get-PackageParameters
$id       = $pp['Id']
$secret   = $pp['Secret']
$endpoint = $pp['Endpoint']

if ($id -and $secret -and $endpoint) {
  Write-Host "Registriere Newt als Windows-Dienst 'Newt WireGuard Tunnel Service'..."
  & $exe install
  # 'newt start' persistiert die Credentials nach %PROGRAMDATA%\newt\service_args.json
  # und startet den Dienst damit. (Secret liegt danach dort im Klartext - by design.)
  & $exe start --id $id --secret $secret --endpoint $endpoint
  Write-Host "Newt-Dienst installiert und gestartet."
} else {
  Write-Host @"

newt.exe wurde installiert und ist als 'newt' im PATH verfuegbar.
Es wurde KEIN Windows-Dienst eingerichtet (keine /Id /Secret /Endpoint uebergeben).

Dienst manuell einrichten:
  newt install
  newt start --id <SITE_ID> --secret <SECRET> --endpoint https://<pangolin-host>

Oder mit Parametern neu installieren:
  choco install pangolin-newt.portable --params "/Id:<id> /Secret:<secret> /Endpoint:https://<host>"

"@
}
