$ErrorActionPreference	= 'Stop';

$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-gt-x86.msi'
$checksum				= 'e2ee7bc04e24ed3a3c90d573b75e5e809846db3c4de4e78655c1cc77ad2e2a3d'
$checksumType           = 'sha256'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-gt-x64.msi'
$checksum64				= 'fafd93cb12b8a5df2668d3459d8b5589e7195a28424f9a40e16b50f462cf8fab'
$checksumType64         = 'sha256'

$packageArgs = @{
	packageName    = $env:ChocolateyPackageName
	installerType  = 'msi'
	softwareName   = 'Virtio-win-driver-installer*'
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
	url            = $url
	checksum       = $checksum
	checksumType   = $checksumType
	url64bit       = $url64
	checksum64     = $checksum64
	checksumType64 = $checksumType64
	validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
# --- VirtIO Balloon Service (Issue #11) ---
# Die virtio-win-gt MSI installiert blnsvr.exe, registriert den Dienst 'BalloonService'
# aber nicht -> ohne ihn liefert der Gast keine Memory-Stats / kein dynamisches
# Ballooning (z.B. Proxmox). Idempotent: nur registrieren, wenn der Dienst noch fehlt.
if (-not (Get-Service -Name 'BalloonService' -ErrorAction SilentlyContinue)) {
  $blnsvr = @($env:ProgramW6432, $env:ProgramFiles, ${env:ProgramFiles(x86)}) | Where-Object { $_ } | Select-Object -Unique |
    ForEach-Object { Join-Path $_ 'Virtio-Win\Balloon' } | Where-Object { Test-Path $_ } |
    ForEach-Object { Get-ChildItem -Path $_ -Recurse -Filter 'blnsvr.exe' -ErrorAction SilentlyContinue } |
    Select-Object -First 1
  if ($blnsvr) {
    Write-Host "Registering VirtIO Balloon Service: $($blnsvr.FullName) -i"
    & $blnsvr.FullName '-i'
  } else {
    Write-Warning "blnsvr.exe not found under '$env:ProgramFiles\Virtio-Win\Balloon' - Balloon service not registered."
  }
}

# InstallService setzt Auto-Start, startet aber nicht zwingend sofort -> sicher starten.
$balloonSvc = Get-Service -Name 'BalloonService' -ErrorAction SilentlyContinue
if ($balloonSvc -and $balloonSvc.Status -ne 'Running') {
  try { Start-Service -Name 'BalloonService' -ErrorAction Stop }
  catch { Write-Warning "Could not start BalloonService: $($_.Exception.Message)" }
}
