$data = Import-Csv -Path "c:\Users\oulic\Desktop\QA portfolio\qa-manual-web\testcases\web_test_cases.csv" -Delimiter ',' -Encoding utf8
Write-Host ("Rows: {0}" -f $data.Count)
$statuses = $data | ForEach-Object { ([string]$_.Status).Trim() }
$groups = $statuses | Group-Object | Sort-Object -Property Name
foreach ($g in $groups) {
    Write-Host ("'{0}' -> {1}" -f $g.Name, $g.Count)
}
$failRows = $data | Where-Object { (([string]$_.Status).Trim().ToUpper()) -eq 'FAIL' }
Write-Host ("FAIL rows: {0}" -f $failRows.Count)
foreach ($r in $failRows) { Write-Host ("Row: {0} / {1} / Nazev: {2} / Poznamky: {3}" -f $r.ID, $r.Status, $r.'Název', $r.'Poznámky') }

Write-Host "Headers detected:"
($data[0].psobject.Properties.Name -join ', ')

$issuePattern = '#\d+'
$notes = ($data | Where-Object { $_.ID -eq 'WEB-LOGIN-006' }).'Poznámky'
Write-Host ("Notes raw: {0}" -f $notes)
$m = [regex]::Match([string]$notes, $issuePattern)
Write-Host ("Regex matched: {0}" -f $m.Value)
