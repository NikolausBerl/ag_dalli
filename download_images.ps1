# Script to download 70 royalty-free child-friendly images from Wikimedia Commons

$ErrorActionPreference = "Continue"

$destDir = Join-Path $PSScriptRoot "bilder"
if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
}

$items = @(
    # --- TIERE (25) ---
    @{ Name = "Hund"; Query = "Golden Retriever dog photo"; Alt = @("hund", "dog", "welpe") },
    @{ Name = "Katze"; Query = "Tabby cat sitting photo"; Alt = @("katze", "kater", "kätzchen") },
    @{ Name = "Elefant"; Query = "African bush elephant photo"; Alt = @("elefant", "elephant") },
    @{ Name = "Giraffe"; Query = "Giraffe standing photo"; Alt = @("giraffe") },
    @{ Name = "Löwe"; Query = "Male lion portrait photo"; Alt = @("löwe", "loewe", "lion") },
    @{ Name = "Bär"; Query = "Brown bear standing photo"; Alt = @("bär", "baer", "braunbär") },
    @{ Name = "Pinguin"; Query = "Emperor penguin standing ice"; Alt = @("pinguin", "penguin") },
    @{ Name = "Delfin"; Query = "Bottlenose dolphin jumping"; Alt = @("delfin", "delphin", "dolphin") },
    @{ Name = "Schmetterling"; Query = "Monarch butterfly flower photo"; Alt = @("schmetterling", "falter") },
    @{ Name = "Hase"; Query = "European hare photo"; Alt = @("hase", "kaninchen") },
    @{ Name = "Schildkröte"; Query = "Giant tortoise photo"; Alt = @("schildkröte", "schildkroete") },
    @{ Name = "Frosch"; Query = "Green tree frog photo"; Alt = @("frosch", "laubfrosch") },
    @{ Name = "Ente"; Query = "Mallard duck swimming"; Alt = @("ente", "stockente") },
    @{ Name = "Eule"; Query = "Barn owl portrait photo"; Alt = @("eule", "kauz", "schleiereule") },
    @{ Name = "Pferd"; Query = "Horse standing pasture photo"; Alt = @("pferd", "pony", "gaul") },
    @{ Name = "Krokodil"; Query = "Nile crocodile basking photo"; Alt = @("krokodil", "alligator") },
    @{ Name = "Affe"; Query = "Chimpanzee portrait photo"; Alt = @("affe", "schimpanse") },
    @{ Name = "Zebra"; Query = "Plains zebra standing photo"; Alt = @("zebra") },
    @{ Name = "Igel"; Query = "European hedgehog photo"; Alt = @("igel") },
    @{ Name = "Marienkäfer"; Query = "Seven-spot ladybird photo"; Alt = @("marienkäfer", "marienkaefer", "glückskäfer") },
    @{ Name = "Koala"; Query = "Koala in eucalyptus tree photo"; Alt = @("koala", "koalabär") },
    @{ Name = "Känguru"; Query = "Red kangaroo standing photo"; Alt = @("känguru", "kaenguru", "kangaroo") },
    @{ Name = "Schaf"; Query = "Domestic sheep grazing photo"; Alt = @("schaf", "lamm") },
    @{ Name = "Schwein"; Query = "Piglet domestic pig photo"; Alt = @("schwein", "ferkel") },
    @{ Name = "Kuh"; Query = "Dairy cow standing pasture photo"; Alt = @("kuh", "rind", "rinder") },

    # --- FAHRZEUGE (12) ---
    @{ Name = "Auto"; Query = "Red passenger car photo"; Alt = @("auto", "pkw", "wagen", "automobil") },
    @{ Name = "Fahrrad"; Query = "Bicycle city bike photo"; Alt = @("fahrrad", "rad", "bike", "drahtesel") },
    @{ Name = "Flugzeug"; Query = "Commercial airplane in flight photo"; Alt = @("flugzeug", "flieger") },
    @{ Name = "Hubschrauber"; Query = "Helicopter in flight photo"; Alt = @("hubschrauber", "helikopter") },
    @{ Name = "Schiff"; Query = "Cruise ship sailing photo"; Alt = @("schiff", "dampfer", "boot") },
    @{ Name = "Zug"; Query = "Passenger train railway photo"; Alt = @("zug", "eisenbahn", "bahn", "lokomotive") },
    @{ Name = "Traktor"; Query = "Farm tractor in field photo"; Alt = @("traktor", "trecker", "schlepper") },
    @{ Name = "Feuerwehr"; Query = "Fire engine firetruck photo"; Alt = @("feuerwehr", "feuerwehrauto") },
    @{ Name = "Rakete"; Query = "Space rocket launch photo"; Alt = @("rakete", "space shuttle") },
    @{ Name = "Motorrad"; Query = "Motorcycle motorbike photo"; Alt = @("motorrad", "moped", "bike") },
    @{ Name = "Bus"; Query = "City bus transport photo"; Alt = @("bus", "reisebus", "omnibus") },
    @{ Name = "Heißluftballon"; Query = "Hot air balloon in flight photo"; Alt = @("heißluftballon", "heissluftballon", "ballon") },

    # --- ESSEN & TRINKEN (10) ---
    @{ Name = "Apfel"; Query = "Red apple fruit photo"; Alt = @("apfel") },
    @{ Name = "Banane"; Query = "Ripe yellow banana bunch photo"; Alt = @("banane") },
    @{ Name = "Erdbeere"; Query = "Fresh strawberry fruit photo"; Alt = @("erdbeere", "erdbeeren") },
    @{ Name = "Karotte"; Query = "Fresh orange carrots bunch photo"; Alt = @("karotte", "möhre", "moehre") },
    @{ Name = "Pizza"; Query = "Whole baked pizza margherita photo"; Alt = @("pizza") },
    @{ Name = "Eis"; Query = "Ice cream cone scoops photo"; Alt = @("eis", "speiseeis", "eiswaffel") },
    @{ Name = "Brot"; Query = "Fresh loaf of bread artisan photo"; Alt = @("brot", "laib brot") },
    @{ Name = "Kirsche"; Query = "Ripe red cherries with stem photo"; Alt = @("kirsche", "kirschen") },
    @{ Name = "Wassermelone"; Query = "Slice of watermelon photo"; Alt = @("wassermelone", "melone") },
    @{ Name = "Weintrauben"; Query = "Bunch of grapes photo"; Alt = @("weintrauben", "trauben") },

    # --- GEGENSTÄNDE & SPIELZEUG (15) ---
    @{ Name = "Ball"; Query = "Soccer ball football grass photo"; Alt = @("ball", "fußball", "fussball") },
    @{ Name = "Teddybär"; Query = "Classic plush teddy bear toy photo"; Alt = @("teddybär", "teddybaer", "teddy", "kuschelbär") },
    @{ Name = "Buch"; Query = "Open hardcover book photo"; Alt = @("buch", "bücher") },
    @{ Name = "Brille"; Query = "Pair of eyeglasses spectacles photo"; Alt = @("brille", "sehbrille") },
    @{ Name = "Rucksack"; Query = "School backpack bag photo"; Alt = @("rucksack", "schulranzen") },
    @{ Name = "Gitarre"; Query = "Acoustic guitar standing photo"; Alt = @("gitarre") },
    @{ Name = "Uhr"; Query = "Classic alarm clock photo"; Alt = @("uhr", "wecker", "armbanduhr") },
    @{ Name = "Schere"; Query = "Pair of scissors photo"; Alt = @("schere") },
    @{ Name = "Regenschirm"; Query = "Open colorful umbrella photo"; Alt = @("regenschirm", "schirm") },
    @{ Name = "Zahnbürste"; Query = "Toothbrush bristles photo"; Alt = @("zahnbürste", "zahnbuerste") },
    @{ Name = "Lampe"; Query = "Desk lamp table lamp photo"; Alt = @("lampe", "leuchte", "schreibtischlampe") },
    @{ Name = "Schlüssel"; Query = "Metal house key photo"; Alt = @("schlüssel", "schluessel") },
    @{ Name = "Geschenk"; Query = "Wrapped gift box ribbon photo"; Alt = @("geschenk", "päckchen") },
    @{ Name = "Trommel"; Query = "Snare drum instrument photo"; Alt = @("trommel", "schlagzeug") },
    @{ Name = "Skateboard"; Query = "Skateboard on street photo"; Alt = @("skateboard", "board") },

    # --- NATUR & TECHNIK (8) ---
    @{ Name = "Blume"; Query = "Sunflower blossom bright photo"; Alt = @("blume", "sonnenblume", "blüte") },
    @{ Name = "Baum"; Query = "Oak tree in green field photo"; Alt = @("baum", "eiche", "laubbaum") },
    @{ Name = "Regenbogen"; Query = "Vibrant rainbow sky landscape photo"; Alt = @("regenbogen") },
    @{ Name = "Sonne"; Query = "Bright sun shining sky photo"; Alt = @("sonne", "sonnenschein") },
    @{ Name = "Mond"; Query = "Full moon night sky photo"; Alt = @("mond", "vollmond") },
    @{ Name = "Schneemann"; Query = "Snowman with carrot nose winter photo"; Alt = @("schneemann") },
    @{ Name = "Pilz"; Query = "Fly agaric red toadstool mushroom photo"; Alt = @("pilz", "fliegenpilz") },
    @{ Name = "Roboter"; Query = "Humanoid robot standing photo"; Alt = @("roboter") }
)

