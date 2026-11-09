# 🧩 Dalli Klick & Memorbild - Das Bilderrätsel-Spiel für Kinder & Familien

Ein liebevoll gestaltetes, interaktives **Dalli Klick & Memorbild-Spiel** im Stil des legendären TV-Klassikers (*"Dalli Dalli"*). 
Ein verdecktes Bild wird durch **kleine, unregelmäßige Ausschnitte (Polygone, Mosaiksteine, Facetten) mit leicht unterschiedlicher Größe** schrittweise aufgedeckt. Wer den Begriff als Erster erkennt und buzzert, gewinnt die Runde!

Geeignet für Kinder **ab 7 Jahren** sowie für die ganze Familie oder Schulklassen.

---

## ✨ Besondere Neuerungen & Features

1. **Memorbild-Mosaik (Unregelmäßige Formen):**
   - Keine langweiligen quadratischen Gitter mehr! Die Bilder werden durch dynamisch berechnete **Voronoi-Vielecke** (4 bis 8 Ecken), **Dreiecks-Facetten** oder organische Mosaikformen mit variierenden Größen abgedeckt.
   - 100% fugenlos und bündig – keine Lücken, keine Überlappungen.
   - Sanfte, organische Dreh- und Schrumpf-Animation beim Aufdecken.
2. **Kristallklare Bilddarstellung (Kein Abdunkeln mehr):**
   - Der Hintergrund der Abdeckung ist transparent und das Spielfeld reinweiß hinterlegt – freigelegte Bildausschnitte erstrahlen in voller, natürlicher Helligkeit und Schärfe.
3. **Erweiterte Begriffstoleranz & Synonyme:**
   - Ob *"Feuerwehrauto"* oder *"Feuerwehr"*, *"Trecker"* oder *"Traktor"*, *"Möhre"* oder *"Karotte"*, *"Bücher"* oder *"Buch"* – ein umfassendes deutsches Wörterbuch sowie automatische Tippfehlertoleranz (Levenshtein) sorgen für frustfreies Raten.
4. **Bilder-Galerie (`galerie.html`):**
   - Eine praktische Übersichtskarte aller 70 Bilder inklusive Synonymen zur schnellen Kontrolle und Vorbereitung.

---

## 🚀 Spiel starten

Es gibt zwei einfache Wege, das Spiel auf Windows zu starten:

### Methode 1: Empfohlen (Mit automatischem Webserver)
1. Mache einen Doppelklick auf **`Start-Spiel.bat`**.
2. Der integrierte, schlanke Server startet automatisch und öffnet dein Spiel direkt im Standard-Browser unter `http://localhost:8085/`.
3. Der Server erkennt neu hinzugefügte Bilder im Ordner `bilder/` sofort dynamisch bei jedem Spielstart!

### Methode 2: Direkt & Offline
1. Mache einfach einen Doppelklick auf **`index.html`**.
2. Das Spiel läuft sofort im Browser – ganz ohne Internetverbindung und ohne Installation.

---

## 🎮 Spielregeln & Steuerung

- **Spielziel:** Errate das Bild, bevor alle Ausschnitte aufgedeckt sind!
- **Ausschnitte aufdecken:** 
  - Klicke auf **▶ Start** (oder drücke die **Leertaste**) – die Ausschnitte verschwinden nacheinander in zufälliger Reihenfolge.
  - Das Tempo kann flexibel gewählt werden: *Langsam*, *Normal*, *Schnell*, *Turbo* oder *Manuell* (Klick für Klick).
  - Man kann auch gezielt auf einzelne nummerierte Mosaiksteine klicken, um sie manuell aufzudecken.
- **Punktevergabe mit Daumen hoch (👍) & Daumen runter (👎):**
  - Wer das Bild erkennt, ruft den Begriff laut hinein.
  - **Richtig geraten (👍 Daumen hoch):**
    - Klicke auf den grünen **👍**-Button des Spielers (oder drücke Taste **`1`** für Spieler 1 bzw. **`2`** für Spieler 2).
    - Der Spieler erhält **+3 Punkte**!
    - Belohnungssound und Konfetti-Regen ertönen.
    - Das Bild deckt sich in einer Welle vollständig auf, der Begriff wird angezeigt und vorgelesen.
  - **Falsch geraten (👎 Daumen runter):**
    - Klicke auf den roten **👎**-Button neben dem Daumen hoch.
    - Dem Spieler wird **1 Punkt abgezogen (-1 Punkt)**!
    - Ein falscher Ton ertönt und der Button wackelt zur visuellen Bestätigung.
    - Das Spiel läuft weiter, sodass der andere Spieler noch seine Chance nutzen kann.
