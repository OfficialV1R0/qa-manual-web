param(
    [string]$CsvPath = "testcases/web_test_cases.csv",
    [string]$ReportPath = "docs/test-report.md",
    [string]$EnvOS = "Windows",
    [string]$Browser = "Chrome"
)

function Get-Count($data, $status) {
    @($data | Where-Object { (([string]$_.Status).Trim().ToUpper()) -eq $status }).Count
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

# Count unique issue references like #1, #23 from the Notes column
$issuePattern = '#\d+'
$issues = @()
foreach ($row in $data) {
    $notes = [string]$row.'Poznámky'
    if ($notes) {
        $matches = [regex]::Matches($notes, $issuePattern)
        foreach ($m in $matches) { $issues += $m.Value }
    }
}
$bugIssueCount = ($issues | Select-Object -Unique).Count

$content = @()
$content += "## Test report - Sauce Demo (auto)"
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
$content += "- Pocet bug issues: $bugIssueCount"
$content += ""

$failed = $data | Where-Object { (([string]$_.Status).Trim().ToUpper()) -eq 'FAIL' }
if (@($failed).Count -gt 0) {
    $content += "### Selhane testy"
    foreach ($row in @($failed)) {
        $content += "- $($row.ID) - $($row.'Název') - $($row.'Poznámky')"
    }
    $content += ""
}

# Main bugs (take up to 3 with issue id if present)
$content += "### Hlavni bugy"
if (@($failed).Count -gt 0) {
    $i = 0
    foreach ($row in @($failed)) {
        if ($i -ge 3) { break }
        $notes = [string]$row.'Poznámky'
        $issueMatch = [regex]::Match($notes, $issuePattern)
        if (-not $issueMatch.Success) {
            if ($notes -match $issuePattern) { $issueRef = $matches[0].Value } else { $issueRef = "(bez cisla issue)" }
        } else { $issueRef = $issueMatch.Value }
        $content += "- $($row.ID) - $($row.'Název') - $issueRef"
        $i++
    }
} else {
    $content += "- N/A"
}
$content += ""

# 3-5 sentence summary
$summary = @()
$summary += "Bylo provedeno $total testu v prostredi $EnvOS / $Browser."
if ($fail -gt 0) {
    $summary += "Z toho $fail test(ů) selhal(o); prioritou je oprava znamych chyb a opakovani testu."
} else {
    $summary += "Vsechny testy prosly, bez selhani."
}
if ($blocked -gt 0) { $summary += "Blokovanych: $blocked (nutna priprava prostredi nebo data)." }
$summary += "Odkazy na nahlasene chyby: $bugIssueCount issue(s)."
$summary += "Doporuceni: opravit nejkritictejsi bugy a provest rychly regres prihlaseni."

$content += "### Shrnutí"
$content += ($summary -join ' ')
$content += ""

$content += "### Poznamky"
$content += "Tento report je generovan ze souboru $CsvPath. Po uprave statusu spust znovu skript: .\\scripts\\update-test-report.ps1"

# Ensure directory exists
$outDir = Split-Path -Parent $ReportPath
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

# Write as UTF8 (with BOM for compatibility)
$utf8bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllLines($ReportPath, $content, $utf8bom)
Write-Host ("Report written to {0}" -f $ReportPath)