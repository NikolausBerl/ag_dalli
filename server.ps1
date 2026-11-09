# PowerShell Mini HTTP-Server für Dalli Klick
# Bietet dynamische Ordnererkennung unter /api/bilder und liefert statische Dateien aus

$port = 8085
$root = $PSScriptRoot
$bilderDir = Join-Path $root "bilder"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

try {
    $listener.Start()
    Write-Host "==========================================================" -ForegroundColor Green
    Write-Host "  Dalli Klick Server läuft auf: http://localhost:$port/" -ForegroundColor Cyan
    Write-Host "  Ordner für Bilder: $bilderDir" -ForegroundColor Yellow
    Write-Host "  (Beliebig Bilder hinzufügen oder entfernen)" -ForegroundColor Gray
    Write-Host "==========================================================" -ForegroundColor Green
    Write-Host "Druecke Strg+C zum Beenden." -ForegroundColor DarkGray
    
    # Automatisch im Standardbrowser öffnen
    Start-Process "http://localhost:$port/"
} catch {
    Write-Host "Fehler beim Starten des Servers auf Port $port : $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".png"  = "image/png"
    ".webp" = "image/webp"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
}

$ae = [char]0x00E4
$oe = [char]0x00F6
$ue = [char]0x00FC
$sz = [char]0x00DF

$prettyNames = @{
    "Baer" = "B${ae}r"
    "Loewe" = "L${oe}we"
    "Kaenguru" = "K${ae}nguru"
    "Schildkroete" = "Schildkr${oe}te"
    "Schluessel" = "Schl${ue}ssel"
    "Zahnbuerste" = "Zahnb${ue}rste"
    "Marienkaefer" = "Marienk${ae}fer"
    "Teddybaer" = "Teddyb${ae}r"
    "Heissluftballon" = "Hei${sz}luftballon"
}

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $rawUrl = [System.Uri]::UnescapeDataString($request.RawUrl)
        $cleanPath = $rawUrl.Split('?')[0].TrimStart('/')

        if ([string]::IsNullOrWhiteSpace($cleanPath)) {
            $cleanPath = "index.html"
        }

        # API-Endpunkt für dynamische Bilderliste
        if ($cleanPath -eq "api/bilder") {
            $bilderJs = Join-Path $root "bilder.js"
            if (Test-Path $bilderJs) {
                $rawJs = [System.IO.File]::ReadAllText($bilderJs, [System.Text.Encoding]::UTF8)
                if ($rawJs -match 'window\.BILDER_LISTE\s*=\s*(\[[\s\S]*?\]);') {
                    $jsonString = $matches[1]
                    $utf8 = New-Object System.Text.UTF8Encoding($false)
                    $jsonBytes = $utf8.GetBytes($jsonString)
                    $response.ContentType = "application/json; charset=utf-8"
                    $response.ContentLength64 = $jsonBytes.Length
                    $response.StatusCode = 200
                    $response.OutputStream.Write($jsonBytes, 0, $jsonBytes.Length)
                    $response.Close()
                    continue
                }
            }

            $files = Get-ChildItem -Path $bilderDir -File -ErrorAction SilentlyContinue | Where-Object {
                $_.Extension -match '^\.(jpg|jpeg|png|webp|gif)$'
            }

            $imgList = @()
            foreach ($f in $files) {
                $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
                $cleanName = $base -replace '^\d+[\s_-]*', ''
                $displayName = if ($prettyNames.ContainsKey($cleanName)) { $prettyNames[$cleanName] } else { $cleanName }
                $imgList += @{
                    name = $displayName
                    file = $f.Name
                }
            }

            $utf8 = New-Object System.Text.UTF8Encoding($false)
            $jsonString = ($imgList | ConvertTo-Json -Compress)
            $jsonBytes = $utf8.GetBytes($jsonString)
            $response.ContentType = "application/json; charset=utf-8"
            $response.ContentLength64 = $jsonBytes.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($jsonBytes, 0, $jsonBytes.Length)
            $response.Close()
            continue
        }

        # Statische Datei servieren
        $targetFile = Join-Path $root ($cleanPath -replace '/', '\')
        if (Test-Path $targetFile -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($targetFile).ToLower()
            $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
            $bytes = [System.IO.File]::ReadAllBytes($targetFile)

            $response.ContentType = $mime
            $response.ContentLength64 = $bytes.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $err = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.OutputStream.Write($err, 0, $err.Length)
        }

        $response.Close()
    } catch {
        break
    }
}
