$msuData = @{
    '10.0.18362' = @{
        Url = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2020/03/windows10.0-kb4554364-x86_f863a4d7845e249f3b0d087839b62da60262af62.msu"
        Checksum = 'B14DCE9222BD6F7734A16949AD27D216A5108982238BDDF081CF2F14B1A7CA6B'
        Url64 = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2020/03/windows10.0-kb4554364-x64_0037f0861430f0d9a5cea807b46735c697a82d0c.msu"
        Checksum64 = '49F2FBDCBCE803D52B984567E95B10A25CD0DEC1F5C1C128DE1B5FD78B540B3B'
    }
    '10.0.18363' = @{
        Url = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2020/03/windows10.0-kb4554364-x86_f863a4d7845e249f3b0d087839b62da60262af62.msu"
        Checksum = 'B14DCE9222BD6F7734A16949AD27D216A5108982238BDDF081CF2F14B1A7CA6B'
        Url64 = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2020/03/windows10.0-kb4554364-x64_0037f0861430f0d9a5cea807b46735c697a82d0c.msu"
        Checksum64 = '49F2FBDCBCE803D52B984567E95B10A25CD0DEC1F5C1C128DE1B5FD78B540B3B'
    }
}

chocolateyInstaller\Install-WindowsUpdate -Id 'KB4554364' -MsuData $msuData -ChecksumType 'sha256'