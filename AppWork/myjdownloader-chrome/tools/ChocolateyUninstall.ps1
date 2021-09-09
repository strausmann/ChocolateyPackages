$bits = Get-ProcessorBits
$packageName = 'jdownloader-chrome'
$extensionID = 'fbcohnmimjicjdomonkcbcpbpnhggkip'

if ($bits -eq 64){
	Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}else{
	Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}
Write-Host "Extension successfully uninstalled." -foreground "magenta"