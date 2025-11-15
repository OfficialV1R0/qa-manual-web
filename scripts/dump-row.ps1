$data = Import-Csv -Path "c:\Users\oulic\Desktop\QA portfolio\qa-manual-web\testcases\web_test_cases.csv" -Delimiter ',' -Encoding utf8
$r = $data | Where-Object { $_.ID -eq 'WEB-LOGIN-006' }
$r | ConvertTo-Json -Depth 3 | Write-Host