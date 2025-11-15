param(
    [string]$CsvPath = "testcases/web_test_cases.csv",
    [string]$ReportPath = "docs/test-report.md",
    [string]$EnvOS = "Windows",
    [string]$Browser = "Chrome"
)

function Get-Count($data, $status) {
    ($data | Where-Object { $_.Status -eq $status }).Count
}

if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV not found: $CsvPath"
    exit 1
}

$data = Import-Csv -Path $CsvPath -Delimiter ',' -Encoding utf8

$total = $data.Count
$pass = Get-Count $data 'PASS'
$fail = Get-Count $data 'FAIL'
$blocked = Get-Count $data 'BLOCKED'
$notrun = Get-Count $data 'NEPROVEDENO'

$date = Get-Date -Format 'yyyy-MM-dd HH:mm'

$content = @()
$content += "## Test Report - Sauce Demo (auto)"
$content += ""
$content += "Datum: $date"
$content += "Prostredi: $EnvOS / $Browser"
$content += ""
$content += "### Souhrn"
$content += "- Pocet testu: $total"
$content += "- PASS: $pass"
$content += "- FAIL: $fail"
$content += "- BLOCKED: $blocked"
$content += "- NEPROVEDENO: $notrun"
$content += ""

$failed = $data | Where-Object { $_.Status -eq 'FAIL' }
if ($failed.Count -gt 0) {
    $content += "### Selhane testy"
        foreach ($row in $failed) {
            $content += "- $($row.ID) - $($row.'Název')"
    }
    $content += ""
}

$content += "### Poznamky"
$content += "Tento report je generovan ze souboru $CsvPath. Po uprave statusu spust znovu skript: .\\scripts\\update-test-report.ps1"

# Ensure directory exists
$outDir = Split-Path -Parent $ReportPath
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

# Write as UTF8
[System.IO.File]::WriteAllLines($ReportPath, $content, [System.Text.Encoding]::UTF8)
Write-Host ("Report written to {0}" -f $ReportPath)