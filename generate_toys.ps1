# Generator Script for Toys 29 to 50
$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$outDir = Join-Path $PSScriptRoot "bilder\Spielzeuge"
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
    $htmlFile = Join-Path $env:TEMP "card_$num.html"
    [System.IO.File]::WriteAllText($htmlFile, $html, [System.Text.Encoding]::UTF8)
    $pngFile = Join-Path $outDir "spielzeug_$num.png"
    $uri = "file:///" + $htmlFile.Replace('\', '/')
    Start-Process -FilePath $edge -ArgumentList "--headless=new","--screenshot=$pngFile","--window-size=1200,900","--hide-scrollbars",$uri -Wait
    Write-Host "Rendered: spielzeug_$num.png ($label)" -ForegroundColor Green
}

# 29: SEIFENBLASEN
$svg29 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <defs>
    <radialGradient id="bubShine" cx="35%" cy="35%" r="65%">
      <stop offset="0%" stop-color="#ffffff" stop-opacity="0.8"/>
      <stop offset="40%" stop-color="#38bdf8" stop-opacity="0.4"/>
      <stop offset="70%" stop-color="#ec4899" stop-opacity="0.3"/>
      <stop offset="100%" stop-color="#a855f7" stop-opacity="0.5"/>
    </radialGradient>
  </defs>
  <g transform="translate(40, 80)">
    <rect x="0" y="30" width="60" height="120" rx="10" fill="#facc15" stroke="#ca8a04" stroke-width="4"/>
    <rect x="10" y="10" width="40" height="20" rx="4" fill="#3b82f6" stroke="#1d4ed8" stroke-width="3"/>
    <ellipse cx="30" cy="10" rx="15" ry="6" fill="#60a5fa"/>
    <rect x="75" y="-30" width="8" height="140" rx="4" fill="#ec4899" transform="rotate(25 75 40)"/>
    <circle cx="120" cy="-10" r="18" fill="none" stroke="#ec4899" stroke-width="5"/>
  </g>
  <circle cx="160" cy="70" r="38" fill="url(#bubShine)" stroke="#bae6fd" stroke-width="2"/>
  <ellipse cx="150" cy="55" rx="8" ry="4" fill="#ffffff" transform="rotate(-30 150 55)"/>
  <circle cx="230" cy="110" r="28" fill="url(#bubShine)" stroke="#bae6fd" stroke-width="2"/>
  <ellipse cx="222" cy="100" rx="6" ry="3" fill="#ffffff" transform="rotate(-30 222 100)"/>
  <circle cx="180" cy="170" r="22" fill="url(#bubShine)" stroke="#bae6fd" stroke-width="2"/>
  <circle cx="240" cy="50" r="16" fill="url(#bubShine)" stroke="#bae6fd" stroke-width="2"/>
</svg>
'@
Render-Card "29" "SEIFENBLASEN" "#e0f2fe" "#0284c7" $svg29

# 30: SPIELKÜCHE
$svg30 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <rect x="20" y="70" width="200" height="150" rx="8" fill="#fda4af" stroke="#e11d48" stroke-width="4"/>
    <rect x="20" y="20" width="200" height="50" fill="#fecdd3" stroke="#e11d48" stroke-width="3"/>
    <rect x="30" y="35" width="180" height="8" rx="2" fill="#e11d48"/>
    <rect x="35" y="110" width="80" height="95" rx="6" fill="#ffe4e6" stroke="#e11d48" stroke-width="3"/>
    <rect x="45" y="125" width="60" height="55" rx="4" fill="#475569"/>
    <line x1="50" y1="117" x2="100" y2="117" stroke="#e11d48" stroke-width="4"/>
    <rect x="125" y="110" width="80" height="95" rx="6" fill="#ffe4e6" stroke="#e11d48" stroke-width="3"/>
    <circle cx="140" cy="155" r="5" fill="#e11d48"/>
    <circle cx="60" cy="90" r="8" fill="#e11d48"/>
    <circle cx="85" cy="90" r="8" fill="#e11d48"/>
    <circle cx="155" cy="90" r="8" fill="#e11d48"/>
    <circle cx="180" cy="90" r="8" fill="#e11d48"/>
    <rect x="135" y="55" width="40" height="25" rx="4" fill="#38bdf8" stroke="#0284c7" stroke-width="2"/>
    <line x1="130" y1="62" x2="135" y2="62" stroke="#0284c7" stroke-width="4"/>
    <line x1="175" y1="62" x2="180" y2="62" stroke="#0284c7" stroke-width="4"/>
  </g>
</svg>
'@
Render-Card "30" "SPIELKÜCHE" "#fff1f2" "#e11d48" $svg30

