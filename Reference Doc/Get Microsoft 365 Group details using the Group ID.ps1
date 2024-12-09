# Connect using Client ID and Client Secret
Connect-PnPOnline -Url https://wplrn.sharepoint.com/sites/MSFT `
                      -ClientId "xxxxxxxxx-ea62-432f-902e-2cabf60d55b0" `
                      -Tenant "wplrn.onmicrosoft.com" `
                      -Interactive

# Get site details
$site = Get-PnPTenantSite -Url https://wplrn.sharepoint.com/sites/newteamsite
Write-Host "Group ID: $($site.GroupId)"
