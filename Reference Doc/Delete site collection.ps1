# Check if already connected to PnP Online
try {
    Get-PnPContext | Out-Null
    Write-Host "Already connected to PnP Online. Skipping login..." -ForegroundColor Green
}
catch {
    Write-Host "No active connection. Logging in..." -ForegroundColor Yellow
    Connect-PnPOnline -Url https://wplrn-admin.sharepoint.com -Interactive
}

# Remove the Microsoft 365 Group
Remove-PnPMicrosoft365Group -Identity "newteamsite"

Get-PnPMicrosoft365Group

Get-PnPTenantSite -Url https://wplrn.sharepoint.com/sites/newteamsite | Format-List

# GroupId                                     : 8f0780b5-1436-4807-832f-101f6882a82d

# Get-PnPMicrosoft365Group -Identity <GroupId>
Get-PnPMicrosoft365Group -Identity 8f0780b5-1436-4807-832f-101f6882a82d


# Or
Get-PnPMicrosoft365Group | Where-Object { $_.SiteUrl -eq "https://wplrn.sharepoint.com/sites/newteamsite" }

# Delete the associated Team Site (if it still exists)
Remove-PnPTenantSite -Url https://wplrn.sharepoint.com/sites/newteamsite -Force
