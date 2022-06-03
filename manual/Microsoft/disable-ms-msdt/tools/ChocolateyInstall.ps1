if (Get-IsWinWorkstation) {
	if ((Test-Path REGISTRY::HKEY_CLASSES_ROOT\ms-msdt) -eq $true){
		Write-Host "Non-compliant with (CVE-2022-30190) Remove-Item ms-msdt now..." -ForegroundColor "Magenta"
		Remove-Item REGISTRY::HKEY_CLASSES_ROOT\ms-msdt -Recurse -Force
		Write-Host "Compliant with (CVE-2022-30190)" -ForegroundColor "Green"
	} else {
		Write-Host "Now Compliant with (CVE-2022-30190)" -ForegroundColor "Green"
	}
} else {
	Write-Host "Not required on Windows Server" -ForegroundColor "Magenta"
}
