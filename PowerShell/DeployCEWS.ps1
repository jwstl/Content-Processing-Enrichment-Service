$snapin="Microsoft.SharePoint.PowerShell"
if (get-pssnapin $snapin -ea "silentlycontinue") {
}
else
{
    if (get-pssnapin $snapin -registered -ea "silentlycontinue") {
        Add-PSSnapin $snapin
        write-host -ForegroundColor Green "PSsnapin $snapin is now loaded"
    }
}
$ssa = Get-SPEnterpriseSearchServiceApplication -Identity "Search Service Application"
$config = New-SPEnterpriseSearchContentEnrichmentConfiguration
$config.Endpoint = "https://cews.denallix.com:4343/ContentProcessingEnrichmentService.svc";
$config.InputProperties = "body";
$config.OutputProperties = "MyContents";
$config.SendRawData = $True;
$config.FailureMode = "WARNING";
$config.MaxRawDataSize = 51200;
$config.Trigger = '!IsMatch(FileExtension, "aspx")';
Set-SPEnterpriseSearchContentEnrichmentConfiguration -SearchApplication $ssa -contentEnrichmentConfiguration $config