# 31: ZAUBERWÜRFEL
$svg31 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(150, 130)">
    <polygon points="0,-90 75,-50 0,-10 -75,-50" fill="#1e293b"/>
    <polygon points="0,-82 22,-70 0,-58 -22,-70" fill="#facc15"/>
    <polygon points="25,-68 47,-56 25,-44 3,-56" fill="#facc15"/>
    <polygon points="50,-54 72,-42 50,-30 28,-42" fill="#facc15"/>
    <polygon points="-25,-68 -3,-56 -25,-44 -47,-56" fill="#ffffff"/>
    <polygon points="0,-54 22,-42 0,-30 -22,-42" fill="#ffffff"/>
    <polygon points="25,-40 47,-28 25,-16 3,-28" fill="#ffffff"/>
    <polygon points="-50,-54 -28,-42 -50,-30 -72,-42" fill="#facc15"/>
    <polygon points="-25,-40 -3,-28 -25,-16 -47,-28" fill="#facc15"/>
    <polygon points="0,-26 22,-14 0,-2 -22,-14" fill="#facc15"/>
    <polygon points="-75,-50 0,-10 0,75 -75,35" fill="#1e293b"/>
    <polygon points="-72,-42 -50,-30 -50, -4 -72,-16" fill="#ef4444"/>
    <polygon points="-47,-28 -25,-16 -25, 10 -47, -2" fill="#ef4444"/>
    <polygon points="-22,-14   0, -2   0, 24 -22, 12" fill="#22c55e"/>
    <polygon points="-72,-12 -50,  0 -50, 26 -72, 14" fill="#ef4444"/>
    <polygon points="-47,  2 -25, 14 -25, 40 -47, 28" fill="#ef4444"/>
    <polygon points="-22, 16   0, 28   0, 54 -22, 42" fill="#ef4444"/>
    <polygon points="-72, 18 -50, 30 -50, 56 -72, 44" fill="#22c55e"/>
    <polygon points="-47, 32 -25, 44 -25, 70 -47, 58" fill="#22c55e"/>
    <polygon points="-22, 46   0, 58   0, 84 -22, 72" fill="#22c55e"/>
    <polygon points="0,-10 75,-50 75,35 0,75" fill="#1e293b"/>
    <polygon points="3,-28 25,-40 25,-14 3,-2" fill="#3b82f6"/>
    <polygon points="28,-42 50,-54 50,-28 28,-16" fill="#3b82f6"/>
    <polygon points="53,-56 72,-68 72,-42 53,-30" fill="#f97316"/>
    <polygon points="3, 2 25,-10 25, 16 3, 28" fill="#3b82f6"/>
    <polygon points="28,-12 50,-24 50,  2 28, 14" fill="#f97316"/>
    <polygon points="53,-26 72,-38 72,-12 53,  0" fill="#f97316"/>
    <polygon points="3, 32 25, 20 25, 46 3, 58" fill="#3b82f6"/>
    <polygon points="28, 18 50,  6 50, 32 28, 44" fill="#f97316"/>
    <polygon points="53,  4 72, -8 72, 18 53, 30" fill="#f97316"/>
  </g>
</svg>
'@
Render-Card "31" "ZAUBERWÜRFEL" "#fef3c7" "#d97706" $svg31

# 32: RUBIK'S CUBE
Render-Card "32" "RUBIK'S CUBE" "#e0e7ff" "#4338ca" $svg31

# 33: MUSIKINSTRUMENTE
$svg33 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(10, 20)">
    <polygon points="40,65 240,95 235,175 45,205" fill="#d97706" opacity="0.3"/>
    <line x1="30" y1="75" x2="250" y2="105" stroke="#92400e" stroke-width="8" stroke-linecap="round"/>
    <line x1="35" y1="195" x2="245" y2="165" stroke="#92400e" stroke-width="8" stroke-linecap="round"/>
    <rect x="40" y="55" width="22" height="155" rx="6" fill="#ef4444" stroke="#b91c1c" stroke-width="2"/>
    <rect x="68" y="60" width="22" height="145" rx="6" fill="#f97316" stroke="#c2410c" stroke-width="2"/>
    <rect x="96" y="65" width="22" height="135" rx="6" fill="#facc15" stroke="#ca8a04" stroke-width="2"/>
    <rect x="124" y="70" width="22" height="125" rx="6" fill="#22c55e" stroke="#15803d" stroke-width="2"/>
    <rect x="152" y="75" width="22" height="115" rx="6" fill="#06b6d4" stroke="#0891b2" stroke-width="2"/>
    <rect x="180" y="80" width="22" height="105" rx="6" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <rect x="208" y="85" width="22" height="95" rx="6" fill="#a855f7" stroke="#7e22ce" stroke-width="2"/>
    <g transform="translate(50, 40) rotate(-35)">
      <line x1="0" y1="0" x2="160" y2="0" stroke="#78350f" stroke-width="6" stroke-linecap="round"/>
      <circle cx="160" cy="0" r="14" fill="#fbbf24" stroke="#d97706" stroke-width="3"/>
    </g>
  </g>
</svg>
'@
Render-Card "33" "MUSIKINSTRUMENTE" "#faf5ff" "#7c3aed" $svg33

# 34: DREIRAD
$svg34 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(20, 20)">
    <circle cx="90" cy="150" r="45" fill="#facc15" stroke="#ca8a04" stroke-width="4"/>
    <circle cx="90" cy="150" r="14" fill="#ef4444"/>
    <line x1="90" y1="150" x2="105" y2="60" stroke="#3b82f6" stroke-width="8" stroke-linecap="round"/>
    <line x1="90" y1="60" x2="120" y2="60" stroke="#1e293b" stroke-width="8" stroke-linecap="round"/>
    <circle cx="85" cy="55" r="8" fill="#ef4444"/>
    <path d="M 100 100 L 200 145" stroke="#ef4444" stroke-width="12" stroke-linecap="round"/>
    <ellipse cx="170" cy="115" rx="25" ry="12" fill="#1e293b"/>
    <circle cx="215" cy="170" r="28" fill="#facc15" stroke="#ca8a04" stroke-width="4"/>
    <circle cx="215" cy="170" r="10" fill="#ef4444"/>
    <line x1="90" y1="150" x2="70" y2="180" stroke="#64748b" stroke-width="5"/>
    <rect x="60" y="175" width="20" height="10" rx="3" fill="#1e293b"/>
  </g>
