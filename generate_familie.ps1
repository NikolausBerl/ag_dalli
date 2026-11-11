# Generator Script for Familie Category (35 Images)
$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$outDir = Join-Path $PSScriptRoot "bilder\Familie"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

function Render-Card($num, $label, $bgGrad, $badgeColor, $svgContent) {
    $html = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body {
    width: 1200px;
    height: 900px;
    background: radial-gradient(circle at 50% 45%, #ffffff 0%, $bgGrad 100%);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    padding: 50px 40px 45px;
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Arial, sans-serif;
  }
  .toy-area {
    flex: 1;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .toy-svg {
    filter: drop-shadow(0 20px 30px rgba(0,0,0,0.16));
  }
  .label-container {
    padding-top: 10px;
  }
  .label-badge {
    background: #ffffff;
    border: 4px solid $badgeColor;
    border-radius: 50px;
    padding: 16px 70px;
    font-size: 54px;
    font-weight: 900;
    color: $badgeColor;
    letter-spacing: 4px;
    box-shadow: 0 12px 28px rgba(0,0,0,0.10);
  }
</style>
</head>
<body>
  <div class="toy-area">
    $svgContent
  </div>
  <div class="label-container">
    <div class="label-badge">$label</div>
  </div>
</body>
</html>
"@
    $htmlFile = Join-Path $env:TEMP "card_fam_$num.html"
    [System.IO.File]::WriteAllText($htmlFile, $html, [System.Text.Encoding]::UTF8)
    $pngFile = Join-Path $outDir "familie_$num.png"
    $uri = "file:///" + $htmlFile.Replace('\', '/')
    Start-Process -FilePath $edge -ArgumentList "--headless=new","--screenshot=$pngFile","--window-size=1200,900","--hide-scrollbars",$uri -Wait
    Write-Host "Rendered: familie_$num.png ($label)" -ForegroundColor Green
}

# 01: MAMA
$svg01 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Hair behind -->
    <ellipse cx="100" cy="115" rx="65" ry="70" fill="#92400e"/>
    <!-- Body / Blouse -->
    <path d="M 50 230 C 50 170 150 170 150 230 Z" fill="#ec4899" stroke="#be185d" stroke-width="4"/>
    <polygon points="100,185 85,170 115,170" fill="#fbcfe8"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="45" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Front Hair / Bangs -->
    <path d="M 55 105 Q 100 65 145 105 Q 140 80 100 75 Q 60 80 55 105 Z" fill="#92400e"/>
    <ellipse cx="48" cy="120" rx="12" ry="25" fill="#92400e"/>
    <ellipse cx="152" cy="120" rx="12" ry="25" fill="#92400e"/>
    <!-- Eyes -->
    <circle cx="82" cy="115" r="6" fill="#1e293b"/>
    <circle cx="84" cy="113" r="2" fill="#ffffff"/>
    <circle cx="118" cy="115" r="6" fill="#1e293b"/>
    <circle cx="120" cy="113" r="2" fill="#ffffff"/>
    <!-- Eyelashes -->
    <path d="M 76 108 L 82 110 L 88 108" fill="none" stroke="#1e293b" stroke-width="2"/>
    <path d="M 112 108 L 118 110 L 124 108" fill="none" stroke="#1e293b" stroke-width="2"/>
    <!-- Cheeks & Smile -->
    <circle cx="72" cy="125" r="7" fill="#f43f5e" opacity="0.3"/>
    <circle cx="128" cy="125" r="7" fill="#f43f5e" opacity="0.3"/>
    <path d="M 90 130 Q 100 142 110 130" fill="none" stroke="#be185d" stroke-width="3" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "01" "MAMA" "#fdf2f8" "#db2777" $svg01

# 02: PAPA
$svg02 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Hair -->
    <path d="M 50 110 Q 50 65 100 65 Q 150 65 150 110 Z" fill="#451a03"/>
    <!-- Body / Shirt -->
    <path d="M 45 230 C 45 165 155 165 155 230 Z" fill="#0284c7" stroke="#0369a1" stroke-width="4"/>
    <polygon points="100,185 80,165 120,165" fill="#ffffff"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="45" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Modern neat hair top -->
    <path d="M 55 100 Q 100 70 145 95 Q 140 75 100 70 Q 60 75 55 100 Z" fill="#451a03"/>
    <!-- Ears -->
    <circle cx="52" cy="115" r="10" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
    <circle cx="148" cy="115" r="10" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
    <!-- Eyes -->
    <circle cx="82" cy="112" r="6" fill="#1e293b"/>
    <circle cx="84" cy="110" r="2" fill="#ffffff"/>
    <circle cx="118" cy="112" r="6" fill="#1e293b"/>
    <circle cx="120" cy="110" r="2" fill="#ffffff"/>
    <!-- Friendly Eyebrows -->
    <path d="M 75 102 Q 83 98 90 102" fill="none" stroke="#451a03" stroke-width="3" stroke-linecap="round"/>
    <path d="M 110 102 Q 117 98 125 102" fill="none" stroke="#451a03" stroke-width="3" stroke-linecap="round"/>
    <!-- Friendly Smile -->
    <path d="M 88 132 Q 100 145 112 132" fill="none" stroke="#b45309" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "02" "PAPA" "#e0f2fe" "#0284c7" $svg02

# 03: OMA
$svg03 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Grey bun hair behind -->
    <circle cx="100" cy="65" r="26" fill="#cbd5e1" stroke="#94a3b8" stroke-width="3"/>
    <ellipse cx="100" cy="115" rx="65" ry="60" fill="#cbd5e1" stroke="#94a3b8" stroke-width="3"/>
    <!-- Body / Lavender Cardigan -->
    <path d="M 50 230 C 50 170 150 170 150 230 Z" fill="#8b5cf6" stroke="#6d28d9" stroke-width="4"/>
    <circle cx="100" cy="190" r="4" fill="#ffffff"/>
    <circle cx="100" cy="210" r="4" fill="#ffffff"/>
    <!-- Head -->
    <circle cx="100" cy="120" r="45" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Front wavy grey hair -->
    <path d="M 55 110 Q 75 85 100 90 Q 125 85 145 110 Q 130 85 100 85 Q 70 85 55 110 Z" fill="#cbd5e1"/>
    <!-- Glasses -->
    <circle cx="80" cy="118" r="14" fill="#e0f2fe" opacity="0.6" stroke="#d97706" stroke-width="3"/>
    <circle cx="120" cy="118" r="14" fill="#e0f2fe" opacity="0.6" stroke="#d97706" stroke-width="3"/>
    <line x1="94" y1="118" x2="106" y2="118" stroke="#d97706" stroke-width="3"/>
    <!-- Eyes behind glasses -->
    <circle cx="80" cy="118" r="4" fill="#1e293b"/>
    <circle cx="120" cy="118" r="4" fill="#1e293b"/>
    <!-- Cheeks & Smile -->
    <circle cx="70" cy="132" r="6" fill="#f43f5e" opacity="0.3"/>
    <circle cx="130" cy="132" r="6" fill="#f43f5e" opacity="0.3"/>
    <path d="M 90 138 Q 100 148 110 138" fill="none" stroke="#b45309" stroke-width="3" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "03" "OMA" "#faf5ff" "#7c3aed" $svg03

# 04: OPA
$svg04 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- White / Grey Hair side patches -->
    <circle cx="55" cy="120" r="18" fill="#e2e8f0" stroke="#94a3b8" stroke-width="3"/>
    <circle cx="145" cy="120" r="18" fill="#e2e8f0" stroke="#94a3b8" stroke-width="3"/>
    <!-- Body / Vest & Bowtie -->
    <path d="M 45 230 C 45 165 155 165 155 230 Z" fill="#10b981" stroke="#047857" stroke-width="4"/>
    <polygon points="100,185 80,165 120,165" fill="#ffffff"/>
    <polygon points="90,168 110,168 100,175" fill="#ef4444"/>
    <!-- Head (bald on top) -->
    <circle cx="100" cy="115" r="45" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Glasses -->
    <rect x="66" y="105" width="28" height="24" rx="4" fill="#e0f2fe" opacity="0.5" stroke="#475569" stroke-width="3"/>
    <rect x="106" y="105" width="28" height="24" rx="4" fill="#e0f2fe" opacity="0.5" stroke="#475569" stroke-width="3"/>
    <line x1="94" y1="117" x2="106" y2="117" stroke="#475569" stroke-width="3"/>
    <circle cx="80" cy="117" r="4" fill="#1e293b"/>
    <circle cx="120" cy="117" r="4" fill="#1e293b"/>
    <!-- Cheerful white mustache -->
    <path d="M 100 135 Q 85 130 75 142 Q 95 146 100 138 Q 105 146 125 142 Q 115 130 100 135 Z" fill="#ffffff" stroke="#cbd5e1" stroke-width="2"/>
    <path d="M 92 145 Q 100 152 108 145" fill="none" stroke="#b45309" stroke-width="2.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "04" "OPA" "#ecfdf5" "#059669" $svg04

# 05: BABY
$svg05 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Soft cushion / blanket behind -->
    <ellipse cx="100" cy="140" rx="90" ry="75" fill="#e0f2fe" stroke="#38bdf8" stroke-width="4"/>
    <!-- Baby Body / Onesie -->
    <ellipse cx="100" cy="165" rx="50" ry="40" fill="#fef08a" stroke="#ca8a04" stroke-width="3"/>
    <!-- Baby Head -->
    <circle cx="100" cy="105" r="45" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Cute hair curl on top -->
    <path d="M 100 60 Q 115 45 105 40 Q 95 50 100 60 Z" fill="#d97706"/>
    <!-- Big cute baby eyes -->
    <circle cx="82" cy="100" r="8" fill="#1e293b"/>
    <circle cx="85" cy="97" r="3" fill="#ffffff"/>
    <circle cx="118" cy="100" r="8" fill="#1e293b"/>
    <circle cx="121" cy="97" r="3" fill="#ffffff"/>
    <!-- Rosy Cheeks -->
    <circle cx="70" cy="115" r="9" fill="#f43f5e" opacity="0.35"/>
    <circle cx="130" cy="115" r="9" fill="#f43f5e" opacity="0.35"/>
    <!-- Pacifier (Schnuller) -->
    <ellipse cx="100" cy="125" rx="16" ry="12" fill="#38bdf8" stroke="#0284c7" stroke-width="3"/>
    <circle cx="100" cy="125" r="5" fill="#facc15"/>
    <circle cx="100" cy="138" r="8" fill="none" stroke="#0284c7" stroke-width="3"/>
  </g>
</svg>
'@
Render-Card "05" "BABY" "#fefce8" "#ca8a04" $svg05

# 06: BRUDER
$svg06 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 20)">
    <!-- Red Baseball Cap turned backwards -->
    <path d="M 55 100 Q 100 50 145 100 Z" fill="#ef4444" stroke="#b91c1c" stroke-width="4"/>
    <rect x="135" y="90" width="25" height="10" rx="4" fill="#b91c1c" transform="rotate(15 135 90)"/>
    <!-- Body / Striped T-Shirt -->
    <path d="M 50 220 C 50 160 150 160 150 220 Z" fill="#3b82f6" stroke="#1d4ed8" stroke-width="4"/>
    <line x1="50" y1="180" x2="150" y2="180" stroke="#ffffff" stroke-width="6"/>
    <line x1="50" y1="200" x2="150" y2="200" stroke="#ffffff" stroke-width="6"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="42" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <circle cx="82" cy="112" r="5" fill="#1e293b"/>
    <circle cx="84" cy="110" r="2" fill="#ffffff"/>
    <circle cx="118" cy="112" r="5" fill="#1e293b"/>
    <circle cx="120" cy="110" r="2" fill="#ffffff"/>
    <!-- Freckles & Smile -->
    <circle cx="75" cy="122" r="1.5" fill="#d97706"/>
    <circle cx="78" cy="124" r="1.5" fill="#d97706"/>
    <circle cx="122" cy="122" r="1.5" fill="#d97706"/>
    <circle cx="125" cy="124" r="1.5" fill="#d97706"/>
    <path d="M 88 128 Q 100 142 112 128" fill="none" stroke="#b45309" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "06" "BRUDER" "#eff6ff" "#1d4ed8" $svg06

# 07: SCHWESTER
$svg07 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Two Pigtails with Bows -->
    <g transform="translate(35, 95)">
      <ellipse cx="0" cy="30" rx="15" ry="30" fill="#f59e0b" stroke="#b45309" stroke-width="3"/>
      <circle cx="0" cy="5" r="7" fill="#ec4899"/>
    </g>
    <g transform="translate(165, 95)">
      <ellipse cx="0" cy="30" rx="15" ry="30" fill="#f59e0b" stroke="#b45309" stroke-width="3"/>
      <circle cx="0" cy="5" r="7" fill="#ec4899"/>
    </g>
    <!-- Body / Yellow Dress with Polka Dots -->
    <path d="M 55 225 C 55 165 145 165 145 225 Z" fill="#facc15" stroke="#ca8a04" stroke-width="4"/>
    <circle cx="85" cy="190" r="4" fill="#ef4444"/>
    <circle cx="115" cy="190" r="4" fill="#ef4444"/>
    <circle cx="100" cy="208" r="4" fill="#ef4444"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="42" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Blonde Hair Top -->
    <path d="M 60 100 Q 100 65 140 100 Z" fill="#f59e0b"/>
    <!-- Big Sparkly Eyes -->
    <circle cx="82" cy="112" r="6" fill="#1e293b"/>
    <circle cx="84" cy="110" r="2.5" fill="#ffffff"/>
    <circle cx="118" cy="112" r="6" fill="#1e293b"/>
    <circle cx="120" cy="110" r="2.5" fill="#ffffff"/>
    <!-- Cheeks & Happy Smile -->
    <circle cx="72" cy="124" r="6" fill="#f43f5e" opacity="0.35"/>
    <circle cx="128" cy="124" r="6" fill="#f43f5e" opacity="0.35"/>
    <path d="M 88 128 Q 100 140 112 128" fill="none" stroke="#be185d" stroke-width="3" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "07" "SCHWESTER" "#fefce8" "#ca8a04" $svg07

# 08: GESCHWISTER (Brother and sister together)
$svg08 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(10, 20)">
    <!-- Brother (Left) -->
    <g transform="translate(50, 0)">
      <path d="M 25 210 C 25 155 95 155 95 210 Z" fill="#3b82f6" stroke="#1d4ed8" stroke-width="3"/>
      <circle cx="60" cy="110" r="34" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
      <path d="M 30 100 Q 60 70 90 100 Z" fill="#78350f"/>
      <circle cx="48" cy="110" r="4" fill="#1e293b"/>
      <circle cx="72" cy="110" r="4" fill="#1e293b"/>
      <path d="M 52 122 Q 60 130 68 122" fill="none" stroke="#b45309" stroke-width="2.5" stroke-linecap="round"/>
    </g>
    <!-- Sister (Right) -->
    <g transform="translate(130, 0)">
      <path d="M 25 210 C 25 155 95 155 95 210 Z" fill="#f43f5e" stroke="#be185d" stroke-width="3"/>
      <circle cx="60" cy="110" r="34" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
      <path d="M 30 100 Q 60 70 90 100 Z" fill="#f59e0b"/>
      <!-- Pigtails -->
      <circle cx="20" cy="110" r="10" fill="#f59e0b"/>
      <circle cx="100" cy="110" r="10" fill="#f59e0b"/>
      <circle cx="48" cy="110" r="4" fill="#1e293b"/>
      <circle cx="72" cy="110" r="4" fill="#1e293b"/>
      <path d="M 52 122 Q 60 130 68 122" fill="none" stroke="#be185d" stroke-width="2.5" stroke-linecap="round"/>
    </g>
    <!-- Arms holding hands in middle -->
    <path d="M 105 170 Q 120 180 135 170" stroke="#fde68a" stroke-width="8" stroke-linecap="round"/>
    <circle cx="120" cy="175" r="6" fill="#fde68a"/>
  </g>
</svg>
'@
Render-Card "08" "GESCHWISTER" "#fdf2f8" "#be185d" $svg08

# 09: FAMILIE (Family portrait: Mom, Dad, Child)
$svg09 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(10, 15)">
    <!-- Dad (Left) -->
    <g transform="translate(30, 10)">
      <path d="M 15 210 C 15 150 85 150 85 210 Z" fill="#0284c7" stroke="#0369a1" stroke-width="3"/>
      <circle cx="50" cy="90" r="30" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
      <path d="M 25 80 Q 50 55 75 80 Z" fill="#451a03"/>
      <circle cx="42" cy="90" r="4" fill="#1e293b"/>
      <circle cx="58" cy="90" r="4" fill="#1e293b"/>
      <path d="M 44 102 Q 50 108 56 102" fill="none" stroke="#b45309" stroke-width="2"/>
    </g>
    <!-- Mom (Right) -->
    <g transform="translate(150, 10)">
      <path d="M 15 210 C 15 150 85 150 85 210 Z" fill="#ec4899" stroke="#be185d" stroke-width="3"/>
      <circle cx="50" cy="90" r="30" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
      <path d="M 20 85 Q 50 55 80 85 Z" fill="#92400e"/>
      <circle cx="42" cy="90" r="4" fill="#1e293b"/>
      <circle cx="58" cy="90" r="4" fill="#1e293b"/>
      <path d="M 44 102 Q 50 108 56 102" fill="none" stroke="#be185d" stroke-width="2"/>
    </g>
    <!-- Child in front (Center) -->
    <g transform="translate(100, 70)">
      <path d="M 15 155 C 15 110 65 110 65 155 Z" fill="#facc15" stroke="#ca8a04" stroke-width="3"/>
      <circle cx="40" cy="75" r="25" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
      <path d="M 20 65 Q 40 45 60 65 Z" fill="#f59e0b"/>
      <circle cx="33" cy="74" r="3.5" fill="#1e293b"/>
      <circle cx="47" cy="74" r="3.5" fill="#1e293b"/>
      <path d="M 35 84 Q 40 90 45 84" fill="none" stroke="#b45309" stroke-width="2"/>
    </g>
  </g>
</svg>
'@
Render-Card "09" "FAMILIE" "#fef3c7" "#d97706" $svg09

# 10: TANTE
$svg10 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Curly Hair -->
    <circle cx="65" cy="95" r="22" fill="#b45309"/>
    <circle cx="135" cy="95" r="22" fill="#b45309"/>
    <circle cx="100" cy="75" r="24" fill="#b45309"/>
    <!-- Blouse (Emerald) -->
    <path d="M 50 230 C 50 170 150 170 150 230 Z" fill="#10b981" stroke="#047857" stroke-width="4"/>
    <!-- Pearl necklace -->
    <circle cx="85" cy="180" r="4" fill="#ffffff"/>
    <circle cx="95" cy="184" r="4" fill="#ffffff"/>
    <circle cx="105" cy="184" r="4" fill="#ffffff"/>
    <circle cx="115" cy="180" r="4" fill="#ffffff"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="44" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Earrings -->
    <circle cx="52" cy="128" r="5" fill="#facc15"/>
    <circle cx="148" cy="128" r="5" fill="#facc15"/>
    <!-- Eyes & Smile -->
    <circle cx="82" cy="112" r="5.5" fill="#1e293b"/>
    <circle cx="118" cy="112" r="5.5" fill="#1e293b"/>
    <path d="M 88 130 Q 100 144 112 130" fill="none" stroke="#047857" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "10" "TANTE" "#ecfdf5" "#059669" $svg10

# 11: ONKEL
$svg11 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Body / Checkered Shirt -->
    <path d="M 45 230 C 45 165 155 165 155 230 Z" fill="#ea580c" stroke="#c2410c" stroke-width="4"/>
    <!-- Camera hanging from neck -->
    <rect x="80" y="185" width="40" height="28" rx="4" fill="#334155" stroke="#1e293b" stroke-width="2"/>
    <circle cx="100" cy="199" r="8" fill="#94a3b8"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="45" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Cool Flat Cap (Schiebermütze) -->
    <path d="M 50 95 Q 100 65 150 95 L 160 100 L 50 100 Z" fill="#64748b" stroke="#334155" stroke-width="3"/>
    <!-- Friendly Beard / Stubble -->
    <path d="M 75 125 Q 100 155 125 125" fill="#d97706" opacity="0.4"/>
    <!-- Eyes & Smile -->
    <circle cx="82" cy="112" r="5.5" fill="#1e293b"/>
    <circle cx="118" cy="112" r="5.5" fill="#1e293b"/>
    <path d="M 88 130 Q 100 142 112 130" fill="none" stroke="#92400e" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "11" "ONKEL" "#fff7ed" "#ea580c" $svg11

# 12: COUSIN
$svg12 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Hoodie -->
    <path d="M 45 230 C 45 165 155 165 155 230 Z" fill="#6366f1" stroke="#4f46e5" stroke-width="4"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="44" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Spiky Cool Hair -->
    <polygon points="65,85 75,60 85,80 95,55 105,80 115,55 125,80 135,65 140,85" fill="#78350f"/>
    <!-- Eyes & Big Smile -->
    <circle cx="82" cy="112" r="5.5" fill="#1e293b"/>
    <circle cx="118" cy="112" r="5.5" fill="#1e293b"/>
    <path d="M 86 128 Q 100 145 114 128" fill="none" stroke="#4f46e5" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "12" "COUSIN" "#eef2ff" "#4f46e5" $svg12

# 13: COUSINE
$svg13 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Flowing Hair with Flower -->
    <ellipse cx="100" cy="120" rx="60" ry="65" fill="#d97706"/>
    <!-- Dress (Cyan) -->
    <path d="M 50 230 C 50 170 150 170 150 230 Z" fill="#06b6d4" stroke="#0891b2" stroke-width="4"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="44" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Flower in hair -->
    <circle cx="60" cy="85" r="10" fill="#f43f5e"/>
    <circle cx="60" cy="85" r="4" fill="#facc15"/>
    <!-- Eyes & Smile -->
    <circle cx="82" cy="112" r="5.5" fill="#1e293b"/>
    <circle cx="118" cy="112" r="5.5" fill="#1e293b"/>
    <path d="M 88 128 Q 100 142 112 128" fill="none" stroke="#0891b2" stroke-width="3.5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "13" "COUSINE" "#ecfeff" "#0891b2" $svg13

# 14: HUND
$svg14 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Droopy Ears -->
    <ellipse cx="55" cy="110" rx="16" ry="38" fill="#b45309" transform="rotate(-15 55 110)"/>
    <ellipse cx="145" cy="110" rx="16" ry="38" fill="#b45309" transform="rotate(15 145 110)"/>
    <!-- Body -->
    <ellipse cx="100" cy="180" rx="55" ry="48" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <!-- Head -->
    <circle cx="100" cy="110" r="44" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <!-- Muzzle / Snout -->
    <ellipse cx="100" cy="125" rx="24" ry="18" fill="#fef3c7" stroke="#b45309" stroke-width="3"/>
    <ellipse cx="100" cy="116" rx="9" ry="6" fill="#1e293b"/>
    <path d="M 100 122 L 100 130" stroke="#1e293b" stroke-width="2"/>
    <path d="M 94 128 Q 100 136 106 128" fill="none" stroke="#1e293b" stroke-width="2" stroke-linecap="round"/>
    <!-- Kind Eyes -->
    <circle cx="82" cy="100" r="6" fill="#1e293b"/>
    <circle cx="84" cy="98" r="2" fill="#ffffff"/>
    <circle cx="118" cy="100" r="6" fill="#1e293b"/>
    <circle cx="120" cy="98" r="2" fill="#ffffff"/>
    <!-- Red Collar with Gold Bell -->
    <path d="M 70 150 Q 100 160 130 150" fill="none" stroke="#ef4444" stroke-width="8" stroke-linecap="round"/>
    <circle cx="100" cy="160" r="6" fill="#facc15"/>
    <!-- Front Paws -->
    <ellipse cx="75" cy="225" rx="16" ry="10" fill="#f59e0b" stroke="#b45309" stroke-width="3"/>
    <ellipse cx="125" cy="225" rx="16" ry="10" fill="#f59e0b" stroke="#b45309" stroke-width="3"/>
  </g>
</svg>
'@
Render-Card "14" "HUND" "#fffbeb" "#b45309" $svg14

# 15: KATZE
$svg15 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(50, 15)">
    <!-- Pointy Cat Ears -->
    <polygon points="55,90 70,45 95,80" fill="#f97316" stroke="#c2410c" stroke-width="4"/>
    <polygon points="65,85 75,55 90,80" fill="#fbcfe8"/>
    <polygon points="145,90 130,45 105,80" fill="#f97316" stroke="#c2410c" stroke-width="4"/>
    <polygon points="135,85 125,55 110,80" fill="#fbcfe8"/>
    <!-- Body -->
    <ellipse cx="100" cy="180" rx="50" ry="46" fill="#f97316" stroke="#c2410c" stroke-width="4"/>
    <ellipse cx="100" cy="180" rx="30" ry="30" fill="#ffffff"/>
    <!-- Head -->
    <circle cx="100" cy="115" r="42" fill="#f97316" stroke="#c2410c" stroke-width="4"/>
    <!-- Green Eyes -->
    <ellipse cx="82" cy="108" rx="8" ry="10" fill="#22c55e" stroke="#15803d" stroke-width="2"/>
    <ellipse cx="82" cy="108" rx="3" ry="8" fill="#1e293b"/>
    <ellipse cx="118" cy="108" rx="8" ry="10" fill="#22c55e" stroke="#15803d" stroke-width="2"/>
    <ellipse cx="118" cy="108" rx="3" ry="8" fill="#1e293b"/>
    <!-- Pink Nose & Whiskers -->
    <polygon points="100,120 95,126 105,126" fill="#ec4899"/>
    <line x1="60" y1="124" x2="88" y2="126" stroke="#475569" stroke-width="2"/>
    <line x1="60" y1="132" x2="88" y2="130" stroke="#475569" stroke-width="2"/>
    <line x1="140" y1="124" x2="112" y2="126" stroke="#475569" stroke-width="2"/>
    <line x1="140" y1="132" x2="112" y2="130" stroke="#475569" stroke-width="2"/>
  </g>
</svg>
'@
Render-Card "15" "KATZE" "#fff7ed" "#ea580c" $svg15

# 16: ZUHAUSE
$svg16 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- House body -->
    <rect x="35" y="85" width="180" height="135" rx="6" fill="#fef08a" stroke="#ca8a04" stroke-width="4"/>
    <!-- Red Roof -->
    <polygon points="20,90 125,20 230,90" fill="#ef4444" stroke="#b91c1c" stroke-width="5"/>
    <!-- Chimney with cute smoke puff -->
    <rect x="170" y="35" width="22" height="35" fill="#b91c1c"/>
    <circle cx="185" cy="20" r="8" fill="#cbd5e1" opacity="0.7"/>
    <circle cx="195" cy="8" r="6" fill="#cbd5e1" opacity="0.5"/>
    <!-- Front Door -->
    <rect x="105" y="150" width="40" height="70" rx="4" fill="#a855f7" stroke="#7e22ce" stroke-width="3"/>
    <circle cx="115" cy="185" r="3" fill="#facc15"/>
    <!-- Windows -->
    <rect x="50" y="110" width="36" height="36" rx="4" fill="#bae6fd" stroke="#0284c7" stroke-width="3"/>
    <rect x="160" y="110" width="36" height="36" rx="4" fill="#bae6fd" stroke="#0284c7" stroke-width="3"/>
    <!-- Little Heart above door -->
    <path d="M 125 125 Q 120 115 115 120 Q 110 125 125 140 Q 140 125 135 120 Q 130 115 125 125 Z" fill="#ef4444"/>
  </g>
</svg>
'@
Render-Card "16" "ZUHAUSE" "#fefce8" "#ca8a04" $svg16

# 17: KINDERZIMMER
$svg17 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 20)">
    <!-- Room Wall & Floor -->
    <rect x="10" y="20" width="230" height="200" rx="10" fill="#e0f2fe" stroke="#38bdf8" stroke-width="3"/>
    <rect x="10" y="160" width="230" height="60" fill="#fef08a"/>
    <!-- Bunting Garland on Wall -->
    <path d="M 20 45 Q 125 75 230 45" fill="none" stroke="#64748b" stroke-width="2"/>
    <polygon points="50,53 65,55 57,75" fill="#ef4444"/>
    <polygon points="90,60 105,62 97,82" fill="#facc15"/>
    <polygon points="135,62 150,60 142,82" fill="#22c55e"/>
    <polygon points="175,55 190,53 182,75" fill="#a855f7"/>
    <!-- Bed with pillow -->
    <rect x="25" y="130" width="110" height="60" rx="6" fill="#38bdf8" stroke="#0284c7" stroke-width="3"/>
    <rect x="30" y="135" width="30" height="20" rx="4" fill="#ffffff"/>
    <rect x="25" y="180" width="10" height="25" rx="3" fill="#0284c7"/>
    <rect x="125" y="180" width="10" height="25" rx="3" fill="#0284c7"/>
    <!-- Toy Box right -->
    <rect x="160" y="145" width="65" height="50" rx="6" fill="#ec4899" stroke="#be185d" stroke-width="3"/>
    <circle cx="175" cy="140" r="10" fill="#facc15"/>
  </g>
</svg>
'@
Render-Card "17" "KINDERZIMMER" "#f0f9ff" "#0284c7" $svg17

# 18: WOHNZIMMER
$svg18 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 25)">
    <!-- Big Cozy Sofa -->
    <rect x="40" y="110" width="180" height="75" rx="14" fill="#3b82f6" stroke="#1d4ed8" stroke-width="4"/>
    <rect x="25" y="125" width="30" height="60" rx="8" fill="#2563eb"/>
    <rect x="205" y="125" width="30" height="60" rx="8" fill="#2563eb"/>
    <!-- Sofa Cushions (Yellow & Pink) -->
    <rect x="65" y="120" width="35" height="35" rx="6" fill="#facc15" stroke="#ca8a04" stroke-width="2"/>
    <rect x="160" y="120" width="35" height="35" rx="6" fill="#f43f5e" stroke="#be185d" stroke-width="2"/>
    <!-- Sofa legs -->
    <rect x="45" y="185" width="10" height="20" rx="3" fill="#78350f"/>
    <rect x="205" y="185" width="10" height="20" rx="3" fill="#78350f"/>
    <!-- Floor Lamp left -->
    <line x1="15" y1="205" x2="15" y2="60" stroke="#64748b" stroke-width="4"/>
    <polygon points="0,60 30,60 25,35 5,35" fill="#fde047" stroke="#ca8a04" stroke-width="2"/>
  </g>
