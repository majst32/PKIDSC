function get-CACRLCDPExistence {
[cmdletbinding()]
    param (
        [parameter(Mandatory=$True)]
        [string]$URI
        )

if ((Get-CACrlDistributionPoint | Where-Object {$_.uri -eq $URI}) -ne $Null) {
    write-verbose "CRL Distribution Point $URI exists."
    return $True
    }
else {
    write-verbose "CRL Distribution Point $URI does not exist."
    return $False
    }
}

function Compare-CACRLDistributionPoint {
[cmdletbinding()]
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

$X = Get-CACrlDistributionPoint | Where-Object {$_.uri -eq $URI}

if ($X -ne $Null) {
    #URI is found, now check all of the parameters
    write-verbose "URI exists, checking for parameter matches."
    $PSBoundParameters.Remove('URI') | out-null
    $PSBoundParameters.Remove('Verbose') | out-null

    foreach ($Item in ($PSBoundParameters.keys)) {
        Write-Verbose "Checking if $Item is set correctly..."
        
        if ($X.$Item -ne $PSBoundParameters.$Item) {
            write-verbose "$Item does not match the input parameter."
            return $False
            }

        else {
            Write-verbose "$Item is set correctly."
            }

        }
    write-verbose "All current settings match the inputs."
    return $True
    }
else {
    #URI was not found
    write-verbose "URI was not found."
    return $False
    }
}


function Add-CACrlCDPWrapper {
[cmdletbinding()]
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

$PSBoundParameters.Remove('Verbose')
Add-CACrlDistributionPoint @PSBoundParameters -force
}

function Remove-CACrlCdpWrapper {
[cmdletbinding()]
    param (
        [parameter(Mandatory=$True)]
        [string]$URI
        )  
    
Remove-CACrlDistributionPoint -uri $URI -Force
}

function Set-CACrlCdpWrapper {
[cmdletbinding()]
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

Remove-CACrlCdpWrapper -URI $URI
$PSBoundParameters.Remove('Verbose') | Out-Null

Add-CACrlCdpWrapper @PSBoundParameters
}

