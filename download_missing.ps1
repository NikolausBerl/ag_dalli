# Download remaining high-resolution royalty-free images from Unsplash
$destDir = Join-Path $PSScriptRoot "bilder"

$directSources = @{
    "Kuh"        = "https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?w=800&q=80"
    "Karotte"    = "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=800&q=80"
    "Pizza"      = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&q=80"
    "Teddybaer"  = "https://images.unsplash.com/photo-1559454403-b8fb88521f11?w=800&q=80"
    "Rucksack"   = "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=80"
    "Baum"       = "https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800&q=80"
    "Regenbogen" = "https://images.unsplash.com/photo-1508739773434-c26b3d09e071?w=800&q=80"
    "Pilz"       = "https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&q=80"
    "Roboter"    = "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&q=80"
}

foreach ($name in $directSources.Keys) {
    $target = Join-Path $destDir "$name.jpg"
    if (-not (Test-Path $target) -or ((Get-Item $target).Length -lt 15000)) {
        Write-Host "Lade $name herunter..." -ForegroundColor Yellow
        $url = $directSources[$name]
        try {
            Invoke-WebRequest -Uri $url -OutFile $target -UserAgent "Mozilla/5.0" -TimeoutSec 15
            Write-Host "[$name] Erfolgreich ($([math]::Round((Get-Item $target).Length/1024)) KB)" -ForegroundColor Green
        } catch {
            Write-Host "[$name] Fehler: $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "[$name] Bereits vorhanden." -ForegroundColor DarkGray
    }
}
