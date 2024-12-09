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

# Define export path
$csvPath = "C:\Users\FNULNU\Documents\Exports\SitePermissionsReport.csv"

# Ensure the export directory exists
$exportDir = Split-Path -Path $csvPath
if (-not (Test-Path -Path $exportDir)) {
    New-Item -ItemType Directory -Path $exportDir | Out-Null
}

# Get all groups in the site
$groups = Get-PnPGroup

# Create an empty array to store results
$report = @()

foreach ($group in $groups) {
    $members = Get-PnPGroupMember -Identity $group
    foreach ($member in $members) {
        $report += [PSCustomObject]@{
            GroupName   = $group.Title
            MemberName  = $member.Title
            MemberEmail = $member.Email
        }
    }
}

# Export to CSV
$report | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "Permission report exported to $csvPath" -ForegroundColor Green
