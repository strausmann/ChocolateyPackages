if (Get-IsWinWorkstation) {
	if ((Test-Path REGISTRY::HKEY_CLASSES_ROOT\ms-msdt) -eq $false){
		Write-Host "ms-msdt: entry not found, the entry is restored in the registry..." -ForegroundColor "Magenta"
		Start-Process -filepath "$env:windir\regedit.exe" -Argumentlist @("/s", "`"backup-ms-msdt.reg`"")
	} else {
		Write-Host "ms-msdt: entry found, recovery of the entry in the Windows Registry not required." -ForegroundColor "Green"
	}
} else {
	Write-Host "Not required on Windows Server" -ForegroundColor "Magenta"
}