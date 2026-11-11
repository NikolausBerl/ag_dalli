# Skript zur Erstellung von bilder.js mit Kategorien, sauberen Anzeigenamen und Synonymen
# UTF-8 sicher und unabhaengig von der Powershell-Codepage

$root = $PSScriptRoot
$bilderDir = Join-Path $root "bilder"
$outputFile = Join-Path $root "bilder.js"

$ae = [char]0x00E4
$oe = [char]0x00F6
$ue = [char]0x00FC
$ss = [char]0x00DF

$baer = "B${ae}r"
$loewe = "L${oe}we"
$kaenguru = "K${ae}nguru"
$schildkroete = "Schildkr${oe}te"
$schluessel = "Schl${ue}ssel"
$zahnbuerste = "Zahnb${ue}rste"
$marienkaefer = "Marienk${ae}fer"
$teddybaer = "Teddyb${ae}r"
$heissluftballon = "Hei${ss}luftballon"
$baukloetze = "Baukl${oe}tze"
$fussball = "Fu${ss}ball"
$plueschtier = "Pl${ue}schtier"
$spielkueche = "Spielk${ue}che"
$zauberwuerfel = "Zauberw${ue}rfel"
$strassenkreide = "Stra${ss}enkreide"
$huepfball = "H${ue}pfball"
$kueche = "K${ue}che"
$fruehstueck = "Fr${ue}hst${ue}ck"

$umlautMap = @{
    "Baer"            = $baer
    "Loewe"           = $loewe
    "Kaenguru"        = $kaenguru
    "Schildkroete"    = $schildkroete
    "Schluessel"      = $schluessel
    "Zahnbuerste"     = $zahnbuerste
    "Marienkaefer"    = $marienkaefer
    "Teddybaer"       = $teddybaer
    "Heissluftballon" = $heissluftballon
    "Baukloetze"      = $baukloetze
    "Fussball"        = $fussball
    "Plueschtier"     = $plueschtier
    "Spielkueche"     = $spielkueche
    "Zauberwuerfel"   = $zauberwuerfel
    "Strassenkreide"  = $strassenkreide
    "Huepfball"       = $huepfball
}

