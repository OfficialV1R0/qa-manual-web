# QA Manual Web – Sauce Demo

Krátký cíl: Ukázka systematického manuálního testování veřejného demo e‑shopu [Sauce Demo](https://www.saucedemo.com).

Artefakty:
- Test plan: [docs/test-plan.md](docs/test-plan.md)
- Test cases (CSV): [testcases/web_test_cases.csv](testcases/web_test_cases.csv)
- Bug reporty: GitHub Issues (label `bug`)
- Test report: [docs/test-report.md](docs/test-report.md)

Scope (zatím):
- Login / Logout
- Katalog (inventory) – zobrazení
- Filtrování / řazení (pokud je k dispozici)
- Košík (přidání, odebrání položek)

Jak přidat bug:
1. Issues -> New Issue -> "Bug report"
2. Vyplň šablonu (Severity, Priority, kroky, očekávané vs. skutečné)
3. Přidej screenshot

Přihlašovací údaje (demo):
- Uživatelské jméno: `standard_user`
- Heslo: `secret_sauce`

## Jak vygenerovat test report (Windows/PowerShell)

Report se generuje ze souboru `testcases/web_test_cases.csv` pomocí skriptu.

Postup:
1. Otevři PowerShell v kořenovém adresáři repozitáře.
2. Spusť skript (možno upravit parametry OS/Browser):

	powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\update-test-report.ps1" -CsvPath ".\testcases\web_test_cases.csv" -ReportPath ".\docs\test-report.md" -EnvOS "Windows" -Browser "Chrome"

3. Změny ulož a případně commitni/pushni.

Poznámka: Statické nadpisy jsou bez diakritiky kvůli kompatibilitě PowerShell 5.1. Data z CSV (názvy testů, poznámky) zůstávají v češtině.