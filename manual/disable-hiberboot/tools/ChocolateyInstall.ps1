if (Get-IsWinWorkstation) {
	if (((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -ErrorAction SilentlyContinue).HiberbootEnabled) -match "0"){
		Write-Host "HiberbootEnabled are disabled." -ForegroundColor "Green"
	} else {
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Force | out-null
		Write-Host "HiberbootEnabled successfully disabled." -ForegroundColor "Magenta"
	}
} else {
	Write-Host "The use on a Windows Server is not possible." -ForegroundColor "Magenta" 
}