$valueName = 'HiberbootEnabled'

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name $valueName -Value 1 -Force -ErrorAction SilentlyContinue | out-null
Write-Host "HiberbootEnabled successfully disabled." -foreground "magenta"