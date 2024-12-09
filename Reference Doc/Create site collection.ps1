# Check if there is an active connection
try {
    # Run a simple PnP command to check if the connection is valid
    Get-PnPContext | Out-Null
    Write-Host "Already connected to PnP Online. Skipping login..." -ForegroundColor Green
}
catch {
    # If no active connection, connect to SharePoint Online
    Write-Host "No active connection. Logging in..." -ForegroundColor Yellow
    Connect-PnPOnline -Url https://wplrn.sharepoint.com/sites/MSFT `
        -ClientId "xxxxxxxxx-ea62-432f-902e-2cabf60d55b0" `
        -Tenant "wplrn.onmicrosoft.com" `
        -Interactive
}

# Get the list of tenant sites
Get-PnPTenantSite

# Create a new Team Site
New-PnPSite -Type TeamSite `
    -Title "New Team Site" `
    -Alias "newteamsite" `
    -Owner admin@wplrn.onmicrosoft.com `
    -TimeZone 10


