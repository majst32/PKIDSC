#Query
function Compare-CACRLDistributionPoint {
    param (
        [parameter(Mandatory=$True)]
        [string]$URI,
        [boolean]$PublishToServer,
        [boolean]$PublishDeltaToServer,
        [boolean]$AddToCertificateCDP,
        [boolean]$AddToFreshestCRL,
        [boolean]$AddtoCrlCDP,
        [boolean]$AddToCrlIDP
        )

$PSBoundParameters
Get-CACrlDistributionPoint | Where-Object {$_.uri -eq $URI}
}


#Add
Add-CACrlDistributionPoint

#Modify is a remove and add
Remove-CACrlDistributionPoint 
Add-CACrlDistributionPoint

#Remove (or Ensure = Absent)
Remove-CACrlDistributionPoint -uri $URI