</svg>
'@
Render-Card "34" "DREIRAD" "#fef2f2" "#dc2626" $svg34

# 35: JO-JO
$svg35 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(40, 20)">
    <path d="M 110 0 Q 110 60 105 110" fill="none" stroke="#64748b" stroke-width="3"/>
    <circle cx="120" cy="150" r="65" fill="#b45309" stroke="#78350f" stroke-width="4"/>
    <rect x="100" y="142" width="15" height="16" fill="#1e293b"/>
    <circle cx="105" cy="150" r="65" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <circle cx="105" cy="150" r="45" fill="none" stroke="#d97706" stroke-width="3"/>
    <circle cx="105" cy="150" r="25" fill="none" stroke="#d97706" stroke-width="2"/>
    <circle cx="105" cy="150" r="8" fill="#78350f"/>
  </g>
</svg>
'@
Render-Card "35" "JO-JO" "#fffbeb" "#b45309" $svg35

# 36: YO-YO
$svg36 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(40, 20)">
    <path d="M 110 0 Q 115 50 105 110" fill="none" stroke="#facc15" stroke-width="4"/>
    <circle cx="120" cy="150" r="65" fill="#16a34a" stroke="#15803d" stroke-width="4"/>
    <circle cx="105" cy="150" r="65" fill="#06b6d4" stroke="#0891b2" stroke-width="4"/>
    <circle cx="105" cy="150" r="45" fill="#22c55e" stroke="#16a34a" stroke-width="3"/>
    <circle cx="105" cy="150" r="22" fill="#ffffff" opacity="0.6"/>
    <polygon points="105,135 115,145 105,155 95,145" fill="#facc15"/>
    <polygon points="105,145 115,155 105,165 95,155" fill="#ef4444"/>
  </g>
</svg>
'@
Render-Card "36" "YO-YO" "#ecfeff" "#0891b2" $svg36

# 37: WERKBANK
$svg37 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Wooden table top -->
    <rect x="20" y="110" width="200" height="24" rx="4" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <!-- Backboard with holes & tools -->
    <rect x="25" y="30" width="190" height="80" rx="4" fill="#fde68a" stroke="#d97706" stroke-width="3"/>
    <!-- Hammer hanging -->
    <rect x="55" y="45" width="8" height="55" rx="2" fill="#78350f"/>
    <rect x="47" y="45" width="24" height="14" rx="3" fill="#64748b"/>
    <!-- Wrench hanging -->
    <rect x="95" y="45" width="8" height="55" rx="2" fill="#3b82f6"/>
    <circle cx="99" cy="48" r="8" fill="#3b82f6"/>
    <circle cx="99" cy="48" r="4" fill="#fde68a"/>
    <!-- Screwdriver hanging -->
    <rect x="135" y="55" width="6" height="45" rx="2" fill="#cbd5e1"/>
    <rect x="133" y="40" width="10" height="20" rx="3" fill="#ef4444"/>
    <!-- Table legs -->
    <rect x="35" y="134" width="20" height="95" rx="4" fill="#d97706" stroke="#92400e" stroke-width="3"/>
    <rect x="185" y="134" width="20" height="95" rx="4" fill="#d97706" stroke="#92400e" stroke-width="3"/>
    <!-- Bottom shelf with screws -->
    <rect x="30" y="185" width="180" height="15" fill="#f59e0b" stroke="#b45309" stroke-width="2"/>
    <circle cx="80" cy="192" r="4" fill="#3b82f6"/>
    <circle cx="110" cy="192" r="4" fill="#ef4444"/>
    <circle cx="140" cy="192" r="4" fill="#22c55e"/>
  </g>
</svg>
'@
Render-Card "37" "WERKBANK" "#fffbeb" "#b45309" $svg37

