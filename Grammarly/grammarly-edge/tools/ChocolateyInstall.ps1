$extensionID = 'cnlefmmeadmemmdciolhbnfeacpdfbkd'
$valueName = '31885'
if (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" -Name $valueName -ErrorAction SilentlyContinue){
    Write-Host "Extension already installed." -foreground "magenta"
} else {
    New-Item -Force -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" | out-null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" -Name $valueName -Value $extensionID -Force | out-null
	Write-Host "Extension successfully installed." -foreground "magenta"
}