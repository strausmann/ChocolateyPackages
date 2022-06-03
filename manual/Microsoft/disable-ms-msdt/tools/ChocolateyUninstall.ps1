$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (Get-IsWinWorkstation) {
	if ((Test-Path REGISTRY::HKEY_CLASSES_ROOT\ms-msdt) -eq $false){
		Write-Host "ms-msdt: entry not found, the entry is restored in the registry..." -ForegroundColor "Magenta"
		#Start-Process -FilePath "$env:windir\regedit.exe" -Argumentlist @("/s", "backup-ms-msdt.reg") -Wait -PassThru
		$Ergebnis = (Start-Process -FilePath "reg.exe" -ArgumentList "IMPORT $toolsDir/backup-ms-msdt.reg" -NoNewWindow -PassThru -Wait ).ExitCode
		Write-Host "ExitCode $Ergebnis"
	} else {
		Write-Host "ms-msdt: entry found, recovery of the entry in the Windows Registry not required." -ForegroundColor "Green"
	}
} else {
	Write-Host "Not required on Windows Server" -ForegroundColor "Magenta"
}