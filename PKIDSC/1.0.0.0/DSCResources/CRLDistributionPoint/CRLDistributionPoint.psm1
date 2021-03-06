Import-Module -Name (Join-Path -Path (Split-Path $PSScriptRoot -Parent) `
-ChildPath 'CDPHelperFunctions.psm1')
function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $URI,

        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $returnValue = @{
    URI = [System.String]
    PublishToServer = [System.Boolean]
    PublishDeltaToServer = [System.Boolean]
    AddToCertificateCDP = [System.Boolean]
    AddToFreshestCRL = [System.Boolean]
    AddToCRLCDP = [System.Boolean]
    AddToCRPIdp = [System.Boolean]
    Ensure = [System.String]
    }

    $returnValue
    #>
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $URI,

        [System.Boolean]
        $PublishToServer,

        [System.Boolean]
        $PublishDeltaToServer,

        [System.Boolean]
        $AddToCertificateCDP,

        [System.Boolean]
        $AddToFreshestCRL,

        [System.Boolean]
        $AddToCRLCDP,

        [System.Boolean]
        $AddToCRPIdp,

        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1


}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $URI,

        [System.Boolean]
        $PublishToServer,

        [System.Boolean]
        $PublishDeltaToServer,

        [System.Boolean]
        $AddToCertificateCDP,

        [System.Boolean]
        $AddToFreshestCRL,

        [System.Boolean]
        $AddToCRLCDP,

        [System.Boolean]
        $AddToCRPIdp,

        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    $Current = get-CACRLCDPExistence -URI $URI
    if ($Ensure = "Absent") {
        #Ensure is absent and the URI is not found
        if ($Current -eq $False) {
            return $true
            }
        else {
        #Ensure is absent but the URI is present 
            return $False
            }
        }
    else {
        #Ensure = Present and URI not found
        if ($Current -eq $False) {
                return $False
            }
        #Ensure = Present and URI is found, compare other settings
        else {
            $PSBoundParameters.Remove('Ensure') | Out-Null
            if ((Compare-CACRLDistributionPoint @PSBoundParameters) -eq $False) {
                    return $False
            }
            else {
                return $true
            }
        }   

    }
}
        
Export-ModuleMember -Function *-TargetResource

