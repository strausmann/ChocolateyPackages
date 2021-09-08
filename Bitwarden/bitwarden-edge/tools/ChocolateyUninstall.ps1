$extensionID = 'jbkfoedolllekgbhcbcoahefnbanhhlh'
$valueName = '318851'

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" -Name $valueName -Force -ErrorAction SilentlyContinue | out-null
Write-Host "Extension successfully uninstalled." -foreground "magenta"