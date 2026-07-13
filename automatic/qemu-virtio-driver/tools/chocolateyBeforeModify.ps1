$ErrorActionPreference = 'Continue';

# Vor Upgrade/Uninstall (Issue #11): den bei Install registrierten VirtIO Balloon
# Service wieder entfernen, solange blnsvr.exe noch existiert (MSI-Uninstall raeumt
# die Dateien erst danach). Best-effort.
if (Get-Service -Name 'BalloonService' -ErrorAction SilentlyContinue) {
  $blnsvr = @($env:ProgramW6432, $env:ProgramFiles, ${env:ProgramFiles(x86)}) | Where-Object { $_ } | Select-Object -Unique |
    ForEach-Object { Join-Path $_ 'Virtio-Win\Balloon' } | Where-Object { Test-Path $_ } |
    ForEach-Object { Get-ChildItem -Path $_ -Recurse -Filter 'blnsvr.exe' -ErrorAction SilentlyContinue } |
    Select-Object -First 1
  if ($blnsvr) { try { & $blnsvr.FullName '-u' } catch { } }
}
