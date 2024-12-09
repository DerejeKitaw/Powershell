# Clone lists and libraries
foreach ($list in $lists) {
    Write-Host "Cloning list: $($list.Title) with template ID: $($list.BaseTemplate)" -ForegroundColor Yellow

    # Check if the list already exists in the target site
    $existingList = $null
    try {
        $existingList = Get-PnPList | Where-Object { $_.Title -eq $list.Title }
    }
    catch {
        Write-Host "Warning: Unable to retrieve lists from the target site. Error: $_" -ForegroundColor Yellow
    }

    if ($existingList) {
        Write-Host "List '$($list.Title)' already exists in the target site. Skipping..." -ForegroundColor Yellow
        continue
    }

    try {
        switch ($list.BaseTemplate) {
            101 { 
                New-PnPList -Title $list.Title -Template DocumentLibrary
                Write-Host "Document Library '$($list.Title)' created." -ForegroundColor Green
            }
            100 { 
                New-PnPList -Title $list.Title -Template GenericList
                Write-Host "Generic List '$($list.Title)' created." -ForegroundColor Green
            }
            119 { 
                New-PnPList -Title $list.Title -Template WebPageLibrary
                Write-Host "Site Pages Library '$($list.Title)' created." -ForegroundColor Green
            }
            109 { 
                New-PnPList -Title $list.Title -Template PictureLibrary
                Write-Host "Picture Library '$($list.Title)' created." -ForegroundColor Green
            }
            default { 
                Write-Host "Skipping unsupported list type: $($list.BaseTemplate)" -ForegroundColor Red 
            }
        }
    }
    catch {
        Write-Host "Error cloning list: $($list.Title). Error: $_" -ForegroundColor Red
    }
}