- **Spieler-Namen & Punktestand:**
  - Unter den Bezeichnungen *Spieler 1* und *Spieler 2* kann direkt der eigene Name eingetragen werden (z. B. "Anna", "Felix").
  - Mit **🔄 Punkte neu starten** kann der Spielstand auf 0:0 zurückgesetzt werden.
- **Maximal großes Spielfeld:**
  - Durch den Wegfall des großen Buzzer-Blocks wurde das Spielfeld mit dem Bild auf bis zu **960 px** vergrößert – das Bild ist jetzt fast doppelt so groß wie zuvor!

---

## ⚙ Einstellungen (Zahnrad ⚙)

- **Ausschnitt-Form (Memorbild-Stil):**
  - *Buntes Mosaik (Vielecke & ungleiche Formen)* [Standard]
  - *Dreiecks-Facetten (Kristall-Look)*
  - *Klassisches Gitter (Rechtecke)*
- **Ausschnitt-Größe & Kachelanzahl:**
  - *Klein (42 Teile - Memorbild-Standard)*
  - *Sehr klein (56 Teile - Knifflig)*
  - *Mittel (30 Teile - Schneller)*
  - *Groß (20 Teile - Für jüngere Kinder)*
- **Farbdesign:**
  - *Regenbogen (Bunt & vielfältig)*, *Ozeanblau*, *Sonnenuntergang*, *Klassisch Blau*.

---

## 📁 Bilderordner erweitern oder verkleinern

Der Ordner **`bilder/`** enthält standardmäßig **70 kindgerechte, gemeinfreie Bilder**. Du kannst ihn jederzeit nach Belieben anpassen:

1. **Neues Bild hinzufügen:**
   - Speichere ein beliebiges Bild (`.jpg`, `.png`, `.webp`) im Ordner `bilder/`.
   - Benenne die Datei einfach nach dem gesuchten Begriff, z.B. **`Feuerwehrauto.jpg`** oder **`Delfin.png`**.
2. **Bild entfernen:**
   - Lösche die Datei einfach aus dem Ordner `bilder/`.
3. **Aktualisieren:**
   - Bei Nutzung von `Start-Spiel.bat` werden Änderungen **sofort automatisch** erkannt.
   - Wenn du `index.html` direkt öffnest: Führe kurz **`bilder_aktualisieren.bat`** per Doppelklick aus, um die Liste abzugleichen.
   - Alternativ kannst du auch im Spiel über das Zahnrad-Menü **⚙ Einstellungen** einen beliebigen Ordner direkt im Browser auswählen!

---

## 🎨 Die 70 enthaltenen Begriffe (Kindgerecht & Lizenzfrei)

Alle Bilder stammen aus urheberrechtsfreien bzw. gemeinfreien Quellen (*Wikimedia Commons CC0/CC-BY, Unsplash Free License*):

### 🐾 Tiere (25)
Affe, Bär, Delfin, Elefant, Ente, Eule, Frosch, Giraffe, Hase, Hund, Igel, Känguru, Katze, Koala, Krokodil, Kuh, Löwe, Marienkäfer, Pferd, Pinguin, Schaf, Schildkröte, Schmetterling, Schwein, Zebra.

### 🚗 Fahrzeuge (12)
Auto, Bus, Fahrrad, Feuerwehr, Flugzeug, Heißluftballon, Hubschrauber, Motorrad, Rakete, Schiff, Traktor, Zug.

### 🍎 Essen & Trinken (10)
Apfel, Banane, Brot, Eis, Erdbeere, Karotte, Kirsche, Pizza, Wassermelone, Weintrauben.

### 🧸 Gegenstände & Spielzeug (15)
Ball, Brille, Buch, Geschenk, Gitarre, Lampe, Regenschirm, Rucksack, Schere, Schlüssel, Skateboard, Teddybär, Trommel, Uhr, Zahnbürste.

### 🌳 Natur, Technik & Fantasie (8)
Baum, Blume, Mond, Pilz, Regenbogen, Roboter, Schneemann, Sonne.

---

## ⚙ Technische Details

- **Zero External Dependencies:** 100% nativ in HTML5, CSS3, SVG und modernem JavaScript geschrieben.
- **Echte Synthesizer-Sounds:** Verwendet die Browser **Web Audio API** – keine externen MP3/WAV-Dateien nötig, läuft immer absolut verzögerungsfrei!
- **Sutherland-Hodgman Polygon Clipping:** Mathematisch exakte, lückenlose Voronoi-Zellenberechnung in unter 2 Millisekunden.
- **Konfetti-Effekt:** Eigenständige HTML5-Canvas-Partikelsimulation.
- **Portabler PowerShell-Server:** Läuft auf jedem Standard-Windows 10 / 11 ohne Installation von Python oder Node.js.