</svg>
'@
Render-Card "18" "WOHNZIMMER" "#eff6ff" "#1d4ed8" $svg18

# 19: KÜCHE
$svg19 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Counter & Cupboards -->
    <rect x="20" y="80" width="200" height="140" rx="8" fill="#f8fafc" stroke="#64748b" stroke-width="4"/>
    <rect x="30" y="90" width="85" height="120" rx="4" fill="#e2e8f0"/>
    <rect x="125" y="90" width="85" height="120" rx="4" fill="#e2e8f0"/>
    <!-- Stove & Kettle -->
    <rect x="35" y="60" width="60" height="20" fill="#334155"/>
    <circle cx="50" cy="70" r="6" fill="#ef4444"/>
    <circle cx="75" cy="70" r="6" fill="#ef4444"/>
    <!-- Steaming Kettle -->
    <ellipse cx="60" cy="45" rx="16" ry="12" fill="#0284c7" stroke="#0369a1" stroke-width="2"/>
    <!-- Fruit bowl on counter -->
    <ellipse cx="165" cy="75" rx="22" ry="8" fill="#f59e0b"/>
    <circle cx="160" cy="68" r="8" fill="#ef4444"/>
    <circle cx="172" cy="68" r="8" fill="#22c55e"/>
  </g>
</svg>
'@
Render-Card "19" "KÜCHE" "#f8fafc" "#475569" $svg19