# 38: FINGERFARBEN
$svg38 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(10, 40)">
    <!-- 4 Pots of Finger Paint in perspective row -->
    <!-- Pot 1: Red -->
    <g transform="translate(15, 30)">
      <rect x="0" y="25" width="55" height="70" rx="8" fill="#ef4444" stroke="#b91c1c" stroke-width="4"/>
      <ellipse cx="27" cy="25" rx="28" ry="10" fill="#fca5a5" stroke="#b91c1c" stroke-width="3"/>
      <!-- Paint splatter -->
      <path d="M 27 50 Q 35 45 40 55 Q 35 65 27 60 Q 20 65 15 55 Z" fill="#ffffff" opacity="0.6"/>
    </g>
    <!-- Pot 2: Yellow -->
    <g transform="translate(80, 20)">
      <rect x="0" y="25" width="55" height="75" rx="8" fill="#facc15" stroke="#ca8a04" stroke-width="4"/>
      <ellipse cx="27" cy="25" rx="28" ry="10" fill="#fef08a" stroke="#ca8a04" stroke-width="3"/>
    </g>
    <!-- Pot 3: Green -->
    <g transform="translate(145, 20)">
      <rect x="0" y="25" width="55" height="75" rx="8" fill="#22c55e" stroke="#15803d" stroke-width="4"/>
      <ellipse cx="27" cy="25" rx="28" ry="10" fill="#86efac" stroke="#15803d" stroke-width="3"/>
    </g>
    <!-- Pot 4: Blue -->
    <g transform="translate(210, 30)">
      <rect x="0" y="25" width="55" height="70" rx="8" fill="#3b82f6" stroke="#1d4ed8" stroke-width="4"/>
      <ellipse cx="27" cy="25" rx="28" ry="10" fill="#93c5fd" stroke="#1d4ed8" stroke-width="3"/>
    </g>
    <!-- Handprints in front -->
    <g transform="translate(100, 130)">
      <!-- Left Handprint (Purple) -->
      <circle cx="20" cy="50" r="16" fill="#a855f7" opacity="0.8"/>
      <ellipse cx="6" cy="30" rx="4" ry="10" fill="#a855f7" opacity="0.8" transform="rotate(-30 6 30)"/>
      <ellipse cx="14" cy="24" rx="4" ry="12" fill="#a855f7" opacity="0.8" transform="rotate(-10 14 24)"/>
      <ellipse cx="24" cy="22" rx="4" ry="13" fill="#a855f7" opacity="0.8"/>
      <ellipse cx="34" cy="25" rx="4" ry="11" fill="#a855f7" opacity="0.8" transform="rotate(10 34 25)"/>
      <ellipse cx="40" cy="36" rx="4" ry="9" fill="#a855f7" opacity="0.8" transform="rotate(35 40 36)"/>
      <!-- Right Handprint (Cyan) -->
      <circle cx="75" cy="50" r="16" fill="#06b6d4" opacity="0.8"/>
      <ellipse cx="61" cy="36" rx="4" ry="9" fill="#06b6d4" opacity="0.8" transform="rotate(-35 61 36)"/>
      <ellipse cx="67" cy="25" rx="4" ry="11" fill="#06b6d4" opacity="0.8" transform="rotate(-10 67 25)"/>
      <ellipse cx="77" cy="22" rx="4" ry="13" fill="#06b6d4" opacity="0.8"/>
      <ellipse cx="87" cy="24" rx="4" ry="12" fill="#06b6d4" opacity="0.8" transform="rotate(10 87 24)"/>
      <ellipse cx="95" cy="30" rx="4" ry="10" fill="#06b6d4" opacity="0.8" transform="rotate(30 95 30)"/>
    </g>
  </g>
</svg>
'@
Render-Card "38" "FINGERFARBEN" "#fdf4ff" "#a855f7" $svg38

# 39: DARTSCHEIBE
$svg39 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(150, 130)">
    <!-- Outer rim -->
    <circle cx="0" cy="0" r="105" fill="#1e293b" stroke="#0f172a" stroke-width="4"/>
    <!-- Outer double ring -->
    <circle cx="0" cy="0" r="92" fill="#ef4444" stroke="#ffffff" stroke-width="2"/>
    <circle cx="0" cy="0" r="82" fill="#22c55e" stroke="#ffffff" stroke-width="2"/>
    <!-- Large single segments -->
    <circle cx="0" cy="0" r="75" fill="#f8fafc" stroke="#1e293b" stroke-width="2"/>
    <!-- Triple ring -->
    <circle cx="0" cy="0" r="50" fill="#ef4444" stroke="#ffffff" stroke-width="2"/>
    <circle cx="0" cy="0" r="42" fill="#22c55e" stroke="#ffffff" stroke-width="2"/>
    <circle cx="0" cy="0" r="36" fill="#f8fafc" stroke="#1e293b" stroke-width="2"/>
    <!-- Outer bullseye (green) -->
    <circle cx="0" cy="0" r="18" fill="#22c55e" stroke="#ffffff" stroke-width="2"/>
    <!-- Inner bullseye (red) -->
    <circle cx="0" cy="0" r="8" fill="#ef4444"/>
    <!-- Wire lines -->
    <line x1="-92" y1="0" x2="92" y2="0" stroke="#cbd5e1" stroke-width="2"/>
    <line x1="0" y1="-92" x2="0" y2="92" stroke="#cbd5e1" stroke-width="2"/>
    <line x1="-65" y1="-65" x2="65" y2="65" stroke="#cbd5e1" stroke-width="2"/>
    <line x1="-65" y1="65" x2="65" y2="-65" stroke="#cbd5e1" stroke-width="2"/>
    <!-- Dart sticking into board -->
    <g transform="translate(15, -15) rotate(45)">
      <polygon points="0,0 -4,-30 4,-30" fill="#facc15" stroke="#ca8a04"/>
      <polygon points="-8,-30 8,-30 12,-60 -12,-60" fill="#ef4444"/>
    </g>
  </g>
</svg>
'@
Render-Card "39" "DARTSCHEIBE" "#fef2f2" "#dc2626" $svg39