# Spezifische Zuweisungen für Spielzeug-Bilder
$spielzeugDefs = @{
    "spielzeug_01.png" = @{ name = "Memory"; alt = @("memory", "gedaechtnisspiel", "gedächtnisspiel", "merkspeicher", "paare finden", "karten") }
    "spielzeug_02.png" = @{ name = $teddybaer; alt = @("teddybär", "teddybaer", "teddy", "plüschbär", "plueschbaer", "stofftier", "baer", "bär") }
    "spielzeug_03.png" = @{ name = "Spielzeugauto"; alt = @("spielzeugauto", "auto", "modellauto", "rennauto", "flitzer", "pkw") }
    "spielzeug_04.png" = @{ name = "Puppe"; alt = @("puppe", "spielpuppe", "babypuppe", "baby puppe", "doll") }
    "spielzeug_05.png" = @{ name = $baukloetze; alt = @("bauklötze", "baukloetze", "bausteine", "holzbausteine", "klötze", "kloetze", "blöcke") }
    "spielzeug_06.png" = @{ name = "Springseil"; alt = @("springseil", "hüpfseil", "huepfseil", "seilhüpfen", "seilhuepfen", "seilchen") }
    "spielzeug_07.png" = @{ name = "Wasserpistole"; alt = @("wasserpistole", "spritzpistole", "wasserspritze", "supersoaker") }
    "spielzeug_08.png" = @{ name = "Ball"; alt = @("ball", "wasserball", "strandball", "spielball") }
    "spielzeug_09.png" = @{ name = $fussball; alt = @("fußball", "fussball", "ball", "lederball", "kicker") }
    "spielzeug_10.png" = @{ name = "Eisenbahn"; alt = @("eisenbahn", "zug", "holzeisenbahn", "holzzug", "lokomotive", "lok") }
    "spielzeug_11.png" = @{ name = "Puzzle"; alt = @("puzzle", "steckpuzzle", "puzzlespiel", "legepuzzle") }
    "spielzeug_12.png" = @{ name = "Knete"; alt = @("knete", "knetmasse", "playdoh", "play doh", "kneten") }
    "spielzeug_13.png" = @{ name = "Kugelbahn"; alt = @("kugelbahn", "murmelbahn", "rollbahn") }
    "spielzeug_14.png" = @{ name = "Murmelbahn"; alt = @("murmelbahn", "kugelbahn", "murmeln") }
    "spielzeug_15.png" = @{ name = $plueschtier; alt = @("plüschtier", "plueschtier", "kuscheltier", "stofftier") }
    "spielzeug_16.png" = @{ name = "Kreisel"; alt = @("kreisel", "brummkreisel", "drehkreisel") }
    "spielzeug_17.png" = @{ name = "Dinosaurier"; alt = @("dinosaurier", "dino", "t-rex", "tyrannosaurus") }
    "spielzeug_18.png" = @{ name = "Stegosaurus"; alt = @("stegosaurus", "dino", "dinosaurier") }
    "spielzeug_19.png" = @{ name = "Puppenhaus"; alt = @("puppenhaus", "puppenstube", "puppenheim") }
    "spielzeug_20.png" = @{ name = "Lego"; alt = @("lego", "legosteine", "klemmbausteine", "bausteine") }
    "spielzeug_21.png" = @{ name = "Skateboard"; alt = @("skateboard", "board", "skate-board") }
    "spielzeug_22.png" = @{ name = "Drachen"; alt = @("drachen", "flugdrachen", "winddrachen") }
    "spielzeug_23.png" = @{ name = "Bagger"; alt = @("bagger", "spielzeugbagger", "schaufelbagger", "baustelle") }
    "spielzeug_24.png" = @{ name = "Kartenspiel"; alt = @("kartenspiel", "spielkarten", "karten", "uno", "mau mau") }
    "spielzeug_25.png" = @{ name = "Kuschelhase"; alt = @("kuschelhase", "stoffhase", "plüschhase", "plueschhase", "hase") }
    "spielzeug_26.png" = @{ name = "Rutschauto"; alt = @("rutschauto", "bobbycar", "bobby car", "rutschfahrzeug") }
    "spielzeug_27.png" = @{ name = "Sandspielzeug"; alt = @("sandspielzeug", "sandeimer", "schaufel", "förmchen", "foermchen") }
    "spielzeug_28.png" = @{ name = "Flugzeug"; alt = @("flugzeug", "flieger", "spielzeugflugzeug") }
    "spielzeug_29.png" = @{ name = "Seifenblasen"; alt = @("seifenblasen", "pustefix") }
    "spielzeug_30.png" = @{ name = $spielkueche; alt = @("spielküche", "spielkueche", "kinderküche", "kinderkueche", "küche", "kueche") }
    "spielzeug_31.png" = @{ name = $zauberwuerfel; alt = @("zauberwürfel", "zauberwuerfel", "rubiks cube", "rubik cube", "drehwürfel", "drehwuerfel") }
    "spielzeug_32.png" = @{ name = "Rubik's Cube"; alt = @("rubiks cube", "rubik cube", "zauberwürfel", "zauberwuerfel", "würfel", "wuerfel") }
    "spielzeug_33.png" = @{ name = "Musikinstrumente"; alt = @("musikinstrumente", "rassel", "trommel", "xylophon", "triangel", "instrumente") }
    "spielzeug_34.png" = @{ name = "Dreirad"; alt = @("dreirad", "trike", "kinderdreirad") }
    "spielzeug_35.png" = @{ name = "Jo-Jo"; alt = @("jo-jo", "jojo", "yo-yo", "yoyo") }
    "spielzeug_36.png" = @{ name = "Yo-Yo"; alt = @("yo-yo", "yoyo", "jo-jo", "jojo") }
    "spielzeug_37.png" = @{ name = "Werkbank"; alt = @("werkbank", "kinderwerkbank", "werkzeugbank", "werkzeug") }
    "spielzeug_38.png" = @{ name = "Fingerfarben"; alt = @("fingerfarben", "malkasten", "farben", "tusche") }
    "spielzeug_39.png" = @{ name = "Dartscheibe"; alt = @("dartscheibe", "dart", "klettdart", "zielscheibe") }
    "spielzeug_40.png" = @{ name = "RC-Auto"; alt = @("rc-auto", "rc auto", "ferngesteuertes auto", "rennauto", "auto") }
    "spielzeug_41.png" = @{ name = "Stoffhund"; alt = @("stoffhund", "plüschhund", "plueschhund", "kuschelhund", "hündchen", "huendchen", "welpe") }
    "spielzeug_42.png" = @{ name = "Schaukelpferd"; alt = @("schaukelpferd", "holzpferd", "schaukel") }
    "spielzeug_43.png" = @{ name = "Kaufmannsladen"; alt = @("kaufmannsladen", "kaufladen", "tante emma laden", "supermarkt") }
    "spielzeug_44.png" = @{ name = "Domino"; alt = @("domino", "dominosteine", "dominos") }
    "spielzeug_45.png" = @{ name = "Spielzelt"; alt = @("spielzelt", "kinderzelt", "tipi", "zelt") }
    "spielzeug_46.png" = @{ name = $strassenkreide; alt = @("straßenkreide", "strassenkreide", "kreide", "malkreide") }
    "spielzeug_47.png" = @{ name = "Kreide"; alt = @("kreide", "straßenkreide", "strassenkreide", "buntstifte") }
    "spielzeug_48.png" = @{ name = $huepfball; alt = @("hüpfball", "huepfball", "flummi", "springball", "gummiball") }
    "spielzeug_49.png" = @{ name = "Mikado"; alt = @("mikado", "mikadospiel", "stäbchen", "staebchen") }
    "spielzeug_50.png" = @{ name = "Spielfiguren"; alt = @("spielfiguren", "figuren", "playmobil", "actionfiguren") }
}