# 20: ESSTISCH
$svg20 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 20)">
    <!-- Chairs behind -->
    <rect x="55" y="65" width="20" height="50" rx="4" fill="#b45309"/>
    <rect x="165" y="65" width="20" height="50" rx="4" fill="#b45309"/>
    <!-- Table Top (Polished Wood) -->
    <polygon points="20,110 220,110 240,140 0,140" fill="#d97706" stroke="#92400e" stroke-width="4"/>
    <!-- Table Legs -->
    <rect x="25" y="140" width="14" height="85" rx="4" fill="#b45309"/>
    <rect x="200" y="140" width="14" height="85" rx="4" fill="#b45309"/>
    <!-- Bowl of apples in center -->
    <ellipse cx="120" cy="118" rx="30" ry="10" fill="#ffffff" stroke="#cbd5e1" stroke-width="2"/>
    <circle cx="112" cy="108" r="9" fill="#ef4444"/>
    <circle cx="128" cy="108" r="9" fill="#22c55e"/>
  </g>
</svg>
'@
Render-Card "20" "ESSTISCH" "#fffbeb" "#b45309" $svg20

# 21: FRÜHSTÜCK
$svg21 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 20)">
    <!-- Big Plate -->
    <circle cx="110" cy="130" r="75" fill="#ffffff" stroke="#cbd5e1" stroke-width="4"/>
    <circle cx="110" cy="130" r="60" fill="#f8fafc"/>
    <!-- Fried Egg -->
    <path d="M 90 100 Q 130 90 140 120 Q 145 150 115 155 Q 80 150 75 125 Z" fill="#ffffff" stroke="#e2e8f0" stroke-width="2"/>
    <circle cx="110" cy="125" r="18" fill="#facc15" stroke="#f59e0b" stroke-width="3"/>
    <!-- Toast slice -->
    <rect x="40" y="80" width="45" height="45" rx="8" fill="#fde68a" stroke="#d97706" stroke-width="3" transform="rotate(-15 40 80)"/>
    <!-- Glass of Orange Juice right -->
    <rect x="200" y="85" width="40" height="75" rx="6" fill="#fed7aa" stroke="#ea580c" stroke-width="3"/>
    <rect x="202" y="105" width="36" height="52" fill="#f97316"/>
  </g>
