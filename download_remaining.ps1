$destDir = Join-Path $PSScriptRoot "bilder"

$remaining = @(
    @{ Name = "Marienkaefer"; Query = "Seven-spot ladybird Coccinella septempunctata" },
    @{ Name = "Kuh"; Query = "Dairy cow grazing pasture photo" },
    @{ Name = "Karotte"; Query = "Fresh orange carrots bunch" },
    @{ Name = "Pizza"; Query = "Whole baked pizza margherita" },
    @{ Name = "Weintrauben"; Query = "Bunch of grapes green white" },
    @{ Name = "Teddybaer"; Query = "Classic plush teddy bear toy" },
    @{ Name = "Rucksack"; Query = "Backpack bag school outdoor" },
    @{ Name = "Skateboard"; Query = "Skateboard on street deck" },
    @{ Name = "Baum"; Query = "Single oak tree in green field" },
    @{ Name = "Regenbogen"; Query = "Rainbow landscape sky nature" },
    @{ Name = "Pilz"; Query = "Fly agaric mushroom Amanita muscaria" },
    @{ Name = "Roboter"; Query = "Humanoid robot standing android" }
)

Write-Host "Lade die verbleibenden $($remaining.Count) Bilder herunter..." -ForegroundColor Cyan

foreach ($item in $remaining) {
    $filePath = Join-Path $destDir "$($item.Name).jpg"
    if ((Test-Path $filePath) -and ((Get-Item $filePath).Length -gt 15000)) {
        Write-Host "[$($item.Name)] Bereits vorhanden." -ForegroundColor Green
        continue
    }

    $encoded = [Uri]::EscapeDataString($item.Query)
    $apiUrl = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrsearch=$encoded&gsrnamespace=6&gsrlimit=4&prop=imageinfo&iiprop=url|mime&iiurlwidth=900&format=json"

    try {
        Start-Sleep -Seconds 2
        $res = Invoke-RestMethod -Uri $apiUrl -UserAgent "DalliEducationalApp/2.0 (nonprofit kid game; edu@antigravity.test)" -TimeoutSec 15
        
        $downloadUrl = $null
        if ($res.query -and $res.query.pages) {
            $pages = $res.query.pages.PSObject.Properties.Value
            foreach ($p in $pages) {
                $info = $p.imageinfo[0]
                if ($info -and ($info.mime -eq "image/jpeg" -or $info.mime -eq "image/png")) {
                    $downloadUrl = if ($info.thumburl) { $info.thumburl } else { $info.url }
                    break
                }
            }
        }

        if ($downloadUrl) {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $filePath -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -TimeoutSec 20
            if ((Test-Path $filePath) -and ((Get-Item $filePath).Length -gt 10000)) {
                Write-Host "[$($item.Name)] Erfolgreich ($([math]::Round((Get-Item $filePath).Length/1024)) KB)" -ForegroundColor Green
            } else {
                Write-Host "[$($item.Name)] Fehler beim Speichern." -ForegroundColor Yellow
            }
        } else {
            Write-Host "[$($item.Name)] Keine passende URL gefunden." -ForegroundColor Red
        }
    } catch {
        Write-Host "[$($item.Name)] Fehler: $($_.Exception.Message)" -ForegroundColor Red
    }
}

$total = (Get-ChildItem $destDir -Filter *.jpg).Count
Write-Host "Gesamtzahl Bilder im Ordner 'bilder': $total" -ForegroundColor Cyan
