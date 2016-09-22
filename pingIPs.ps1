<#
.SYNOPSIS
Pings a list of IP addreses and reports which are alive and which are dead.
.DESCRIPTION
The ping IP script pings a list of IP addresses (stored in a text file) and provides an output (stored in a csv file) of which IP addresses are alive and dead as well as the time stamp that the ping occurred.
.PARAMETER ipList
A string containing the path and file name to a list of IPs stored in a text file.
.PARAMETER outputPath
A string containing the path and file name where the results will be saved.  File must be a csv.
.EXAMPLE
.\pingIPs.ps1 C:\Users\user1\Documents\ipList.txt C:\Users\user1\Documents\ipListOutput.csv
#>
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