</svg>
'@
Render-Card "21" "FRÜHSTÜCK" "#fff7ed" "#ea580c" $svg21

# 22: ABENDESSEN
$svg22 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Steaming Hot Soup Bowl -->
    <ellipse cx="120" cy="115" rx="80" ry="25" fill="#f43f5e" stroke="#be185d" stroke-width="4"/>
    <path d="M 40 115 C 40 190 200 190 200 115 Z" fill="#f43f5e" stroke="#be185d" stroke-width="4"/>
    <ellipse cx="120" cy="115" rx="72" ry="20" fill="#f59e0b"/>
    <!-- Spoon sticking out -->
    <g transform="translate(170, 75) rotate(35)">
      <ellipse cx="0" cy="0" rx="14" ry="20" fill="#cbd5e1" stroke="#64748b" stroke-width="2"/>
      <rect x="-4" y="20" width="8" height="60" rx="4" fill="#cbd5e1" stroke="#64748b" stroke-width="2"/>
    </g>
    <!-- Steam swirls -->
    <path d="M 95 85 Q 90 60 100 45" fill="none" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <path d="M 120 80 Q 115 55 125 40" fill="none" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <path d="M 145 85 Q 140 60 150 45" fill="none" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "22" "ABENDESSEN" "#fff1f2" "#be185d" $svg22