# 40: RC-AUTO
$svg40 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(10, 20)">
    <!-- Racing RC Car -->
    <!-- Rear Spoiler -->
    <polygon points="30,85 10,80 15,95 35,100" fill="#0284c7" stroke="#0369a1" stroke-width="3"/>
    <!-- Big Wheels -->
    <circle cx="75" cy="180" r="32" fill="#1e293b" stroke="#0f172a" stroke-width="4"/>
    <circle cx="75" cy="180" r="16" fill="#38bdf8"/>
    <circle cx="215" cy="180" r="32" fill="#1e293b" stroke="#0f172a" stroke-width="4"/>
    <circle cx="215" cy="180" r="16" fill="#38bdf8"/>
    <!-- Car Body (Electric Blue Racer) -->
    <path d="M 35 150 Q 40 100 80 90 L 140 85 Q 185 85 220 125 L 260 145 Q 265 170 245 175 L 50 175 Z" fill="#0284c7" stroke="#0369a1" stroke-width="5"/>
    <!-- Racing Stripes (Yellow/Orange) -->
    <path d="M 50 140 L 250 140 L 245 155 L 45 155 Z" fill="#facc15"/>
    <!-- Windshield -->
    <polygon points="90,92 135,88 155,120 80,120" fill="#e0f2fe" stroke="#0284c7" stroke-width="3"/>
    <!-- RC Antenna with flag -->
    <line x1="70" y1="90" x2="70" y2="10" stroke="#64748b" stroke-width="3"/>
    <polygon points="70,10 95,20 70,30" fill="#ef4444"/>
    <!-- Remote Controller small icon on side -->
    <g transform="translate(225, 40)">
      <rect x="0" y="20" width="35" height="50" rx="6" fill="#334155" stroke="#1e293b" stroke-width="2"/>
      <line x1="17" y1="20" x2="17" y2="0" stroke="#94a3b8" stroke-width="3"/>
      <circle cx="17" cy="40" r="6" fill="#ef4444"/>
    </g>
  </g>
</svg>
'@
Render-Card "40" "RC-AUTO" "#e0f2fe" "#0284c7" $svg40

# 41: STOFFHUND
$svg41 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(45, 10)">
    <!-- Droopy Ears -->
    <ellipse cx="60" cy="110" rx="18" ry="40" fill="#92400e" stroke="#78350f" stroke-width="4" transform="rotate(-15 60 110)"/>
    <ellipse cx="150" cy="110" rx="18" ry="40" fill="#92400e" stroke="#78350f" stroke-width="4" transform="rotate(15 150 110)"/>
    <!-- Body -->
    <ellipse cx="105" cy="175" rx="55" ry="50" fill="#d97706" stroke="#b45309" stroke-width="4"/>
    <ellipse cx="105" cy="175" rx="35" ry="32" fill="#fef3c7"/>
    <!-- Head -->
    <circle cx="105" cy="105" r="45" fill="#d97706" stroke="#b45309" stroke-width="4"/>
    <!-- Muzzle / Snout -->
    <ellipse cx="105" cy="120" rx="25" ry="18" fill="#fef3c7" stroke="#b45309" stroke-width="3"/>
    <!-- Cute black nose -->
    <ellipse cx="105" cy="112" rx="10" ry="7" fill="#1e293b"/>
    <path d="M 105 119 L 105 128" stroke="#1e293b" stroke-width="2"/>
    <path d="M 98 126 Q 105 133 112 126" fill="none" stroke="#1e293b" stroke-width="2" stroke-linecap="round"/>
    <!-- Big Kind Eyes -->
    <circle cx="85" cy="95" r="7" fill="#1e293b"/>
    <circle cx="87" cy="93" r="2.5" fill="#ffffff"/>
    <circle cx="125" cy="95" r="7" fill="#1e293b"/>
    <circle cx="127" cy="93" r="2.5" fill="#ffffff"/>
    <!-- Collar with red tag -->
    <path d="M 70 145 Q 105 155 140 145" fill="none" stroke="#ef4444" stroke-width="8" stroke-linecap="round"/>
    <circle cx="105" cy="155" r="6" fill="#facc15"/>
    <!-- Paws -->
    <ellipse cx="70" cy="220" rx="18" ry="12" fill="#d97706" stroke="#b45309" stroke-width="3"/>
    <ellipse cx="140" cy="220" rx="18" ry="12" fill="#d97706" stroke="#b45309" stroke-width="3"/>
  </g>
</svg>
'@
Render-Card "41" "STOFFHUND" "#fffbeb" "#b45309" $svg41

# 42: SCHAUKELPFERD
$svg42 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(15, 20)">
    <!-- Curved Rocker Base -->
    <path d="M 15 220 Q 135 255 255 220" fill="none" stroke="#b91c1c" stroke-width="12" stroke-linecap="round"/>
    <!-- Legs -->
    <line x1="60" y1="228" x2="90" y2="160" stroke="#d97706" stroke-width="10" stroke-linecap="round"/>
    <line x1="210" y1="228" x2="180" y2="160" stroke="#d97706" stroke-width="10" stroke-linecap="round"/>
    <!-- Horse Body -->
    <ellipse cx="135" cy="150" rx="55" ry="30" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <!-- Saddle (Red) -->
    <path d="M 115 130 Q 135 145 155 130 L 150 155 L 120 155 Z" fill="#ef4444" stroke="#b91c1c" stroke-width="3"/>
    <!-- Neck & Head -->
    <path d="M 85 150 Q 80 90 60 70 Q 55 60 75 55 Q 105 70 115 130 Z" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <!-- Mane (orange) -->
    <path d="M 95 65 Q 105 85 110 115" stroke="#ea580c" stroke-width="8" stroke-linecap="round"/>
    <!-- Ear -->
    <polygon points="70,55 75,40 85,50" fill="#f59e0b" stroke="#b45309" stroke-width="3"/>
    <!-- Eye & Bridle -->
    <circle cx="72" cy="65" r="4" fill="#1e293b"/>
    <line x1="60" y1="70" x2="90" y2="78" stroke="#ef4444" stroke-width="3"/>
    <!-- Rocker crossbar -->
    <line x1="85" y1="80" x2="85" y2="100" stroke="#92400e" stroke-width="6"/>
  </g>
