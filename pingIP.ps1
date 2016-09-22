param([string]$ipList, [string]$outputPath)
$servers = Get-Content $ipList

$collection = $()

foreach ($server in $servers)
{
    $status = @{ "ServerName" = $server; "TimeStamp" = (Get-Date -f s) }

    if (Test-Connection $server -Quiet)
    { 
        $status["Results"] = "alive"
    } 
    else 
    { 
        $status["Results"] = "dead" 
    }

    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus
}

$collection | Export-Csv -LiteralPath $outputPath -NoTypeInformation