Write-Host "Starte Download von $($items.Count) kinderfreundlichen Begriffen..." -ForegroundColor Cyan

$successCount = 0
$results = @()

foreach ($item in $items) {
    $name = $item.Name
    $filePath = Join-Path $destDir "$name.jpg"
    
    # Check if already downloaded and valid
    if ((Test-Path $filePath) -and ((Get-Item $filePath).Length -gt 15000)) {
        Write-Host "[$($item.Name)] Bereits vorhanden." -ForegroundColor Green
        $results += [PSCustomObject]@{
            Name = $name
            File = "$name.jpg"
            Alt = $item.Alt
        }
        $successCount++
        continue
    }

    $encoded = [Uri]::EscapeDataString($item.Query)
    $apiUrl = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrsearch=$encoded&gsrnamespace=6&gsrlimit=3&prop=imageinfo&iiprop=url|mime&iiurlwidth=900&format=json"
    
    try {
        $res = Invoke-RestMethod -Uri $apiUrl -UserAgent "DalliKlickBot/1.0 (child game; contact: mail@example.com)" -TimeoutSec 15
        $pages = $res.query.pages.PSObject.Properties.Value
        
        $downloadUrl = $null
        foreach ($p in $pages) {
            $info = $p.imageinfo[0]
            if ($info -and ($info.mime -eq "image/jpeg" -or $info.mime -eq "image/png")) {
                $downloadUrl = if ($info.thumburl) { $info.thumburl } else { $info.url }
                break
            }
        }
        
        if (-not $downloadUrl -and $pages.Count -gt 0) {
            $downloadUrl = $pages[0].imageinfo[0].thumburl
        }

        if ($downloadUrl) {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $filePath -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -TimeoutSec 20
            if ((Test-Path $filePath) -and ((Get-Item $filePath).Length -gt 10000)) {
                Write-Host "[$name] Erfolgreich heruntergeladen ($([math]::Round((Get-Item $filePath).Length/1024)) KB)" -ForegroundColor Green
                $successCount++
                $results += [PSCustomObject]@{
                    Name = $name
                    File = "$name.jpg"
                    Alt = $item.Alt
                }
            } else {
                Write-Host "[$name] Datei zu klein oder ungueltig." -ForegroundColor Yellow
            }
        } else {
            Write-Host "[$name] Keine passende Bild-URL gefunden." -ForegroundColor Red
        }
    } catch {
        Write-Host "[$name] Fehler: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Polite delay to respect API rate limits
    Start-Sleep -Milliseconds 250
}

Write-Host "Download abgeschlossen: $successCount von $($items.Count) Bildern bereit." -ForegroundColor Cyan