</svg>
'@
Render-Card "42" "SCHAUKELPFERD" "#fffbeb" "#d97706" $svg42

# 43: KAUFMANNSLADEN
$svg43 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(25, 15)">
    <!-- Red & White Striped Awning (Canopy) -->
    <path d="M 30 20 L 220 20 L 210 65 L 40 65 Z" fill="#ffffff" stroke="#b91c1c" stroke-width="3"/>
    <polygon points="30,20 60,20 55,65 40,65" fill="#ef4444"/>
    <polygon points="90,20 120,20 115,65 85,65" fill="#ef4444"/>
    <polygon points="150,20 180,20 175,65 145,65" fill="#ef4444"/>
    <polygon points="210,20 220,20 210,65 205,65" fill="#ef4444"/>
    <!-- Wooden shelf frame -->
    <rect x="40" y="65" width="170" height="150" fill="#fde68a" stroke="#ca8a04" stroke-width="4"/>
    <!-- Shelves -->
    <line x1="40" y1="115" x2="210" y2="115" stroke="#ca8a04" stroke-width="6"/>
    <line x1="40" y1="165" x2="210" y2="165" stroke="#ca8a04" stroke-width="6"/>
    <!-- Goods on shelves -->
    <!-- Top shelf: fruit crates -->
    <circle cx="65" cy="100" r="10" fill="#ef4444"/>
    <circle cx="90" cy="100" r="10" fill="#22c55e"/>
    <circle cx="115" cy="100" r="10" fill="#f97316"/>
    <circle cx="140" cy="100" r="10" fill="#facc15"/>
    <!-- Counter table with Cash Register in front -->
    <rect x="25" y="165" width="200" height="55" rx="6" fill="#f59e0b" stroke="#b45309" stroke-width="4"/>
    <rect x="140" y="135" width="50" height="35" rx="4" fill="#0284c7" stroke="#0369a1" stroke-width="3"/>
    <rect x="150" y="125" width="30" height="12" rx="2" fill="#38bdf8"/>
  </g>
</svg>
'@
Render-Card "43" "KAUFMANNSLADEN" "#fefce8" "#b45309" $svg43

# 44: DOMINO
$svg44 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 20)">
    <!-- Domino 1 (Upright tilted) -->
    <g transform="translate(30, 50) rotate(-15)">
      <rect x="0" y="0" width="75" height="150" rx="8" fill="#ffffff" stroke="#cbd5e1" stroke-width="4"/>
      <line x1="0" y1="75" x2="75" y2="75" stroke="#64748b" stroke-width="3"/>
      <!-- Top 3 dots -->
      <circle cx="20" cy="20" r="6" fill="#1e293b"/>
      <circle cx="37" cy="37" r="6" fill="#1e293b"/>
      <circle cx="55" cy="55" r="6" fill="#1e293b"/>
      <!-- Bottom 5 dots -->
      <circle cx="20" cy="95" r="6" fill="#1e293b"/>
      <circle cx="55" cy="95" r="6" fill="#1e293b"/>
      <circle cx="37" cy="112" r="6" fill="#1e293b"/>
      <circle cx="20" cy="130" r="6" fill="#1e293b"/>
      <circle cx="55" cy="130" r="6" fill="#1e293b"/>
    </g>
    <!-- Domino 2 (Lying flat) -->
    <g transform="translate(115, 90) rotate(15)">
      <rect x="0" y="0" width="150" height="75" rx="8" fill="#ffffff" stroke="#cbd5e1" stroke-width="4"/>
      <line x1="75" y1="0" x2="75" y2="75" stroke="#64748b" stroke-width="3"/>
      <!-- Left 4 dots -->
      <circle cx="25" cy="22" r="6" fill="#1e293b"/>
      <circle cx="50" cy="22" r="6" fill="#1e293b"/>
      <circle cx="25" cy="52" r="6" fill="#1e293b"/>
      <circle cx="50" cy="52" r="6" fill="#1e293b"/>
      <!-- Right 2 dots -->
      <circle cx="95" cy="22" r="6" fill="#1e293b"/>
      <circle cx="130" cy="52" r="6" fill="#1e293b"/>
    </g>
  </g>
</svg>
'@
Render-Card "44" "DOMINO" "#f8fafc" "#334155" $svg44

# 45: SPIELZELT (Tipi)
$svg45 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(40, 20)">
    <!-- Wooden poles extending from top -->
    <line x1="85" y1="0" x2="135" y2="230" stroke="#78350f" stroke-width="6"/>
    <line x1="135" y1="0" x2="85" y2="230" stroke="#78350f" stroke-width="6"/>
    <line x1="110" y1="0" x2="110" y2="230" stroke="#78350f" stroke-width="6"/>
    <!-- Tent Fabric (Yellow / Teal chevron pattern) -->
    <polygon points="110,40 20,225 200,225" fill="#fef08a" stroke="#ca8a04" stroke-width="4"/>
    <!-- Decorative stripes -->
    <polygon points="110,90 80,140 140,140" fill="#06b6d4"/>
    <polygon points="80,140 60,180 160,180 140,140" fill="#f43f5e"/>
    <!-- Front Door Flaps Open -->
    <polygon points="110,90 70,225 150,225" fill="#0f172a" opacity="0.3"/>
    <polygon points="110,90 70,225 110,225" fill="#fde047"/>
    <polygon points="110,90 150,225 110,225" fill="#fde047"/>
  </g>