# Spezifische Zuweisungen für Familie-Bilder
$familieDefs = @{
    "familie_01.png" = @{ name = "Mama"; alt = @("mama", "mutter", "mami", "mutti", "mom") }
    "familie_02.png" = @{ name = "Papa"; alt = @("papa", "vater", "papi", "vati", "dad") }
    "familie_03.png" = @{ name = "Oma"; alt = @("oma", "gro${ss}mutter", "grossmutter", "omi", "granny", "grandma") }
    "familie_04.png" = @{ name = "Opa"; alt = @("opa", "gro${ss}vater", "grossvater", "opi", "grandpa") }
    "familie_05.png" = @{ name = "Baby"; alt = @("baby", "s${ae}ugling", "saeugling", "kleinkind", "neugeborenes") }
    "familie_06.png" = @{ name = "Bruder"; alt = @("bruder", "geschwister", "br${ue}derchen", "bruederchen", "brother") }
    "familie_07.png" = @{ name = "Schwester"; alt = @("schwester", "geschwister", "schwesterchen", "sister") }
    "familie_08.png" = @{ name = "Geschwister"; alt = @("geschwister", "bruder und schwester", "kinder") }
    "familie_09.png" = @{ name = "Familie"; alt = @("familie", "family", "eltern und kinder", "eltern") }
    "familie_10.png" = @{ name = "Tante"; alt = @("tante", "aunt", "verwandte") }
    "familie_11.png" = @{ name = "Onkel"; alt = @("onkel", "uncle", "verwandter") }
    "familie_12.png" = @{ name = "Cousin"; alt = @("cousin", "vetter", "kuseng") }
    "familie_13.png" = @{ name = "Cousine"; alt = @("cousine", "base", "kusine") }
    "familie_14.png" = @{ name = "Hund"; alt = @("hund", "haustier", "h${ue}ndchen", "huendchen", "welpe", "dog") }
    "familie_15.png" = @{ name = "Katze"; alt = @("katze", "haustier", "k${ae}tzchen", "kaetzchen", "kater", "mieze", "cat") }
    "familie_16.png" = @{ name = "Zuhause"; alt = @("zuhause", "haus", "daheim", "wohnhaus", "heim") }
    "familie_17.png" = @{ name = "Kinderzimmer"; alt = @("kinderzimmer", "spielzimmer", "zimmer") }
    "familie_18.png" = @{ name = "Wohnzimmer"; alt = @("wohnzimmer", "stube", "sofa", "couch") }
    "familie_19.png" = @{ name = $kueche; alt = @("k${ue}che", "kueche", "kochen", "herd") }
    "familie_20.png" = @{ name = "Esstisch"; alt = @("esstisch", "tisch", "mittagessen", "speisetisch") }
    "familie_21.png" = @{ name = $fruehstueck; alt = @("fr${ue}hst${ue}ck", "fruehstueck", "morgenmahlzeit", "m${ue}sli", "toast") }
    "familie_22.png" = @{ name = "Abendessen"; alt = @("abendessen", "abendbrot", "nachtessen") }
    "familie_23.png" = @{ name = "Geburtstag"; alt = @("geburtstag", "geburtstagsfeier", "party", "feier", "birthday") }
    "familie_24.png" = @{ name = "Geburtstagskuchen"; alt = @("geburtstagskuchen", "kuchen", "torte", "geburtstagstorte", "kerzen") }
    "familie_25.png" = @{ name = "Spielplatz"; alt = @("spielplatz", "rutsche", "schaukel", "kletterger${ue}st", "klettergeruest") }
    "familie_26.png" = @{ name = "Picknick"; alt = @("picknick", "picknickkorb", "wiese", "ausflug") }
    "familie_27.png" = @{ name = "Spaziergang"; alt = @("spaziergang", "spazieren", "ausflug", "wandern") }
    "familie_28.png" = @{ name = "Gute-Nacht-Geschichte"; alt = @("gute-nacht-geschichte", "vorlesen", "gutenachtgeschichte", "geschichte", "bettgeschichte", "vorlesebuch") }
    "familie_29.png" = @{ name = "Kuscheln"; alt = @("kuscheln", "umarmung", "umarmen", "schmusen", "herzen") }
    "familie_30.png" = @{ name = "Kinderwagen"; alt = @("kinderwagen", "buggy", "sportwagen") }
    "familie_31.png" = @{ name = "Babybett"; alt = @("babybett", "wiege", "gitterbett", "stubenwagen", "bettchen") }
    "familie_32.png" = @{ name = "Schnuller"; alt = @("schnuller", "nuckel", "didi", "sauger") }
    "familie_33.png" = @{ name = "Schaukel"; alt = @("schaukel", "schaukeln", "kinderschaukel") }
    "familie_34.png" = @{ name = "Sandkasten"; alt = @("sandkasten", "sandkiste", "sand") }
    "familie_35.png" = @{ name = "Garten"; alt = @("garten", "vorgarten", "blumenbeet", "rasen") }
}

