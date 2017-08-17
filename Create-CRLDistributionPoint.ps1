$URI = New-xDscResourceProperty -name URI -type String -attribute Key -Description "URI of the CRL Distrbution Point"
$PublishToServer = New-xDscResourceProperty -name PublishToServer -type Boolean -Attribute Write -Description "Publish the CRL to the specified server"
$PDTS = New-xDscResourceProperty -name PublishDeltaToServer -type Boolean -Attribute Write -Description "Publish the Delta CRL"
$ATCC = New-xDscResourceProperty -name AddToCertificateCDP -type Boolean -Attribute Write -Description "Include in the CDP extension of issued certificates"
$ATFC = New-xDscResourceProperty -name AddToFreshestCRL -Type Boolean -Attribute Write -Description "Include in the most recent CRL"
$AddToCRLCDP = New-xDscResourceProperty -name AddToCRLCDP -type Boolean -Attribute Write -Description "Include in the CRL"
$AddToCRLIDP = New-xDscResourceProperty -name AddToCRPIdp -Type Boolean -Attribute Write -Description "Include in the IDP Extnesion of issued certificates"
$Ensure = New-xDscResourceProperty -name Ensure -ValueMap "Present","Absent" -Values "Present","Absent" -type String -Attribute Required

New-xDscResource -Name CRLDistributionPoint -Property $URI,$PublishToServer,$PDTS,$ATCC,$ATFC,$AddToCRLCDP,$AddToCRLIDP,$Ensure -Path "C:\Program Files\WindowsPowerShell\Modules" -ModuleName PKIDSC