</svg>
'@
Render-Card "45" "SPIELZELT" "#fefce8" "#ca8a04" $svg45

# 46: STRAßENKREIDE (Colorful sidewalk chalk sticks)
$svg46 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(30, 40)">
    <!-- 4 Jumbo Sidewalk Chalk Sticks standing slanted -->
    <!-- Pink stick -->
    <g transform="translate(20, 20) rotate(-15)">
      <rect x="0" y="20" width="36" height="140" rx="8" fill="#f472b6" stroke="#db2777" stroke-width="3"/>
      <ellipse cx="18" cy="20" rx="18" ry="8" fill="#fbcfe8"/>
    </g>
    <!-- Blue stick -->
    <g transform="translate(75, 10) rotate(-5)">
      <rect x="0" y="20" width="36" height="150" rx="8" fill="#38bdf8" stroke="#0284c7" stroke-width="3"/>
      <ellipse cx="18" cy="20" rx="18" ry="8" fill="#bae6fd"/>
    </g>
    <!-- Yellow stick -->
    <g transform="translate(130, 10) rotate(5)">
      <rect x="0" y="20" width="36" height="150" rx="8" fill="#facc15" stroke="#ca8a04" stroke-width="3"/>
      <ellipse cx="18" cy="20" rx="18" ry="8" fill="#fef08a"/>
    </g>
    <!-- Green stick -->
    <g transform="translate(185, 20) rotate(15)">
      <rect x="0" y="20" width="36" height="140" rx="8" fill="#4ade80" stroke="#16a34a" stroke-width="3"/>
      <ellipse cx="18" cy="20" rx="18" ry="8" fill="#bbf7d0"/>
    </g>
    <!-- Colorful chalk marks below -->
    <path d="M 10 200 Q 120 180 230 200" stroke="#f472b6" stroke-width="8" stroke-linecap="round" opacity="0.6"/>
    <path d="M 30 215 Q 130 195 240 215" stroke="#38bdf8" stroke-width="8" stroke-linecap="round" opacity="0.6"/>
  </g>
</svg>
'@
Render-Card "46" "STRAßENKREIDE" "#fdf2f8" "#db2777" $svg46

# 47: KREIDE (Blackboard with colored chalk)
$svg47 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(20, 20)">
    <!-- Wooden board frame -->
    <rect x="15" y="25" width="230" height="160" rx="10" fill="#78350f" stroke="#451a03" stroke-width="5"/>
    <!-- Slate chalkboard surface -->
    <rect x="27" y="37" width="206" height="136" rx="4" fill="#0f766e" stroke="#134e4a" stroke-width="2"/>
    <!-- Chalk writing: "1 + 1 = 2" and a smile -->
    <text x="130" y="95" font-size="28" font-weight="900" fill="#ffffff" text-anchor="middle" font-family="Comic Sans MS, cursive">1 + 2 = 3</text>
    <circle cx="110" cy="130" r="16" fill="none" stroke="#fef08a" stroke-width="3"/>
    <circle cx="104" cy="126" r="2" fill="#fef08a"/>
    <circle cx="116" cy="126" r="2" fill="#fef08a"/>
    <path d="M 104 135 Q 110 142 116 135" fill="none" stroke="#fef08a" stroke-width="2"/>
    <!-- Chalk ledge at bottom with 3 pieces of chalk -->
    <rect x="10" y="185" width="240" height="14" rx="4" fill="#92400e"/>
    <rect x="50" y="178" width="30" height="8" rx="3" fill="#ffffff"/>
    <rect x="90" y="178" width="30" height="8" rx="3" fill="#f472b6"/>
    <rect x="130" y="178" width="30" height="8" rx="3" fill="#facc15"/>
  </g>
</svg>
'@
Render-Card "47" "KREIDE" "#f0fdfa" "#0f766e" $svg47

# 48: HÜPFBALL (Red hopper ball with handles)
$svg48 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <defs>
    <radialGradient id="hopGrad" cx="35%" cy="35%" r="65%">
      <stop offset="0%" stop-color="#fca5a5"/>
      <stop offset="60%" stop-color="#ef4444"/>
      <stop offset="100%" stop-color="#991b1b"/>
    </radialGradient>
  </defs>
  <g transform="translate(60, 20)">
    <!-- Two loop handles at top -->
    <path d="M 65 80 Q 55 20 75 15 Q 90 20 85 80" fill="none" stroke="#991b1b" stroke-width="12" stroke-linecap="round"/>
    <path d="M 65 80 Q 55 20 75 15 Q 90 20 85 80" fill="none" stroke="#ef4444" stroke-width="8" stroke-linecap="round"/>
    <path d="M 95 80 Q 90 20 105 15 Q 125 20 115 80" fill="none" stroke="#991b1b" stroke-width="12" stroke-linecap="round"/>
    <path d="M 95 80 Q 90 20 105 15 Q 125 20 115 80" fill="none" stroke="#ef4444" stroke-width="8" stroke-linecap="round"/>
    <!-- Big red ball body -->
    <circle cx="90" cy="150" r="75" fill="url(#hopGrad)" stroke="#7f1d1d" stroke-width="3"/>
    <!-- Specular highlight -->
    <ellipse cx="65" cy="115" rx="18" ry="10" transform="rotate(-30 65 115)" fill="#ffffff" opacity="0.6"/>
  </g>