$synonymMap = @{
    "Affe"            = @("affe", "schimpanse", "gorilla", "monkey", "ape")
    "Apfel"           = @("apfel", "aepfel", "äpfel", "apple")
    "Auto"            = @("auto", "pkw", "wagen", "fahrzeug", "automobil", "flitzer", "sportwagen")
    $baer             = @("bär", "baer", "braunbär", "braunbaer", "bear")
    "Ball"            = @("ball", "fussball", "fußball", "lederball", "spielball")
    "Banane"          = @("banane", "bananen", "banana")
    "Baum"            = @("baum", "bäume", "baeume", "eiche", "laubbaum", "tree")
    "Blume"           = @("blume", "blumen", "blüte", "bluete", "sonnenblume", "flower")
    "Brille"          = @("brille", "sonnenbrille", "sehbrille", "glasses")
    "Brot"            = @("brot", "brotlaib", "laib", "kastenbrot", "bread")
    "Buch"            = @("buch", "bücher", "buecher", "buchstapel", "lesebuch", "book")
    "Bus"             = @("bus", "reisebus", "omnibus", "stadtbus", "doppeldecker")
    "Delfin"          = @("delfin", "delphin", "dolphin")
    "Eis"             = @("eis", "speiseeis", "eistüte", "eistuete", "eiswaffel", "ice cream")
    "Elefant"         = @("elefant", "dickhäuter", "dickhaeuter", "elephant")
    "Ente"            = @("ente", "enten", "stockente", "duck")
    "Erdbeere"        = @("erdbeere", "erdbeeren", "strawberry")
    "Eule"            = @("eule", "kauz", "schleiereule", "uhu", "owl")
    "Fahrrad"         = @("fahrrad", "rad", "bike", "drahtesel", "velo", "bicycle")
    "Feuerwehr"       = @("feuerwehr", "feuerwehrauto", "löschfahrzeug", "loeschfahrzeug", "feuerwehrwagen", "firetruck")
    "Flugzeug"        = @("flugzeug", "flieger", "jet", "passagierflugzeug", "plane", "airplane")
    "Frosch"          = @("frosch", "laubfrosch", "kröte", "kroete", "frog")
    "Geschenk"        = @("geschenk", "paket", "päckchen", "paeckchen", "geschenkpaket", "present", "gift")
    "Giraffe"         = @("giraffe", "giraffen")
    "Gitarre"         = @("gitarre", "akustikgitarre", "klampfe", "guitar")
    "Hase"            = @("hase", "kaninchen", "feldhase", "bunny", "rabbit")
    $heissluftballon  = @("heißluftballon", "heissluftballon", "ballon", "luftballon", "hot air balloon")
    "Hubschrauber"    = @("hubschrauber", "helikopter", "heli", "helicopter")
    "Hund"            = @("hund", "hündchen", "huendchen", "welpe", "retriever", "dog", "puppy")
    "Igel"            = @("igel", "stacheligel", "hedgehog")
    $kaenguru         = @("känguru", "kaenguru", "kangaroo")
    "Karotte"         = @("karotte", "karotten", "möhre", "moehre", "möhren", "moehren", "rübe", "ruebe", "carrot")
    "Katze"           = @("katze", "kater", "kätzchen", "kaetzchen", "mieze", "miezekatze", "cat", "kitten")
    "Kirsche"         = @("kirsche", "kirschen", "sauerkirsche", "cherry")
    "Koala"           = @("koala", "koalabär", "koalabaer")
    "Krokodil"        = @("krokodil", "alligator", "kroko", "crocodile")
    "Kuh"             = @("kuh", "rind", "milchkuh", "rinder", "cow")
    "Lampe"           = @("lampe", "leuchte", "stehlampe", "schreibtischlampe", "lamp")
    $loewe            = @("löwe", "loewe", "raubkatze", "lion")
    $marienkaefer     = @("marienkäfer", "marienkaefer", "glückskäfer", "glueckskaefer", "ladybug")
    "Mond"            = @("mond", "vollmond", "halbmond", "moon")
    "Motorrad"        = @("motorrad", "moped", "maschine", "motorcycle", "bike")
    "Pferd"           = @("pferd", "pony", "gaul", "hengst", "stute", "horse")
    "Pilz"            = @("pilz", "pilze", "fliegenpilz", "steinpilz", "mushroom")
    "Pinguin"         = @("pinguin", "pinguine", "penguin")
    "Pizza"           = @("pizza", "pizzen", "margherita")
    "Rakete"          = @("rakete", "spaceshuttle", "raumschiff", "rocket")
    "Regenbogen"      = @("regenbogen", "rainbow")
    "Regenschirm"     = @("regenschirm", "schirm", "parapluie", "umbrella")
    "Roboter"         = @("roboter", "blechmann", "android", "robot")
    "Rucksack"        = @("rucksack", "schulranzen", "tornister", "tasche", "backpack")
    "Schaf"           = @("schaf", "schafe", "lamm", "sheep")
    "Schere"          = @("schere", "bastelschere", "scissors")
    "Schiff"          = @("schiff", "boot", "dampfer", "frachter", "kreuzfahrtschiff", "ship", "boat")
    $schildkroete     = @("schildkröte", "schildkroete", "turtle", "tortoise")
    $schluessel       = @("schlüssel", "schluessel", "hausschlüssel", "hausschluessel", "key")
    "Schmetterling"   = @("schmetterling", "falter", "tagfalter", "butterfly")
    "Schneemann"      = @("schneemann", "snowman")
    "Schwein"         = @("schwein", "ferkel", "sau", "eber", "hausschwein", "pig")
    "Skateboard"      = @("skateboard", "skate-board", "board", "skater")
    "Sonne"           = @("sonne", "sonnenschein", "sun")
    $teddybaer        = @("teddybär", "teddybaer", "teddy", "plüschbär", "plueschbaer", "stofftier")
    "Traktor"         = @("traktor", "trecker", "schlepper", "bulldog", "tractor")
    "Trommel"         = @("trommel", "trommeln", "schlagzeug", "snare", "drum", "drums")
    "Uhr"             = @("uhr", "wanduhr", "wecker", "armbanduhr", "clock", "watch")
    "Wassermelone"    = @("wassermelone", "wassermelonen", "melone", "melons", "watermelon")
    "Weintrauben"     = @("weintrauben", "weintraube", "trauben", "traube", "grapes")
    $zahnbuerste      = @("zahnbürste", "zahnbuerste", "kinderzahnbürste", "kinderzahnbuerste", "toothbrush")
    "Zebra"           = @("zebra", "zebras")
    "Zug"             = @("zug", "eisenbahn", "lokomotive", "lok", "bahn", "personenzug", "güterzug", "gueterzug", "train")
}

