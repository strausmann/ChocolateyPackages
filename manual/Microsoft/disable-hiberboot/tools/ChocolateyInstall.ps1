$valueName = "HiberbootEnabled"
if ((Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name $valueName -ErrorAction SilentlyContinue) -match "0"){
    Write-Host "HiberbootEnabled are disabled." -foreground "magenta"
} else {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name $valueName -Value 0 -Force | out-null
	Write-Host "HiberbootEnabled successfully disabled." -foreground "magenta"
}