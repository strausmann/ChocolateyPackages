$extensionID = 'cnlefmmeadmemmdciolhbnfeacpdfbkd'
$valueName = '31885'

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" -Name $valueName -Force -ErrorAction SilentlyContinue | out-null
Write-Host "Extension successfully uninstalled." -foreground "magenta"