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

# Define export paths
$csvPath = "C:\Users\FNULNU\Documents\Exports\TenantSites.csv"
$jsonPath = "C:\Users\FNULNU\Documents\Exports\TenantSites.json"
$logPath = "C:\Users\FNULNU\Documents\Exports\ScriptLog.txt"

# Function to log messages with timestamps
function Log-Message {
    param ($Message, $Color)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] $Message" -ForegroundColor $Color
    Add-Content -Path $logPath -Value "[$timestamp] $Message"
}

# Get the list of tenant sites
Log-Message "Retrieving tenant sites..." Cyan
$tenantSites = Get-PnPTenantSite

# Display the sites in the console
Log-Message "Displaying tenant sites:" Cyan
$tenantSites | Format-Table Url, Title, Template, StorageUsageCurrent

# Export to CSV
Log-Message "Exporting tenant sites to CSV: $csvPath" Yellow
$tenantSites | Export-Csv -Path $csvPath -NoTypeInformation

# Export to JSON
Log-Message "Exporting tenant sites to JSON: $jsonPath" Yellow
$tenantSites | ConvertTo-Json | Out-File $jsonPath

# Filtering sites based on template type (e.g., Team Sites)
Log-Message "Filtering Team Sites..." Cyan
$teamSites = $tenantSites | Where-Object { $_.Template -eq "GROUP#0" }
$teamSites | Format-Table Url, Title, Template

# Export filtered Team Sites to CSV
$teamSitesCsvPath = "C:\Users\FNULNU\Documents\Exports\TeamSites.csv"
Log-Message "Exporting filtered Team Sites to CSV: $teamSitesCsvPath" Yellow
$teamSites | Export-Csv -Path $teamSitesCsvPath -NoTypeInformation

# Sort sites by storage usage
Log-Message "Sorting sites by storage usage..." Cyan
$sortedSites = $tenantSites | Sort-Object StorageUsageCurrent -Descending
$sortedSites | Format-Table Url, Title, StorageUsageCurrent

# Export sorted sites to CSV
$sortedCsvPath = "C:\Users\FNULNU\Documents\Exports\SortedTenantSites.csv"
Log-Message "Exporting sorted sites by storage usage to CSV: $sortedCsvPath" Yellow
$sortedSites | Export-Csv -Path $sortedCsvPath -NoTypeInformation

# Count the number of sites
$totalSites = $tenantSites.Count
Log-Message "Total number of tenant sites: $totalSites" Green

# Count the number of Team Sites
$totalTeamSites = $teamSites.Count
Log-Message "Total number of Team Sites: $totalTeamSites" Green

# End of script
Log-Message "Script execution completed." Green
