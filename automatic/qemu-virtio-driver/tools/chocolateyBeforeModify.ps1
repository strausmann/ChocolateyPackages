$ErrorActionPreference = 'Continue';

# Vor Upgrade/Uninstall (Issue #11): den bei Install registrierten VirtIO Balloon
# Service wieder entfernen, solange blnsvr.exe noch existiert (MSI-Uninstall raeumt
# die Dateien erst danach). Best-effort.
if (Get-Service -Name 'BalloonService' -ErrorAction SilentlyContinue) {
  $blnsvr = Get-ChildItem -Path (Join-Path $env:ProgramFiles 'Virtio-Win\Balloon') -Recurse -Filter 'blnsvr.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($blnsvr) { try { & $blnsvr.FullName '-u' } catch { } }
}