# 23: GEBURTSTAG
$svg23 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 15)">
    <!-- Colorful Party Balloons -->
    <!-- Red Balloon -->
    <ellipse cx="85" cy="70" rx="35" ry="45" fill="#ef4444" stroke="#b91c1c" stroke-width="3"/>
    <polygon points="85,115 80,122 90,122" fill="#ef4444"/>
    <path d="M 85 122 Q 100 160 120 210" fill="none" stroke="#64748b" stroke-width="2"/>
    <!-- Yellow Balloon -->
    <ellipse cx="140" cy="55" rx="35" ry="45" fill="#facc15" stroke="#ca8a04" stroke-width="3"/>
    <polygon points="140,100 135,107 145,107" fill="#facc15"/>
    <path d="M 140 107 Q 130 155 120 210" fill="none" stroke="#64748b" stroke-width="2"/>
    <!-- Blue Balloon -->
    <ellipse cx="185" cy="80" rx="35" ry="45" fill="#3b82f6" stroke="#1d4ed8" stroke-width="3"/>
    <polygon points="185,125 180,132 190,132" fill="#3b82f6"/>
    <path d="M 185 132 Q 150 170 120 210" fill="none" stroke="#64748b" stroke-width="2"/>
    <!-- Confetti pieces -->
    <rect x="40" y="40" width="8" height="8" rx="2" fill="#ec4899" transform="rotate(25 40 40)"/>
    <rect x="220" y="50" width="8" height="8" rx="2" fill="#10b981" transform="rotate(45 220 50)"/>
    <circle cx="60" cy="140" r="4" fill="#a855f7"/>
    <circle cx="210" cy="150" r="4" fill="#f97316"/>
  </g>
