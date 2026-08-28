$ErrorActionPreference	= 'Stop';

$url					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.302-1/virtio-win-gt-x86.msi'
$checksum				= '91304cc747cb13abb34accb5b449e906ab6e9474f54193f340eb8e1f4cfbcc02'
$checksumType           = 'sha256'
$url64					= 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.302-1/virtio-win-gt-x64.msi'
$checksum64				= '4f4388468a7ac5286bd1f1924ef02e7281a60a600390a7cfcfd55809efc0889f'
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
