$app = New-Object -ComObject 'InDesign.Application.2026'
while ($app.Documents.Count -gt 0) {
    $app.Documents.Item(1).Close(1852776480)  # SaveOptions.NO
}
Write-Output "All documents closed."
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($app) | Out-Null
