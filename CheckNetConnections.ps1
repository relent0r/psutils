function Main() 
{
    $CurrentScriptVersion = "1.0"

    Write-Host "================== Checking Network Connections =================="
    Write-Host
    $server = get-content env:computername
    $logPath = "d:\ServiceLogs\ServerNetworkConnections"
    if ( Test-Path $logPath -PathType Container ) 
        { 
        "Log path already exist" 
        }
    else
        {
        New-Item -Path $logPath  -ItemType directory
        "Log path folder created"
        }
    try {        
        $netobj = get-nettcpconnection | Where {$_.State -eq 'Established' -or $_.State -eq 'TimeWait'}
        $netConnCount = $netobj.count	
		$dateobj = get-date
        $date = $dateobj.ToString("yyyy-MM-ddTHH:mm:ss.fff")
		$body = @{
            applicationName = "ServerNetworkConnections"
            date = "$date"
            server = "$server"
            numConnections = $netConnCount
            message = "$server has $netConnCount connections in an Established or Time Wait state"
            }
        $logFileName = 'netConn-' + $dateobj.ToString("yyyy-MM-dd") + '.txt'
        $body | ConvertTo-Json -compress | Out-File -append "$logPath\$logFileName" -Encoding Ascii
        
    } 
    catch [System.Exception] {
        Write-Output $_
        Exit 1
    }

    Write-Host "================== Network Connection : END =================="
}

Main