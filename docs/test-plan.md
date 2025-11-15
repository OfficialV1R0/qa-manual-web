## Test plán – Sauce Demo (verze 0.1)

Autor: Veronika Oulická
Datum vytvoření: 2025-11-15
Poslední aktualizace: 2025-11-15

Prostředí:
- OS: Windows
- Prohlížeč: Chrome (aktuální stabilní)

Rizika:
- Neznalost kódu – pouze black‑box testování

Cíl: Ověřit základní funkčnost webové aplikace, UX a hlavní scénáře.

Oblast testování:

- Přihlášení/registrace
- Hlavní navigace
- Formularové vstupy a validace
- Základní CRUD operace

Přístup:

1. Příprava testovacího prostředí (prohlížeče, čistá cache)
2. Vytvoření testovacích účtů
3. Spuštění základních scénářů podle `testcases/web_test_cases.csv`

Metodika:

- Označování výsledků: PASS / FAIL / BLOCKED
- Priorita případů: P0, P1, P2
- Po chybě vytvořit issue pomocí šablony `bug_report.yml`