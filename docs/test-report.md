# Test Report – Sauce Demo (verze 0.1)

Datum: 2025-11-16  
Tester: Veronika Oulická

## Souhrn
Bylo provedeno 15 testů zaměřených na login, katalog a košík. 14 testů prošlo, 1 selhal. Nalezen 1 defekt (Severity: Medium) související s loginem a zpracováním mezer v uživatelském jméně. Doporučuji doplnit trim vstupů na login formuláři a sjednotit chybové hlášky.

## Metriky
- Test cases naplánováno: 15  
- Test cases provedeno: 15  
- Pass: 14 | Fail: 1 | Blocked: 0 | Neprovedeno: 0  
- Počet bug Issues: 1

## Selhané testy
- WEB-LOGIN-006 – Mezery kolem jména (trim) – Username s mezerami neprošel (oček. trim). Viz Issue [#1](https://github.com/OfficialV1R0/qa-manual-web/issues/1).

## Prostředí
- OS: Windows 11  
- Prohlížeč: Chrome 119  

## Doporučení
- Trimovat whitespacy u uživatelského jména a hesla před validací.
- Přidat jednotné a srozumitelné chybové hlášky při neúspěšném přihlášení.
