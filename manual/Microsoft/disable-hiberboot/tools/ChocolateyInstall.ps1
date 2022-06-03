if (Get-IsWinWorkstation) {
	if (((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -ErrorAction SilentlyContinue).HiberbootEnabled) -match "0"){
		Write-Host "HiberbootEnabled are disabled." -ForegroundColor "Green"
	} else {
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name $valueName -Value 0 -Force | out-null
		Write-Host "HiberbootEnabled successfully disabled." -ForegroundColor "Magenta"
	}
}