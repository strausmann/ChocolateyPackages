$ErrorActionPreference = 'Stop'

# --- Constants / paths ---
$installDirCurrent = Join-Path $env:LOCALAPPDATA 'Programs\CyberBrick'
$uninstallerName   = 'Uninstall CyberBrick.exe'
$tempWD            = $env:TEMP

# --- 0) Ensure we are NOT inside the install directory (prevents folder locks) ---
if ($PWD.Path -like "$installDirCurrent*") { Set-Location $tempWD }

# --- 1) Stop running processes to avoid uninstaller errors ---
Get-Process CyberBrick -ErrorAction SilentlyContinue | Stop-Process -Force

# --- Helper: invoke uninstaller with enforced silent switch and neutral WorkingDirectory ---
function Invoke-UninstallCmd {
  param([string]$CmdLine)

  if (-not $CmdLine) { return 1 }

  # Split into exe and args
  $exe  = $CmdLine
  $args = ''
  if ($CmdLine.StartsWith('"')) {
    $parts = $CmdLine -split '"'
    $exe   = $parts[1]
    $args  = ($parts[2..($parts.Length-1)] -join '"').Trim()
  } else {
    $parts = $CmdLine -split ' '
    $exe   = $parts[0]
    $args  = ($parts[1..($parts.Length-1)] -join ' ').Trim()
  }

  # Force silent switch if not present
  if ($args -notmatch '(/S|/VERYSILENT)') { $args = ($args.Trim() + ' /S').Trim() }

  if (-not (Test-Path $exe)) {
    Write-Warning "Uninstaller not found: $exe"
    return 1
  }

  $p = Start-Process -FilePath $exe -ArgumentList $args -WorkingDirectory $tempWD -PassThru -Wait -NoNewWindow
  return ($p.ExitCode)
}

# --- 2) Gather uninstall commands from registry (HKCU/HKLM/HKU) ---
$regPaths = @(
  'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
  'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
  'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

# Include all loaded user hives (other profiles)
$hkuRoots = Get-ChildItem 'HKU:\' -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'S-1-5-21-' }
foreach ($hku in $hkuRoots) {
  $regPaths += (Join-Path $hku.PSPath 'Software\Microsoft\Windows\CurrentVersion\Uninstall\*')
}

$cmdLines = [System.Collections.Generic.HashSet[string]]::new()
foreach ($path in $regPaths) {
  $entries = Get-ItemProperty $path -ErrorAction SilentlyContinue |
    Where-Object { $_.DisplayName -and ($_.DisplayName -like '*CyberBrick*') }
  foreach ($e in $entries) {
    $cmd = if ($e.QuietUninstallString) { $e.QuietUninstallString } else { $e.UninstallString }
    if ($cmd) { [void]$cmdLines.Add($cmd) }
  }
}

# --- 3) Fallback: locate uninstallers directly on disk across profiles ---
if ($cmdLines.Count -eq 0) {
  $candidates = @()
  $candidates += Get-ChildItem 'C:\Users\*\AppData\Local\Programs\CyberBrick\Uninstall*.exe' -ErrorAction SilentlyContinue
  $candidates += Get-ChildItem "$env:ProgramFiles\CyberBrick\uninstall*.exe" -ErrorAction SilentlyContinue
  $candidates += Get-ChildItem "$env:ProgramFiles(x86)\CyberBrick\uninstall*.exe" -ErrorAction SilentlyContinue

  foreach ($u in ($candidates | Select-Object -Unique)) {
    [void]$cmdLines.Add(('"{0}" /S' -f $u.FullName))
  }
}

# --- 4) Execute all discovered uninstallers (handles multi-user installs) ---
$hadAny = $false
foreach ($cmd in $cmdLines) {
  $hadAny = $true
  Write-Host "Uninstalling via: $cmd"
  $code = Invoke-UninstallCmd -CmdLine $cmd
  if ($code -ne 0) {
    Write-Warning "Uninstaller exit code: $code"
  }
}

if (-not $hadAny) {
  Write-Warning 'No CyberBrick uninstall entry or uninstaller executable was found.'
}

# --- 5) Post-cleanup ---

# a) Remove the current user’s installation directory if it still exists
if (Test-Path $installDirCurrent) {
  try {
    Remove-Item $installDirCurrent -Recurse -Force -ErrorAction Stop
  } catch {
    Write-Warning "Could not remove folder '$installDirCurrent'. Scheduling cleanup on next logon..."
    $cleanupCmd = 'cmd.exe /c rmdir /s /q "' + $installDirCurrent + '"'
    New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce' `
      -Name 'CyberBrickCleanup' -Value $cleanupCmd -PropertyType String -Force | Out-Null
  }
}

# c) Remove the CLI shim (if created)
try { Uninstall-BinFile -Name 'cyberbrick' -ErrorAction SilentlyContinue } catch {}

Write-Host 'CyberBrick has been uninstalled (best effort across profiles).'
