Get-CACRLCDPExistence
Requires a URI parameter
Calls Get-CACrlDistributionPoint exactly one time
Returns True if a URI match is found
Returns False if a URI match is not found

Compare-CACRLDistributionPoint
Requires a URI parameter
Accepts 6 optional parameters
Calls Get-CACrlDistributionPoint exactly one time
If the URI is found:
    PSBoundParameters.remove is called exactly twice
    If an item is found that doesn't match, function returns false.
    If an item matches, the function continues to try to find a non-match
    If all items match, the function returns True.
If the URI is not found, the function returns false.


