#Get an Export of all the Lists for Tech Wiki Site 
$allLists = Get-PnPList 
$result = @()
$exportLocation = "C:\Users\NidulaMallikarachchi\Desktop\MMG Technology Wiki Export\Site_Content_Lists.csv"

foreach ($list in $allLists) {
	$result = [PSCustomObject]@{
		List_Name = $list.Title
	}
	
	$result | Export-Csv -Path $exportLocation -NoTypeInformation -Encoding UTF8 -Append
	Write-Host "$($result)" -ForegroundColor Cyan
}
Write-Host "Successfully Exported" -ForegroundColor Cyan 
