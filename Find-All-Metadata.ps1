$result = @()
$exportLocation = "C:\Users\NidulaMallikarachchi\Desktop\MMG Technology Wiki Export\Find-All-Metadata.csv"

$lists = Get-PnPList

foreach ($list in $lists) {
    $fields = Get-PnPField -List $list.Title

    foreach ($field in $fields) {
        $result = [PSCustomObject]@{
            "List Name" = $list.Title
            "Internal Name" = $field.InternalName
            "Title" = $field.Title
        }
        $result | Export-Csv -Path $exportLocation -NoTypeInformation -Encoding UTF8 -Append
        Write-Host "$($list.Title), $($field.InternalName), $($field.Title)" -ForegroundColor Cyan
    }

}
Write-Host "Metadata exported" -ForegroundColor Cyan