# Standardkategorien definieren und sicherstellen, dass die Ordner existieren
$standardCategories = @("Familie", "Spielzeuge", "Verschiedenes")
foreach ($cat in $standardCategories) {
    $catDir = Join-Path $bilderDir $cat
    if (-not (Test-Path $catDir)) {
        New-Item -ItemType Directory -Path $catDir -Force | Out-Null
    }
}

# Alle Unterordner ermitteln (Kategorien)
$allSubDirs = Get-ChildItem -Path $bilderDir -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
$categories = @()
foreach ($cat in $standardCategories) {
    $categories += $cat
}
foreach ($sd in $allSubDirs) {
    if ($categories -notcontains $sd) {
        $categories += $sd
    }
}

$categoriesResult = [ordered]@{}
$totalImagesCount = 0

foreach ($cat in $categories) {
    $catDir = Join-Path $bilderDir $cat
    $files = Get-ChildItem -Path $catDir -File -ErrorAction SilentlyContinue | Where-Object {
        $_.Extension -match '^\.(jpg|jpeg|png|webp|gif)$'
    } | Sort-Object Name

    $items = @()
    foreach ($f in $files) {
        $fileName = $f.Name
        $relPath = "$cat/$fileName"

        # Prüfe ob vordefinierte Spielzeug-Eigenschaften greifen
        if ($cat -eq "Spielzeuge" -and $spielzeugDefs.ContainsKey($fileName)) {
            $def = $spielzeugDefs[$fileName]
            $items += [PSCustomObject]@{
                name     = $def.name
                file     = $relPath
                category = $cat
                alt      = $def.alt
            }
            continue
        }

        # Prüfe ob vordefinierte Familie-Eigenschaften greifen
        if ($cat -eq "Familie" -and $familieDefs.ContainsKey($fileName)) {
            $def = $familieDefs[$fileName]
            $items += [PSCustomObject]@{
                name     = $def.name
                file     = $relPath
                category = $cat
                alt      = $def.alt
            }
            continue
        }

        # Dynamische Erkennung anhand des Dateinamens
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        $cleanName = $baseName -replace '^\d+[\s_-]*', ''
        
        $displayName = if ($umlautMap.ContainsKey($cleanName)) { $umlautMap[$cleanName] } else { $cleanName }
        $alts = if ($synonymMap.ContainsKey($displayName)) { $synonymMap[$displayName] } else { @($displayName.ToLower()) }

        $items += [PSCustomObject]@{
            name     = $displayName
            file     = $relPath
            category = $cat
            alt      = $alts
        }
    }

    $categoriesResult[$cat] = $items
    $totalImagesCount += $items.Count
    Write-Host "  -> Kategorie '$cat': $($items.Count) Bilder gefunden." -ForegroundColor Cyan
}

$jsonCategories = $categoriesResult | ConvertTo-Json -Depth 5
$dateStr = Get-Date -Format 'dd.MM.yyyy HH:mm:ss'

$jsContent = "// Dalli Klick - Bilderdatenbank nach Kategorien`n// Automatisch generiert: $dateStr`n// Kategorien: $($categories -join ', ')`n// Gesamtzahl Bilder: $totalImagesCount`n`nwindow.BILDER_KATEGORIEN = $jsonCategories;`n`n// Kompatibilitaet: Standard-Kategorie ist Verschiedenes`nwindow.BILDER_LISTE = window.BILDER_KATEGORIEN['Verschiedenes'] || [];`n"

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($outputFile, $jsContent, $utf8NoBom)

Write-Host "========================================================" -ForegroundColor Green
Write-Host "Erfolgreich $totalImagesCount Bilder in $($categories.Count) Kategorien gespeichert!" -ForegroundColor Green
Write-Host "Zieldatei: '$outputFile'" -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Green
