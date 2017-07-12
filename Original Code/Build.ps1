#Landscape
#OLRoot - "offline", non-domain-joined
#ENTSub - domain-joined subordinate CA
#DC1 - domain controller

$OLRoot = "olroot.company.pri"
$Entsub = "EntSub"
$DC = "DC1"

#The build:
#https://technet.microsoft.com/en-us/library/hh831348(v=ws.11).aspx

#Need DNS or HostFile entry for OLRoot.
Install-WindowsFeature RSAT-DNS-Server
Add-DnsServerResourceRecordA -IPv4Address 192.168.3.30 -ComputerName DC1 -ZoneName company.pri -name OLRoot

#Setup items
set-item trustedhosts -Value "*"
Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\xADCSDeployment" -Destination "\\$OLRoot\C`$\Program Files\WindowsPowerShell\Modules" -Recurse -Force
Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\xSMBShare" -Destination "\\$OLRoot\C`$\Program Files\WindowsPowerShell\Modules" -recurse -Force
Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\xADCSDeployment" -Destination "\\$EntSub\C`$\Program Files\WindowsPowerShell\Modules" -Recurse -Force
Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\xSMBShare" -Destination "\\$EntSub\C`$\Program Files\WindowsPowerShell\Modules" -recurse -Force
Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\xDNSServer" -Destination "\\$DC\C`$\Program Files\WindowsPowerShell\Modules" -recurse -Force
Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\xWebAdministration" -Destination "\\$EntSub\C`$\Program Files\WindowsPowerShell\Modules" -recurse -Force
#Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\mACLs" -Destination "\\$EntSub\C`$\Program Files\WindowsPowerShell\Modules" -recurse -Force

#deploy OLRoot config - open separate windows for other two, or run as jobs, or runspaces/workflow.  Whatever you want.
Start-DscConfiguration -ComputerName OLRoot.company.pri -Path "C:\DSC\Configs" -Verbose -Wait -Credential Get-Credential

