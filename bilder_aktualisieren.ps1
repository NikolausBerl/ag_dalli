# Skript zur Erstellung von bilder.js mit sauberen Anzeigenamen und Synonymen
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
}

$synonymMap = @{
    "Affe"            = @("affe", "schimpanse", "gorilla", "monkey", "ape")
    "Apfel"           = @("apfel", "aepfel", "Ã¤pfel", "apple")
    "Auto"            = @("auto", "pkw", "wagen", "fahrzeug", "automobil", "flitzer", "sportwagen")
    $baer             = @("bÃ¤r", "baer", "braunbÃ¤r", "braunbaer", "bear")
    "Ball"            = @("ball", "fussball", "fuÃŸball", "lederball", "spielball")
    "Banane"          = @("banane", "bananen", "banana")
    "Baum"            = @("baum", "bÃ¤ume", "baeume", "eiche", "laubbaum", "tree")
    "Blume"           = @("blume", "blumen", "blÃ¼te", "bluete", "sonnenblume", "flower")
    "Brille"          = @("brille", "sonnenbrille", "sehbrille", "glasses")
    "Brot"            = @("brot", "brotlaib", "laib", "kastenbrot", "bread")
    "Buch"            = @("buch", "bÃ¼cher", "buecher", "buchstapel", "lesebuch", "book")
    "Bus"             = @("bus", "reisebus", "omnibus", "stadtbus", "doppeldecker")
    "Delfin"          = @("delfin", "delphin", "dolphin")
    "Eis"             = @("eis", "speiseeis", "eistÃ¼te", "eistuete", "eiswaffel", "ice cream")
    "Elefant"         = @("elefant", "dickhÃ¤uter", "dickhaeuter", "elephant")
    "Ente"            = @("ente", "enten", "stockente", "duck")
    "Erdbeere"        = @("erdbeere", "erdbeeren", "strawberry")
    "Eule"            = @("eule", "kauz", "schleiereule", "uhu", "owl")
    "Fahrrad"         = @("fahrrad", "rad", "bike", "drahtesel", "velo", "bicycle")
    "Feuerwehr"       = @("feuerwehr", "feuerwehrauto", "lÃ¶schfahrzeug", "loeschfahrzeug", "feuerwehrwagen", "firetruck")
    "Flugzeug"        = @("flugzeug", "flieger", "jet", "passagierflugzeug", "plane", "airplane")
    "Frosch"          = @("frosch", "laubfrosch", "krÃ¶te", "kroete", "frog")
    "Geschenk"        = @("geschenk", "paket", "pÃ¤ckchen", "paeckchen", "geschenkpaket", "present", "gift")
    "Giraffe"         = @("giraffe", "giraffen")
    "Gitarre"         = @("gitarre", "akustikgitarre", "klampfe", "guitar")
    "Hase"            = @("hase", "kaninchen", "feldhase", "bunny", "rabbit")
    $heissluftballon  = @("heiÃŸluftballon", "heissluftballon", "ballon", "luftballon", "hot air balloon")
    "Hubschrauber"    = @("hubschrauber", "helikopter", "heli", "helicopter")
    "Hund"            = @("hund", "hÃ¼ndchen", "huendchen", "welpe", "retriever", "dog", "puppy")
    "Igel"            = @("igel", "stacheligel", "hedgehog")
    $kaenguru         = @("kÃ¤nguru", "kaenguru", "kangaroo")
    "Karotte"         = @("karotte", "karotten", "mÃ¶hre", "moehre", "mÃ¶hren", "moehren", "rÃ¼be", "ruebe", "carrot")
    "Katze"           = @("katze", "kater", "kÃ¤tzchen", "kaetzchen", "mieze", "miezekatze", "cat", "kitten")
    "Kirsche"         = @("kirsche", "kirschen", "sauerkirsche", "cherry")
    "Koala"           = @("koala", "koalabÃ¤r", "koalabaer")
    "Krokodil"        = @("krokodil", "alligator", "kroko", "crocodile")
    "Kuh"             = @("kuh", "rind", "milchkuh", "rinder", "cow")
    "Lampe"           = @("lampe", "leuchte", "stehlampe", "schreibtischlampe", "lamp")
    $loewe            = @("lÃ¶we", "loewe", "raubkatze", "lion")
    $marienkaefer     = @("marienkÃ¤fer", "marienkaefer", "glÃ¼ckskÃ¤fer", "glueckskaefer", "ladybug")
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
    $schildkroete     = @("schildkrÃ¶te", "schildkroete", "turtle", "tortoise")
    $schluessel       = @("schlÃ¼ssel", "schluessel", "hausschlÃ¼ssel", "hausschluessel", "key")
    "Schmetterling"   = @("schmetterling", "falter", "tagfalter", "butterfly")
    "Schneemann"      = @("schneemann", "snowman")
    "Schwein"         = @("schwein", "ferkel", "sau", "eber", "hausschwein", "pig")
    "Skateboard"      = @("skateboard", "skate-board", "board", "skater")
    "Sonne"           = @("sonne", "sonnenschein", "sun")
    $teddybaer        = @("teddybÃ¤r", "teddybaer", "teddy", "plÃ¼schbÃ¤r", "plueschbaer", "stofftier")
    "Traktor"         = @("traktor", "trecker", "schlepper", "bulldog", "tractor")
    "Trommel"         = @("trommel", "trommeln", "schlagzeug", "snare", "drum", "drums")
    "Uhr"             = @("uhr", "wanduhr", "wecker", "armbanduhr", "clock", "watch")
    "Wassermelone"    = @("wassermelone", "wassermelonen", "melone", "melons", "watermelon")
    "Weintrauben"     = @("weintrauben", "weintraube", "trauben", "traube", "grapes")
    $zahnbuerste      = @("zahnbÃ¼rste", "zahnbuerste", "kinderzahnbÃ¼rste", "kinderzahnbuerste", "toothbrush")
    "Zebra"           = @("zebra", "zebras")
    "Zug"             = @("zug", "eisenbahn", "lokomotive", "lok", "bahn", "personenzug", "gÃ¼terzug", "gueterzug", "train")
}

$files = Get-ChildItem -Path $bilderDir -File -ErrorAction SilentlyContinue | Where-Object {
    $_.Extension -match '^\.(jpg|jpeg|png|webp|gif)$'
}

$items = @()
foreach ($f in $files) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $cleanName = $baseName -replace '^\d+[\s_-]*', ''
    
    # Pruefe auf Schoenschreibung mit Umlauten
    $displayName = if ($umlautMap.ContainsKey($cleanName)) { $umlautMap[$cleanName] } else { $cleanName }
    $alts = if ($synonymMap.ContainsKey($displayName)) { $synonymMap[$displayName] } else { @($displayName.ToLower()) }

    $items += [PSCustomObject]@{
        name = $displayName
        file = $f.Name
        alt  = $alts
    }
}

$json = $items | ConvertTo-Json -Depth 4
$dateStr = Get-Date -Format 'dd.MM.yyyy HH:mm:ss'
$jsContent = "// Dalli Klick - Bilderdatenbank`n// Automatisch generiert: $dateStr`n// Anzahl Bilder: $($items.Count)`nwindow.BILDER_LISTE = $json;`n"

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($outputFile, $jsContent, $utf8NoBom)
Write-Host "Erfolgreich $($items.Count) Bilder mit sauberen Umlauten und Synonymen in '$outputFile' gespeichert!" -ForegroundColor Green

