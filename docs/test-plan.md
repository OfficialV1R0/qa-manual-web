# Test Plan – Sauce Demo (verze 0.1)

Autor: Veronika Oulická  
Datum vytvoření: (doplň)  
Poslední aktualizace: (doplň)

1. Účel
Ověřit základní funkčnost e‑shopu (login, katalog, košík) a identifikovat zjevné funkční chyby.

2. Scope
V testovaném rozsahu:
- Login (validní, nevalidní, edge případy)
- Logout
- Katalog (zobrazení položek, základní řazení)
- Košík (přidání, odebrání, více položek)

Mimo rozsah (verze 0.1):
- Platby, objednávkový proces
- Výkonnost, bezpečnost
- Lokalizace

3. Testovací prostředí
URL: https://www.saucedemo.com  
Prohlížeč: Chrome (aktuální)  
OS: (doplň Windows 10 / 11 apod.)  
Účty: standard_user / secret_sauce, locked_out_user / secret_sauce (negativní scénář)

4. Testovací přístup
Manuální funkční testy a exploratory testy. Test cases vedené v CSV, bugy v Issues.

5. Klasifikace defektů
Severity:
- Critical: blokuje klíčovou funkci (login, přidání do košíku)
- High: funkce částečně omezená, ne kritická cesta
- Medium: chyba v menší části (UI, menší dopad)
- Low: kosmetika, text, zarovnání

Priority:
- High: opravovat ihned
- Medium: oprava po kritických
- Low: může počkat

6. Stop kritéria
- Všechny naplánované test cases provedeny
- Zaznamenány nalezené defekty

7. Výstupy
- CSV test cases (pass/fail stav)
- Issues (defekty)
- Test report (shrnutí metrik)

8. Rizika / Omezení
- Demo prostředí může se měnit bez oznámení
- Omezený čas (první verze portfolia)