</svg>
'@
Render-Card "23" "GEBURTSTAG" "#fefce8" "#ca8a04" $svg23

# 24: GEBURTSTAGSKUCHEN
$svg24 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Bottom tier -->
    <rect x="35" y="140" width="170" height="70" rx="10" fill="#fbcfe8" stroke="#db2777" stroke-width="4"/>
    <line x1="35" y1="175" x2="205" y2="175" stroke="#f43f5e" stroke-width="6"/>
    <!-- Top tier -->
    <rect x="65" y="90" width="110" height="55" rx="8" fill="#fed7aa" stroke="#ea580c" stroke-width="4"/>
    <path d="M 65 105 Q 80 115 95 105 Q 110 115 125 105 Q 140 115 155 105 Q 170 115 175 105" fill="none" stroke="#ffffff" stroke-width="6"/>
    <!-- 3 Burning Candles -->
    <!-- Candle 1 -->
    <rect x="85" y="55" width="8" height="35" fill="#38bdf8"/>
    <ellipse cx="89" cy="45" rx="5" ry="8" fill="#facc15"/>
    <ellipse cx="89" cy="47" rx="2" ry="4" fill="#ef4444"/>
    <!-- Candle 2 -->
    <rect x="116" y="50" width="8" height="40" fill="#facc15"/>
    <ellipse cx="120" cy="40" rx="5" ry="8" fill="#facc15"/>
    <ellipse cx="120" cy="42" rx="2" ry="4" fill="#ef4444"/>
    <!-- Candle 3 -->
    <rect x="147" y="55" width="8" height="35" fill="#4ade80"/>
    <ellipse cx="151" cy="45" rx="5" ry="8" fill="#facc15"/>
    <ellipse cx="151" cy="47" rx="2" ry="4" fill="#ef4444"/>
  </g>
</svg>
'@
Render-Card "24" "GEBURTSTAGSKUCHEN" "#fdf2f8" "#db2777" $svg24

# 25: SPIELPLATZ
$svg25 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(20, 20)">
    <!-- Tower platform -->
    <rect x="40" y="70" width="80" height="80" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <polygon points="30,70 80,20 130,70" fill="#ef4444" stroke="#b91c1c" stroke-width="4"/>
    <!-- Tower stilts -->
    <line x1="50" y1="150" x2="50" y2="220" stroke="#78350f" stroke-width="6"/>
    <line x1="110" y1="150" x2="110" y2="220" stroke="#78350f" stroke-width="6"/>
    <!-- Ladder on left -->
    <line x1="20" y1="80" x2="20" y2="220" stroke="#0284c7" stroke-width="4"/>
    <line x1="40" y1="80" x2="40" y2="220" stroke="#0284c7" stroke-width="4"/>
    <line x1="20" y1="110" x2="40" y2="110" stroke="#0284c7" stroke-width="3"/>
    <line x1="20" y1="140" x2="40" y2="140" stroke="#0284c7" stroke-width="3"/>
    <line x1="20" y1="170" x2="40" y2="170" stroke="#0284c7" stroke-width="3"/>
    <!-- Curving Slide on right -->
    <path d="M 120 120 Q 180 120 220 220" fill="none" stroke="#22c55e" stroke-width="16" stroke-linecap="round"/>
    <path d="M 120 120 Q 180 120 220 220" fill="none" stroke="#86efac" stroke-width="6" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "25" "SPIELPLATZ" "#f0fdf4" "#16a34a" $svg25

