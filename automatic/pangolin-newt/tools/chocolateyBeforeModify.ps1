$ErrorActionPreference = 'Continue';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe = Join-Path $toolsDir 'newt.exe'

# Laeuft vor Upgrade UND Uninstall: Dienst best-effort stoppen + entfernen,
# damit die exe fuer Upgrades entsperrt ist und kein verwaister Dienst zurueckbleibt.
# Fehler ignorieren (z.B. wenn nie ein Dienst eingerichtet wurde).
if (Test-Path $exe) {
  try { & $exe stop   2>$null | Out-Null } catch { }
  try { & $exe remove 2>$null | Out-Null } catch { }
}
