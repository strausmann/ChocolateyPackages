if (Get-IsWinWorkstation) {
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 1 -Force -ErrorAction SilentlyContinue | out-null
	Write-Host "HiberbootEnabled successfully disabled." -ForegroundColor "Magenta"
}