</svg>
'@
Render-Card "48" "HÜPFBALL" "#fef2f2" "#dc2626" $svg48

# 49: MIKADO (Pick up sticks)
$svg49 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(150, 130)">
    <!-- Crossing striped wooden sticks -->
    <!-- Stick 1 (Main Mikado Blue spiral) -->
    <g transform="rotate(-65)">
      <rect x="-120" y="-4" width="240" height="8" rx="4" fill="#fef3c7" stroke="#b45309" stroke-width="1"/>
      <rect x="-80" y="-4" width="12" height="8" fill="#1d4ed8"/>
      <rect x="-40" y="-4" width="12" height="8" fill="#1d4ed8"/>
      <rect x="0" y="-4" width="12" height="8" fill="#1d4ed8"/>
      <rect x="40" y="-4" width="12" height="8" fill="#1d4ed8"/>
      <rect x="80" y="-4" width="12" height="8" fill="#1d4ed8"/>
    </g>
    <!-- Stick 2 (Red striped) -->
    <g transform="rotate(-35)">
      <rect x="-120" y="-4" width="240" height="8" rx="4" fill="#fef3c7" stroke="#b45309" stroke-width="1"/>
      <rect x="-60" y="-4" width="12" height="8" fill="#dc2626"/>
      <rect x="20" y="-4" width="12" height="8" fill="#dc2626"/>
    </g>
    <!-- Stick 3 (Yellow/Green striped) -->
    <g transform="rotate(10)">
      <rect x="-120" y="-4" width="240" height="8" rx="4" fill="#fef3c7" stroke="#b45309" stroke-width="1"/>
      <rect x="-70" y="-4" width="12" height="8" fill="#16a34a"/>
      <rect x="-10" y="-4" width="12" height="8" fill="#f59e0b"/>
      <rect x="50" y="-4" width="12" height="8" fill="#16a34a"/>
    </g>
    <!-- Stick 4 (Cross) -->
    <g transform="rotate(45)">
      <rect x="-120" y="-4" width="240" height="8" rx="4" fill="#fef3c7" stroke="#b45309" stroke-width="1"/>
      <rect x="-50" y="-4" width="12" height="8" fill="#dc2626"/>
      <rect x="30" y="-4" width="12" height="8" fill="#1d4ed8"/>
    </g>
    <!-- Stick 5 (Cross) -->
    <g transform="rotate(75)">
      <rect x="-120" y="-4" width="240" height="8" rx="4" fill="#fef3c7" stroke="#b45309" stroke-width="1"/>
      <rect x="-30" y="-4" width="12" height="8" fill="#f59e0b"/>
      <rect x="40" y="-4" width="12" height="8" fill="#f59e0b"/>
    </g>
  </g>
</svg>
'@
Render-Card "49" "MIKADO" "#fffbeb" "#b45309" $svg49

# 50: SPIELFIGUREN
$svg50 = @'
<svg class="toy-svg" width="600" height="520" viewBox="0 0 300 260">
  <g transform="translate(20, 20)">
    <!-- 3 Colorful Boardgame / Play figures (Halma / Play style) -->
    <!-- Figure 1: Red (Left) -->
    <g transform="translate(45, 60)">
      <circle cx="25" cy="20" r="16" fill="#ef4444" stroke="#b91c1c" stroke-width="3"/>
      <path d="M 25 35 Q 5 100 0 135 L 50 135 Q 45 100 25 35 Z" fill="#ef4444" stroke="#b91c1c" stroke-width="3"/>
    </g>
    <!-- Figure 2: Blue (Center, slightly larger) -->
    <g transform="translate(105, 30)">
      <circle cx="30" cy="24" r="20" fill="#3b82f6" stroke="#1d4ed8" stroke-width="4"/>
      <path d="M 30 44 Q 8 120 0 165 L 60 165 Q 52 120 30 44 Z" fill="#3b82f6" stroke="#1d4ed8" stroke-width="4"/>
    </g>
    <!-- Figure 3: Yellow (Right) -->
    <g transform="translate(175, 60)">
      <circle cx="25" cy="20" r="16" fill="#facc15" stroke="#ca8a04" stroke-width="3"/>
      <path d="M 25 35 Q 5 100 0 135 L 50 135 Q 45 100 25 35 Z" fill="#facc15" stroke="#ca8a04" stroke-width="3"/>
    </g>
    <!-- Figure 4: Green (Front Left) -->
    <g transform="translate(75, 90)">
      <circle cx="20" cy="18" r="14" fill="#22c55e" stroke="#15803d" stroke-width="3"/>
      <path d="M 20 32 Q 5 85 0 115 L 40 115 Q 35 85 20 32 Z" fill="#22c55e" stroke="#15803d" stroke-width="3"/>
    </g>
  </g>
</svg>
'@
Render-Card "50" "SPIELFIGUREN" "#f8fafc" "#1d4ed8" $svg50

Write-Host "Completed Toys 29 to 50!" -ForegroundColor Cyan
