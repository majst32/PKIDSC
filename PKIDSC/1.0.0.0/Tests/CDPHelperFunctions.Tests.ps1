Describe "CDPHelperFunctions" {

    Context "Get-CACRLCDPExistence" {
        Mock Get-CACRLCDPExistence {}

        It "Should require a URI Parameter" {
            {get-CACRLCDPExistence -URI $Null} | should Throw
        }

        It "Should call Get-CACRLDistributionPoint exactly one time" {
           
        }

        It "Should return True if a URI Match is Found" {

        }

        It "Should return False if a URI Match is not found" {

        }
    }

    Context "Compare-CACRLDistributionPoint" {

        It "Requires a URI Parameter" {

        }

        It "Accepts up to 6 optional parameters" {

        }

        It "Calls Get-CACRLDistributionPoint exactly one time" {

        }
        
        It "Calls PSBoundParameters.remove twice if the URI is found" {

        }
        It "Returns false  if an optional item is found that doesn't match"{

        }
        It "Returns true if all the optional items match" {

        }
        It "Returns false if the URI is not found" {

        }
    }
    
}
   