# 26: PICKNICK
$svg26 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 20)">
    <!-- Red checked blanket -->
    <polygon points="10,180 125,120 240,180 125,235" fill="#ffffff" stroke="#ef4444" stroke-width="3"/>
    <!-- Checkered pattern -->
    <polygon points="40,165 95,135 125,150 70,180" fill="#fca5a5" opacity="0.6"/>
    <polygon points="155,135 210,165 180,180 125,150" fill="#fca5a5" opacity="0.6"/>
    <!-- Woven Picnic Basket in center -->
    <rect x="85" y="100" width="80" height="60" rx="8" fill="#d97706" stroke="#92400e" stroke-width="4"/>
    <line x1="85" y1="125" x2="165" y2="125" stroke="#92400e" stroke-width="3"/>
    <!-- Handle -->
    <path d="M 85 110 Q 125 50 165 110" fill="none" stroke="#92400e" stroke-width="5"/>
    <!-- Red Apple & Sandwiches -->
    <circle cx="65" cy="180" r="14" fill="#ef4444" stroke="#b91c1c" stroke-width="2"/>
    <polygon points="180,165 210,165 195,190" fill="#fde68a" stroke="#d97706" stroke-width="2"/>
  </g>
</svg>
'@
Render-Card "26" "PICKNICK" "#fef2f2" "#dc2626" $svg26

# 27: SPAZIERGANG
$svg27 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(20, 15)">
    <!-- Sun in sky -->
    <circle cx="210" cy="50" r="24" fill="#facc15" stroke="#eab308" stroke-width="3"/>
    <!-- Green hills -->
    <path d="M 0 160 Q 90 120 180 170 Q 230 140 260 170 L 260 230 L 0 230 Z" fill="#bbf7d0"/>
    <!-- Park path -->
    <path d="M 100 230 Q 120 170 140 140" stroke="#fde68a" stroke-width="24" stroke-linecap="round"/>
    <!-- Two happy trees -->
    <!-- Tree 1 -->
    <rect x="45" y="110" width="12" height="60" rx="2" fill="#78350f"/>
    <circle cx="51" cy="95" r="32" fill="#22c55e" stroke="#15803d" stroke-width="3"/>
    <!-- Tree 2 -->
    <rect x="195" y="125" width="10" height="50" rx="2" fill="#78350f"/>
    <circle cx="200" cy="115" r="26" fill="#16a34a" stroke="#15803d" stroke-width="3"/>
    <!-- Butterflies -->
    <circle cx="120" cy="80" r="4" fill="#ec4899"/>
    <circle cx="128" cy="80" r="4" fill="#ec4899"/>
  </g>
</svg>
'@
Render-Card "27" "SPAZIERGANG" "#f0fdf4" "#16a34a" $svg27

# 28: GUTE-NACHT-GESCHICHTE
$svg28 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 20)">
    <!-- Crescent Moon & Stars in background -->
    <path d="M 120 20 A 25 25 0 0 0 145 60 A 30 30 0 1 1 120 20 Z" fill="#facc15"/>
    <polygon points="80,30 83,38 91,38 85,43 87,51 80,46 73,51 75,43 69,38 77,38" fill="#fde047"/>
    <polygon points="175,40 177,46 183,46 178,50 180,56 175,52 170,56 172,50 167,46 173,46" fill="#fde047"/>
    <!-- Open Book -->
    <!-- Left page -->
    <path d="M 125 180 Q 80 170 30 185 L 30 100 Q 80 85 125 100 Z" fill="#ffffff" stroke="#cbd5e1" stroke-width="3"/>
    <!-- Right page -->
    <path d="M 125 180 Q 170 170 220 185 L 220 100 Q 170 85 125 100 Z" fill="#ffffff" stroke="#cbd5e1" stroke-width="3"/>
    <!-- Cover edge -->
    <path d="M 28 186 Q 78 171 125 183 Q 172 171 222 186" fill="none" stroke="#3b82f6" stroke-width="6"/>
    <!-- Text lines -->
    <line x1="45" y1="120" x2="110" y2="115" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <line x1="45" y1="135" x2="110" y2="130" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <line x1="45" y1="150" x2="90" y2="145" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <line x1="140" y1="115" x2="205" y2="120" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <line x1="140" y1="130" x2="205" y2="135" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
    <line x1="140" y1="145" x2="185" y2="150" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "28" "GUTE-NACHT-GESCHICHTE" "#faf5ff" "#7c3aed" $svg28

# 29: KUSCHELN
$svg29 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Big glowing Red Heart in center -->
    <path d="M 120 70 Q 90 20 50 45 Q 10 75 120 190 Q 230 75 190 45 Q 150 20 120 70 Z" fill="#f43f5e" stroke="#e11d48" stroke-width="5"/>
    <!-- Two cute smiley faces inside heart hugging -->
    <circle cx="85" cy="85" r="5" fill="#ffffff"/>
    <circle cx="105" cy="85" r="5" fill="#ffffff"/>
    <path d="M 90 98 Q 95 106 100 98" fill="none" stroke="#ffffff" stroke-width="3" stroke-linecap="round"/>
    <circle cx="135" cy="85" r="5" fill="#ffffff"/>
    <circle cx="155" cy="85" r="5" fill="#ffffff"/>
    <path d="M 140 98 Q 145 106 150 98" fill="none" stroke="#ffffff" stroke-width="3" stroke-linecap="round"/>
    <!-- Sparkles -->
    <polygon points="40,30 43,36 50,36 44,40 46,47 40,43 34,47 36,40 30,36 37,36" fill="#facc15"/>
    <polygon points="200,30 203,36 210,36 204,40 206,47 200,43 194,47 196,40 190,36 197,36" fill="#facc15"/>
  </g>
</svg>
'@
Render-Card "29" "KUSCHELN" "#fff1f2" "#e11d48" $svg29

# 30: KINDERWAGEN
$svg30 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Big wheels with spokes -->
    <circle cx="65" cy="180" r="28" fill="#ffffff" stroke="#334155" stroke-width="4"/>
    <circle cx="65" cy="180" r="6" fill="#0284c7"/>
    <circle cx="175" cy="180" r="28" fill="#ffffff" stroke="#334155" stroke-width="4"/>
    <circle cx="175" cy="180" r="6" fill="#0284c7"/>
    <!-- Chassis frame -->
    <line x1="65" y1="180" x2="120" y2="135" stroke="#64748b" stroke-width="5"/>
    <line x1="175" y1="180" x2="120" y2="135" stroke="#64748b" stroke-width="5"/>
    <!-- Handle bar extending to right -->
    <line x1="100" y1="130" x2="215" y2="70" stroke="#334155" stroke-width="6" stroke-linecap="round"/>
    <!-- Bassinet / Carriage body (Cyan) -->
    <path d="M 40 145 Q 40 100 80 100 L 160 100 Q 180 100 180 145 Z" fill="#38bdf8" stroke="#0284c7" stroke-width="4"/>
    <!-- Folding canopy / hood left -->
    <path d="M 40 140 Q 40 70 100 70 L 100 140 Z" fill="#0284c7"/>
  </g>
