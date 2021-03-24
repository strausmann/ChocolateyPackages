$msuData = @{
    '10.0.19041' = @{
        Url = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x86_bafeb1bea06a5f39976de3406d3e33fb3cc2c6fe.msu"
        Checksum = '488A4EB66FA841694948D8365823622541115430BCC76AEC31A1855D4B095026'
        Url64 = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"
        Checksum64 = '8554CF4597FEA8F77288132513A04178266DE90B0F4BA79E1A95D8434E8DF6AF'
    }
    '10.0.19042' = @{
        Url = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x86_bafeb1bea06a5f39976de3406d3e33fb3cc2c6fe.msu"
        Checksum = '488A4EB66FA841694948D8365823622541115430BCC76AEC31A1855D4B095026'
        Url64 = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"
        Checksum64 = '8554CF4597FEA8F77288132513A04178266DE90B0F4BA79E1A95D8434E8DF6AF'
    }
}

chocolateyInstaller\Install-WindowsUpdate -Id 'KB5001567' -MsuData $msuData -ChecksumType 'sha256'