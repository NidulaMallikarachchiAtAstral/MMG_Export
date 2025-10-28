#This Script is used to Go through a Given List of Lists in The Tech Wiki Site Contents and to get all the items in those lists 
#Is the Main Export 

Connect-PnPOnline -Url "https://mmgltd.sharepoint.com/sites/TechnologyWiki" -useWebLogin -ErrorAction Stop
$sitesCSV = "C:\Users\NidulaMallikarachchi\Desktop\MMG Technology Wiki Export\Main-Export-Export-1.csv"
$result = @()
$allLists = Import-Csv -Path $sitesCSV -ErrorAction Stop
$logFile = "C:\Users\NidulaMallikarachchi\Desktop\MMG Technology Wiki Export\Main-Export-Input.csv" #List of Lists in the Site Contents of Tech Wiki 
 
Write-Host "Connected to Technology Wiki" -ForegroundColor Cyan
foreach ($list in $allLists) {
    $allListItems = Get-PnPListItem -List $list.Title -Fields "FileLeafRef", "Title", "Created", "Modified", "Editor", "ContentType", "FileRef","Business_x0020_Process_x0020_Group", "File_x0020_Type" -PageSize 500 -ErrorAction Stop

    foreach ($field in $allListItems) {
        $BusinessProcessGroup = ""; 

        if ($field.FieldValues.Business_x0020_Process_x0020_Group) {
            $BusinessProcessGroup = $field.FieldValues.Business_x0020_Process_x0020_Group[0]
        }

        $result = [PSCustomObject][ordered]@{
            Name                 = $field.FieldValues.FileLeafRef
            Title                = $field.FieldValues.Title
            Created              = $field.FieldValues.Created
            Modified             = $field.FieldValues.Modified
            ItemType             = $field.FieldValues.File_x0020_Type
            Path                 = $field.FieldValues.FileRef
            BusinessProcessGroup = $BusinessProcessGroup
            List                 = $list.Title
        }
        
        $result | Export-Csv -Path $logFile -NoTypeInformation -Append -ErrorAction Stop
        Write-Host "$($result)" -ForegroundColor Cyan
    }
    Write-Host "Exported: $($list.Title)" -ForegroundColor Cyan
}