</svg>
'@
Render-Card "30" "KINDERWAGEN" "#f0f9ff" "#0284c7" $svg30

# 31: BABYBETT (Crib / Wiege)
$svg31 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Wooden Crib with bars -->
    <rect x="25" y="75" width="190" height="110" rx="8" fill="#fef3c7" stroke="#b45309" stroke-width="4"/>
    <!-- Vertical bars -->
    <line x1="55" y1="75" x2="55" y2="185" stroke="#b45309" stroke-width="4"/>
    <line x1="85" y1="75" x2="85" y2="185" stroke="#b45309" stroke-width="4"/>
    <line x1="115" y1="75" x2="115" y2="185" stroke="#b45309" stroke-width="4"/>
    <line x1="145" y1="75" x2="145" y2="185" stroke="#b45309" stroke-width="4"/>
    <line x1="175" y1="75" x2="175" y2="185" stroke="#b45309" stroke-width="4"/>
    <!-- Mattress & pillow inside -->
    <rect x="35" y="150" width="170" height="30" rx="4" fill="#38bdf8"/>
    <rect x="40" y="140" width="40" height="20" rx="6" fill="#ffffff"/>
    <!-- Crib posts / legs -->
    <rect x="20" y="60" width="14" height="150" rx="4" fill="#92400e"/>
    <rect x="206" y="60" width="14" height="150" rx="4" fill="#92400e"/>
  </g>
</svg>
'@
Render-Card "31" "BABYBETT" "#fffbeb" "#b45309" $svg31

# 32: SCHNULLER
$svg32 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(60, 20)">
    <!-- Teat (Silicone/Latex Nipple) -->
    <ellipse cx="90" cy="70" rx="36" ry="45" fill="#fed7aa" stroke="#f97316" stroke-width="4"/>
    <!-- Shield / Base (Pink) -->
    <ellipse cx="90" cy="120" rx="75" ry="30" fill="#f43f5e" stroke="#be185d" stroke-width="5"/>
    <circle cx="45" cy="120" r="8" fill="#ffffff"/>
    <circle cx="135" cy="120" r="8" fill="#ffffff"/>
    <!-- Center Button (Yellow) -->
    <circle cx="90" cy="120" r="20" fill="#facc15" stroke="#ca8a04" stroke-width="3"/>
    <!-- Handle Ring -->
    <ellipse cx="90" cy="170" rx="40" ry="30" fill="none" stroke="#f43f5e" stroke-width="12"/>
    <ellipse cx="90" cy="170" rx="40" ry="30" fill="none" stroke="#be185d" stroke-width="4"/>
  </g>
</svg>
'@
Render-Card "32" "SCHNULLER" "#fff1f2" "#e11d48" $svg32

# 33: SCHAUKEL
$svg33 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(40, 15)">
    <!-- Tree branch at top -->
    <path d="M 0 30 Q 110 40 220 25" stroke="#78350f" stroke-width="16" stroke-linecap="round"/>
    <path d="M 160 30 Q 190 10 210 20" stroke="#15803d" stroke-width="8" stroke-linecap="round"/>
    <!-- Two Ropes -->
    <line x1="60" y1="35" x2="60" y2="185" stroke="#ca8a04" stroke-width="5"/>
    <line x1="160" y1="35" x2="160" y2="185" stroke="#ca8a04" stroke-width="5"/>
    <!-- Wooden Swing Seat -->
    <rect x="40" y="180" width="140" height="18" rx="6" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <!-- Knots below seat -->
    <circle cx="60" cy="195" r="5" fill="#ca8a04"/>
    <circle cx="160" cy="195" r="5" fill="#ca8a04"/>
  </g>
</svg>
'@
Render-Card "33" "SCHAUKEL" "#f0fdf4" "#16a34a" $svg33

# 34: SANDKASTEN
$svg34 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 20)">
    <!-- Wooden Sandbox Frame (Perspective) -->
    <polygon points="30,80 210,80 240,180 0,180" fill="#fde68a" stroke="#d97706" stroke-width="4"/>
    <!-- Wooden Beams -->
    <line x1="0" y1="180" x2="240" y2="180" stroke="#b45309" stroke-width="12" stroke-linecap="round"/>
    <line x1="30" y1="80" x2="210" y2="80" stroke="#b45309" stroke-width="10" stroke-linecap="round"/>
    <!-- Sandcastle inside -->
    <rect x="95" y="100" width="50" height="45" fill="#f59e0b"/>
    <polygon points="90,100 120,70 150,100" fill="#f59e0b"/>
    <rect x="95" y="90" width="10" height="10" fill="#d97706"/>
    <rect x="115" y="90" width="10" height="10" fill="#d97706"/>
    <rect x="135" y="90" width="10" height="10" fill="#d97706"/>
    <!-- Red Bucket & Blue Shovel -->
    <polygon points="50,135 70,135 65,165 55,165" fill="#ef4444"/>
    <line x1="170" y1="120" x2="190" y2="160" stroke="#0284c7" stroke-width="5" stroke-linecap="round"/>
  </g>
</svg>
'@
Render-Card "34" "SANDKASTEN" "#fefce8" "#d97706" $svg34

# 35: GARTEN
$svg35 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(20, 20)">
    <!-- Green Grass Mound -->
    <path d="M 0 180 Q 130 140 260 180 L 260 220 L 0 220 Z" fill="#22c55e" stroke="#15803d" stroke-width="3"/>
    <!-- Flower 1 (Red Tulip) -->
    <line x1="50" y1="120" x2="50" y2="180" stroke="#15803d" stroke-width="5"/>
    <path d="M 35 120 C 35 90 65 90 65 120 Z" fill="#ef4444" stroke="#b91c1c" stroke-width="2"/>
    <!-- Flower 2 (Sunflower in center) -->
    <line x1="120" y1="100" x2="120" y2="180" stroke="#15803d" stroke-width="6"/>
    <circle cx="120" cy="90" r="30" fill="#facc15" stroke="#ca8a04" stroke-width="2"/>
    <circle cx="120" cy="90" r="16" fill="#78350f"/>
    <!-- Flower 3 (Purple Daisy) -->
    <line x1="190" y1="120" x2="190" y2="180" stroke="#15803d" stroke-width="5"/>
    <circle cx="190" cy="115" r="20" fill="#a855f7" stroke="#7e22ce" stroke-width="2"/>
    <circle cx="190" cy="115" r="8" fill="#fde047"/>
    <!-- Little green watering can -->
    <g transform="translate(205, 145)">
      <rect x="0" y="10" width="30" height="25" rx="4" fill="#0284c7" stroke="#0369a1" stroke-width="2"/>
      <line x1="28" y1="20" x2="45" y2="10" stroke="#0284c7" stroke-width="3"/>
    </g>
  </g>
</svg>
'@
Render-Card "35" "GARTEN" "#f0fdf4" "#16a34a" $svg35

Write-Host "All 35 Familie Cards Rendered Successfully!" -ForegroundColor Cyan
