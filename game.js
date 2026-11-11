/**
 * Dalli Klick - Das Bilderrätsel-Spiel für Kinder & Familien
 * Vollständig eigenständig mit Web Audio API, anpassbaren Bildern & Mehrspieler-Buzzer
 * Mit Memorbild-Modus: unregelmäßige, nicht-quadratische Ausschnitte in verschiedenen Größen!
 */

// Web Audio API Synthesizer (Keine externen Sounddateien notwendig!)
class SoundEffects {
  constructor() {
    this.ctx = null;
    this.muted = false;
  }

  init() {
    if (!this.ctx) {
      const AudioCtx = window.AudioContext || window.webkitAudioContext;
      if (AudioCtx) {
        this.ctx = new AudioCtx();
      }
    }
    if (this.ctx && this.ctx.state === 'suspended') {
      this.ctx.resume();
    }
  }

  playTileClick() {
    if (this.muted) return;
    this.init();
    if (!this.ctx) return;
    
    const osc = this.ctx.createOscillator();
    const gain = this.ctx.createGain();
    const now = this.ctx.currentTime;

    osc.type = 'triangle';
    osc.frequency.setValueAtTime(360, now);
    osc.frequency.exponentialRampToValueAtTime(720, now + 0.08);

    gain.gain.setValueAtTime(0.18, now);
    gain.gain.exponentialRampToValueAtTime(0.01, now + 0.08);

    osc.connect(gain);
    gain.connect(this.ctx.destination);

    osc.start(now);
    osc.stop(now + 0.09);
  }

  playBuzzer() {
    if (this.muted) return;
    this.init();
    if (!this.ctx) return;

    const now = this.ctx.currentTime;
    
    // Reichhaltiger Doppelton-Buzzer
    [290, 440].forEach((freq) => {
      const osc = this.ctx.createOscillator();
      const gain = this.ctx.createGain();
      osc.type = 'sawtooth';
      osc.frequency.setValueAtTime(freq, now);

      gain.gain.setValueAtTime(0.25, now);
      gain.gain.exponentialRampToValueAtTime(0.01, now + 0.45);

      osc.connect(gain);
      gain.connect(this.ctx.destination);

      osc.start(now);
      osc.stop(now + 0.46);
    });
  }

  playCorrect() {
    if (this.muted) return;
    this.init();
    if (!this.ctx) return;

    const notes = [523.25, 659.25, 783.99, 1046.50]; // C5, E5, G5, C6
    notes.forEach((freq, idx) => {
      const osc = this.ctx.createOscillator();
      const gain = this.ctx.createGain();
      const now = this.ctx.currentTime + idx * 0.1;

      osc.type = 'sine';
      osc.frequency.setValueAtTime(freq, now);

      gain.gain.setValueAtTime(0.25, now);
      gain.gain.exponentialRampToValueAtTime(0.01, now + 0.35);

      osc.connect(gain);
      gain.connect(this.ctx.destination);

      osc.start(now);
      osc.stop(now + 0.36);
    });
  }

  playWrong() {
    if (this.muted) return;
    this.init();
    if (!this.ctx) return;

    const now = this.ctx.currentTime;
    const osc = this.ctx.createOscillator();
    const gain = this.ctx.createGain();

    osc.type = 'sawtooth';
    osc.frequency.setValueAtTime(180, now);
    osc.frequency.linearRampToValueAtTime(110, now + 0.4);

    gain.gain.setValueAtTime(0.3, now);
    gain.gain.exponentialRampToValueAtTime(0.01, now + 0.4);

    osc.connect(gain);
    gain.connect(this.ctx.destination);

    osc.start(now);
    osc.stop(now + 0.41);
  }

  playVictory() {
    if (this.muted) return;
    this.init();
    if (!this.ctx) return;

    const melody = [
      { f: 523.25, d: 0.15 }, // C
      { f: 659.25, d: 0.15 }, // E
      { f: 783.99, d: 0.15 }, // G
      { f: 1046.50, d: 0.4 }, // C
      { f: 880.00, d: 0.2 },  // A
      { f: 1046.50, d: 0.6 }  // C
    ];

    let t = this.ctx.currentTime;
    melody.forEach((m) => {
      const osc = this.ctx.createOscillator();
      const gain = this.ctx.createGain();
      osc.type = 'triangle';
      osc.frequency.setValueAtTime(m.f, t);

      gain.gain.setValueAtTime(0.3, t);
      gain.gain.exponentialRampToValueAtTime(0.01, t + m.d);

      osc.connect(gain);
      gain.connect(this.ctx.destination);

      osc.start(t);
      osc.stop(t + m.d + 0.05);
      t += m.d;
    });
  }
}

// Konfetti-Partikelsystem für Siege & richtige Antworten
class ConfettiManager {
  constructor(canvas) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.particles = [];
    this.animationId = null;
    this.resize();
    window.addEventListener('resize', () => this.resize());
  }

  resize() {
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;
  }

  burst(count = 90) {
    const colors = ['#f59e0b', '#ef4444', '#10b981', '#3b82f6', '#ec4899', '#8b5cf6'];
    for (let i = 0; i < count; i++) {
      this.particles.push({
        x: this.canvas.width / 2 + (Math.random() * 200 - 100),
        y: this.canvas.height * 0.4 + (Math.random() * 100 - 50),
        vx: (Math.random() - 0.5) * 16,
        vy: (Math.random() - 1.2) * 14,
        size: Math.random() * 8 + 6,
        color: colors[Math.floor(Math.random() * colors.length)],
        rotation: Math.random() * 360,
        vRot: (Math.random() - 0.5) * 10,
        life: 1.0,
        decay: Math.random() * 0.015 + 0.008
      });
    }

    if (!this.animationId) {
      this.animate();
    }
  }

  animate() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this.particles = this.particles.filter(p => p.life > 0);

    for (const p of this.particles) {
      p.x += p.vx;
      p.y += p.vy;
      p.vy += 0.35; // Schwerkraft
      p.rotation += p.vRot;
      p.life -= p.decay;

      this.ctx.save();
      this.ctx.translate(p.x, p.y);
      this.ctx.rotate((p.rotation * Math.PI) / 180);
      this.ctx.fillStyle = p.color;
      this.ctx.globalAlpha = Math.max(0, p.life);
      this.ctx.fillRect(-p.size / 2, -p.size / 2, p.size, p.size * 0.6);
      this.ctx.restore();
    }

    if (this.particles.length > 0) {
      this.animationId = requestAnimationFrame(() => this.animate());
    } else {
      this.animationId = null;
    }
  }
}

/**
 * Generator für unregelmäßige Voronoi-Mosaik-Zellen (Memorbild-Stil)
 * Garantiert 100% fugenlose, überlappungsfreie Abdeckung des Bildes
 * mit ungleichen Formen (4-8 Ecken) und variierenden Größen!
 */
class VoronoiMosaicGenerator {
  static generate({ width = 1000, height = 750, cols = 7, rows = 6, style = 'mosaic' } = {}) {
    const W = width;
    const H = height;
    const cellW = W / cols;
    const cellH = H / rows;

    // 1. Samenpunkte mit variabler Verschiebung erzeugen (ergibt ungleiche Größen & Formen)
    const seeds = [];
    for (let r = 0; r < rows; r++) {
      for (let c = 0; c < cols; c++) {
        const cx = (c + 0.5) * cellW;
        const cy = (r + 0.5) * cellH;

        // Natürliche Störung für asymmetrische, vielfältige Formen
        const jx = (Math.random() * 2 - 1) * cellW * 0.38;
        const jy = (Math.random() * 2 - 1) * cellH * 0.38;

        seeds.push({
          x: Math.max(12, Math.min(W - 12, cx + jx)),
          y: Math.max(12, Math.min(H - 12, cy + jy)),
          id: seeds.length
        });
      }
    }

    // 2. Sutherland-Hodgman Polygon-Clipping für jede Voronoi-Zelle
    const cells = [];
    for (let i = 0; i < seeds.length; i++) {
      const p1 = seeds[i];
      let poly = [
        { x: 0, y: 0 },
        { x: W, y: 0 },
        { x: W, y: H },
        { x: 0, y: H }
      ];

      for (let j = 0; j < seeds.length; j++) {
        if (i === j) continue;
        const p2 = seeds[j];

        const mx = (p1.x + p2.x) / 2;
        const my = (p1.y + p2.y) / 2;
        const nx = p2.x - p1.x;
        const ny = p2.y - p1.y;

        poly = this.clipPolygon(poly, mx, my, nx, ny);
        if (poly.length < 3) break;
      }

      if (poly.length >= 3) {
        const { cx, cy, area } = this.computeCentroidAndArea(poly);
        cells.push({
          id: i,
          seed: p1,
          points: poly,
          cx,
          cy,
          area
        });
      }
    }

    // Dreiecks-Facetten Modus: Trianguliert jede Zelle vom Schwerpunkt aus
    if (style === 'triangles') {
      const triCells = [];
      let triId = 0;
      for (const cell of cells) {
        const k = cell.points.length;
        for (let idx = 0; idx < k; idx++) {
          const ptA = cell.points[idx];
          const ptB = cell.points[(idx + 1) % k];
          const triPoly = [
            { x: cell.cx, y: cell.cy },
            { x: ptA.x, y: ptA.y },
            { x: ptB.x, y: ptB.y }
          ];
          const { cx, cy, area } = this.computeCentroidAndArea(triPoly);
          if (area > 80) {
            triCells.push({
              id: triId++,
              points: triPoly,
              cx,
              cy,
              area
            });
          }
        }
      }
      return triCells;
    }

    return cells;
  }

  // Klassisches Rechteckgitter (in SVG)
  static generateGrid({ width = 1000, height = 750, cols = 6, rows = 5 } = {}) {
    const W = width, H = height;
    const cellW = W / cols;
    const cellH = H / rows;
    const cells = [];
    let id = 0;
    for (let r = 0; r < rows; r++) {
      for (let c = 0; c < cols; c++) {
        const x1 = c * cellW;
        const y1 = r * cellH;
        const x2 = (c + 1) * cellW;
        const y2 = (r + 1) * cellH;
        cells.push({
          id: id++,
          points: [
            { x: x1, y: y1 },
            { x: x2, y: y1 },
            { x: x2, y: y2 },
            { x: x1, y: y2 }
          ],
          cx: (x1 + x2) / 2,
          cy: (y1 + y2) / 2,
          area: cellW * cellH
        });
      }
    }
    return cells;
  }

  static clipPolygon(poly, mx, my, nx, ny) {
    const isInside = (pt) => (pt.x - mx) * nx + (pt.y - my) * ny <= 0.0001;
    const out = [];
    const len = poly.length;
    if (len === 0) return out;

    for (let i = 0; i < len; i++) {
      const cur = poly[i];
      const prev = poly[(i + len - 1) % len];

      const curInside = isInside(cur);
      const prevInside = isInside(prev);

      if (curInside) {
        if (!prevInside) {
          out.push(this.intersect(prev, cur, mx, my, nx, ny));
        }
        out.push(cur);
      } else if (prevInside) {
        out.push(this.intersect(prev, cur, mx, my, nx, ny));
      }
    }
    return out;
  }

  static intersect(p1, p2, mx, my, nx, ny) {
    const d1 = (p1.x - mx) * nx + (p1.y - my) * ny;
    const d2 = (p2.x - mx) * nx + (p2.y - my) * ny;
    const diff = d1 - d2;
    const t = Math.abs(diff) < 1e-9 ? 0.5 : d1 / diff;
    return {
      x: p1.x + t * (p2.x - p1.x),
      y: p1.y + t * (p2.y - p1.y)
    };
  }

  static computeCentroidAndArea(poly) {
    const k = poly.length;
    let area2 = 0;
    let cx = 0, cy = 0;
    for (let i = 0; i < k; i++) {
      const p1 = poly[i];
      const p2 = poly[(i + 1) % k];
      const cross = p1.x * p2.y - p2.x * p1.y;
      area2 += cross;
      cx += (p1.x + p2.x) * cross;
      cy += (p1.y + p2.y) * cross;
    }
    const area = Math.abs(area2) / 2;
    if (Math.abs(area2) > 1e-4) {
      cx = cx / (3 * area2);
      cy = cy / (3 * area2);
    } else {
      cx = poly.reduce((s, p) => s + p.x, 0) / k;
      cy = poly.reduce((s, p) => s + p.y, 0) / k;
    }
    return { cx, cy, area };
  }
}

// Hauptklasse des Dalli Klick Spiels
class DalliGame {
  constructor() {
    this.sounds = new SoundEffects();
    this.confetti = new ConfettiManager(document.getElementById('confetti-canvas'));

    // Statusvariablen
    this.images = [];
    this.currentImageIndex = -1;
    this.uncoveredTiles = 0;
    this.totalTiles = 42; // Standard: 42 kleine Mosaik-Ausschnitte
    this.cols = 7;
    this.rows = 6;
    this.tileOrder = [];
    this.revealInterval = null;
    this.isPlaying = false;
    this.isBuzzed = false;
    this.isRoundOver = false;
    this.activePlayer = null;
    this.lockedPlayers = new Set();
    this.roundCount = 1;
    this.maxRounds = 10;
    this.speechEnabled = true;

    // Einstellungen für Memorbild-Mosaik
    this.shapeStyle = 'mosaic';      // 'mosaic', 'triangles', 'grid'
    this.tileDensity = 'small';      // 'small' (42), 'xsmall' (56), 'medium' (30), 'large' (20)
    this.tileColorTheme = 'rainbow'; // 'rainbow', 'ocean', 'sunset', 'classic'

    // Standard-Spieler (Spieler 1 & Spieler 2)
    this.players = [
      { id: 1, name: 'Spieler 1', color: '#ef4444', score: 0 },
      { id: 2, name: 'Spieler 2', color: '#3b82f6', score: 0 }
    ];

    // Geschwindigkeitseinstellungen in Millisekunden
    this.speeds = {
      'slow': 1600,
      'medium': 900,
      'fast': 500,
      'turbo': 250,
      'manual': 0
    };
    this.currentSpeed = 'medium';

    // Bilderkategorien (Unterordner in bilder/)
    this.categories = {
      'Familie': [],
      'Spielzeuge': [],
      'Verschiedenes': []
    };
    this.currentCategory = 'Verschiedenes';

    this.initDOM();
    this.initEvents();
    this.loadImages();
  }

  initDOM() {
    this.boardSvg = document.getElementById('board-svg');
    this.tilesLayer = document.getElementById('tiles-layer');
    this.boardGrid = document.getElementById('board-tiles-grid');
    this.boardImg = document.getElementById('board-image');
    this.solutionBanner = document.getElementById('solution-banner');
    this.solutionWord = document.getElementById('solution-word');
    this.speedSelector = document.getElementById('speed-selector');
    this.progressBar = document.getElementById('progress-bar');
    this.roundDisplay = document.getElementById('current-round-display');
    this.totalImagesDisplay = document.getElementById('total-images-display');
    this.sidebarRoundNum = document.getElementById('sidebar-round-num');
    this.btnStart = document.getElementById('btn-start');
    this.btnNext = document.getElementById('btn-next');
    this.btnReveal = document.getElementById('btn-reveal');
    this.btnStep = document.getElementById('btn-step');
    this.toastEl = document.getElementById('toast');

    // Kategorie-Elemente
    this.categorySelect = document.getElementById('category-select');
    this.modalCategorySelect = document.getElementById('modal-category-select');
    this.emptyCategoryNotice = document.getElementById('empty-category-notice');

    // Spieler 1 & Spieler 2 DOM Elements
    this.player1NameInput = document.getElementById('player-1-name-input');
    this.player2NameInput = document.getElementById('player-2-name-input');
    this.player1Score = document.getElementById('player-1-score');
    this.player2Score = document.getElementById('player-2-score');
    this.btnThumb1 = document.getElementById('btn-thumb-1');
    this.btnThumb2 = document.getElementById('btn-thumb-2');
    this.btnThumbDown1 = document.getElementById('btn-thumb-down-1');
    this.btnThumbDown2 = document.getElementById('btn-thumb-down-2');
    this.btnDec1 = document.getElementById('btn-dec-1');
    this.btnDec2 = document.getElementById('btn-dec-2');
    this.btnResetScores = document.getElementById('btn-reset-scores');

    // Settings elements
    this.shapeStyleSelect = document.getElementById('shape-style-select');
    this.tileDensitySelect = document.getElementById('tile-density-select');
    this.tileColorSelect = document.getElementById('tile-color-select');
  }

  initEvents() {
    // Tastatur-Steuerung (Leertaste = Start/Pause, 1 & 2 = Daumen hoch für Spieler)
    window.addEventListener('keydown', (e) => {
      // Ignoriere Eingaben wenn der Nutzer gerade im Namensfeld tippt
      if (document.activeElement && document.activeElement.tagName === 'INPUT') {
        if (e.key === 'Enter') {
          document.activeElement.blur();
        }
        return;
      }

      // Leertaste = Start/Pause
      if (e.code === 'Space') {
        e.preventDefault();
        if (!this.isPlaying && !this.isRoundOver) {
          this.startRound();
        } else if (this.isPlaying) {
          this.pauseRound();
        }
        return;
      }

      // Schnelltaste '1': Daumen hoch für Spieler 1
      if (e.key === '1') {
        e.preventDefault();
        this.awardPoint(0);
        return;
      }

      // Schnelltaste '2': Daumen hoch für Spieler 2
      if (e.key === '2') {
        e.preventDefault();
        this.awardPoint(1);
        return;
      }

      // Weiter zur nächsten Runde mit Enter oder Pfeil-Rechts wenn Runde gelöst
      if ((e.key === 'Enter' || e.key === 'ArrowRight') && this.isRoundOver) {
        this.nextRound();
      }
    });

    // Spieler-Namen Eingabefelder
    if (this.player1NameInput) {
      this.player1NameInput.addEventListener('input', (e) => {
        this.players[0].name = e.target.value.trim() || 'Spieler 1';
      });
    }
    if (this.player2NameInput) {
      this.player2NameInput.addEventListener('input', (e) => {
        this.players[1].name = e.target.value.trim() || 'Spieler 2';
      });
    }

    // Daumen-hoch Buttons (Gewinner-Button: +3 Punkte & Bild aufdecken)
    if (this.btnThumb1) {
      this.btnThumb1.addEventListener('click', () => this.awardPoint(0));
    }
    if (this.btnThumb2) {
      this.btnThumb2.addEventListener('click', () => this.awardPoint(1));
    }

    // Daumen-runter Buttons (Falsche Antwort: -1 Punkt abziehen)
    if (this.btnThumbDown1) {
      this.btnThumbDown1.addEventListener('click', () => this.penalizePlayer(0));
    }
    if (this.btnThumbDown2) {
      this.btnThumbDown2.addEventListener('click', () => this.penalizePlayer(1));
    }

    // Punkte manuell korrigieren (Minus-Buttons)
    if (this.btnDec1) {
      this.btnDec1.addEventListener('click', () => this.penalizePlayer(0));
    }
    if (this.btnDec2) {
      this.btnDec2.addEventListener('click', () => this.penalizePlayer(1));
    }

    // Punktestand zurücksetzen
    if (this.btnResetScores) {
      this.btnResetScores.addEventListener('click', () => this.resetScores());
    }

    // Button Controls
    this.btnStart.addEventListener('click', () => {
      if (this.isPlaying) {
        this.pauseRound();
      } else {
        this.startRound();
      }
    });

    this.btnNext.addEventListener('click', () => this.nextRound());
    this.btnReveal.addEventListener('click', () => this.revealAll(null, true));
    this.btnStep.addEventListener('click', () => this.revealNextTile());

    this.speedSelector.addEventListener('change', (e) => {
      this.currentSpeed = e.target.value;
      if (this.isPlaying) {
        this.pauseRound();
        this.startRound();
      }
    });

    // Header Buttons
    document.getElementById('btn-sound-toggle').addEventListener('click', (e) => {
      this.sounds.muted = !this.sounds.muted;
      e.currentTarget.textContent = this.sounds.muted ? '🔇' : '🔊';
      this.showToast(this.sounds.muted ? 'Ton stummgeschaltet' : 'Ton eingeschaltet');
    });

    document.getElementById('btn-fullscreen').addEventListener('click', () => {
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen().catch(() => {});
      } else {
        document.exitFullscreen().catch(() => {});
      }
    });

    document.getElementById('btn-settings').addEventListener('click', () => {
      this.openSettingsModal();
    });

    // Modal Close
    document.getElementById('modal-close-btn').addEventListener('click', () => {
      this.closeSettingsModal();
    });
    document.getElementById('btn-save-settings').addEventListener('click', () => {
      this.saveSettings();
    });

    // Restart Button im Gameover Modal
    document.getElementById('btn-restart-game').addEventListener('click', () => {
      document.getElementById('gameover-modal').classList.remove('open');
      this.players.forEach(p => p.score = 0);
      this.roundCount = 1;
      this.updatePlayerScoreDisplays();
      this.shuffleArray(this.images);
      this.setupRound(0);
    });

    // Custom folder upload
    const folderInput = document.getElementById('folder-upload-input');
    folderInput.addEventListener('change', (e) => {
      this.handleCustomFolderUpload(e.target.files);
    });

    // Kategorie-Auswahl Event-Listener
    if (this.categorySelect) {
      this.categorySelect.addEventListener('change', (e) => {
        this.switchCategory(e.target.value);
      });
    }
    if (this.modalCategorySelect) {
      this.modalCategorySelect.addEventListener('change', (e) => {
        this.switchCategory(e.target.value);
      });
    }
  }

  // Lade Bilderliste (Dynamisch vom Server oder statisch von bilder.js)
  async loadImages() {
    this.showToast('Lade Bilder & Kategorien...');
    let loadedCats = null;

    // Versuch 1: Dynamischer API-Endpunkt vom PowerShell Server
    try {
      const res = await fetch('/api/bilder');
      if (res.ok) {
        const data = await res.json();
        if (data && typeof data === 'object') {
          if (!Array.isArray(data)) {
            loadedCats = data;
            console.log('Kategorien über Server-API geladen:', Object.keys(data));
          } else {
            loadedCats = { 'Verschiedenes': data };
          }
        }
      }
    } catch (err) {
      console.log('Server-API nicht erreichbar, nutze lokale Kategorien.');
    }

    // Versuch 2: Lokale window.BILDER_KATEGORIEN aus bilder.js
    if (!loadedCats && window.BILDER_KATEGORIEN) {
      loadedCats = window.BILDER_KATEGORIEN;
      console.log('Kategorien über bilder.js geladen:', Object.keys(loadedCats));
    }

    // Versuch 3: Altes window.BILDER_LISTE Fallback
    if (!loadedCats && window.BILDER_LISTE && window.BILDER_LISTE.length > 0) {
      loadedCats = { 'Verschiedenes': window.BILDER_LISTE };
    }

    // Fallback: Mindestens die 3 Standard-Kategorien initialisieren
    if (!loadedCats) {
      loadedCats = {
        'Familie': [],
        'Spielzeuge': [],
        'Verschiedenes': []
      };
    }

    // Sicherstellen, dass die Standard-Kategorien immer existieren
    const standardCategories = ['Familie', 'Spielzeuge', 'Verschiedenes'];
    standardCategories.forEach(cat => {
      if (!loadedCats[cat]) {
        loadedCats[cat] = [];
      }
    });

    this.categories = loadedCats;

    // Spielerliste rendern
    this.renderPlayers();

    // Dropdown(s) befüllen (nur Kategorien mit Bildern aktivieren)
    this.populateCategorySelect('Verschiedenes');

    // Zu Beginn Kategorie 'Verschiedenes' auswählen
    this.switchCategory('Verschiedenes');
  }

  /**
   * Dropdown-Menüs für Bilderkategorien befüllen.
   * Wichtig: Es werden nur Kategorien aktiviert, die auch Bilder enthalten!
   */
  populateCategorySelect(selectedCategory = 'Verschiedenes') {
    const selects = [this.categorySelect, this.modalCategorySelect].filter(Boolean);
    if (selects.length === 0) return;

    const catIcons = {
      'Familie': '👨‍👩‍👧',
      'Spielzeuge': '🧸',
      'Verschiedenes': '🌟'
    };

    const standardOrder = ['Familie', 'Spielzeuge', 'Verschiedenes'];
    const allKeys = Object.keys(this.categories);
    const orderedCategories = [
      ...standardOrder.filter(k => allKeys.includes(k)),
      ...allKeys.filter(k => !standardOrder.includes(k))
    ];

    selects.forEach(sel => {
      sel.innerHTML = '';
      orderedCategories.forEach(cat => {
        const count = (this.categories[cat] || []).length;
        const opt = document.createElement('option');
        opt.value = cat;
        const icon = catIcons[cat] || '📁';
        opt.textContent = `${icon} ${cat}`;

        // Nur Kategorien mit vorhandenen Bildern sind aktivierbar!
        if (count === 0) {
          opt.disabled = true;
          opt.title = `Ordner bilder/${cat}/ enthält keine Bilder (deaktiviert)`;
        } else {
          opt.disabled = false;
        }

        if (cat === selectedCategory) {
          opt.selected = true;
        }
        sel.appendChild(opt);
      });
      sel.value = selectedCategory;
    });
  }

  /**
   * Kategorie wechseln
   */
  switchCategory(categoryName) {
    if (!this.categories[categoryName]) {
      categoryName = 'Verschiedenes';
    }
    this.currentCategory = categoryName;

    // Dropdown-Werte synchronisieren
    if (this.categorySelect) this.categorySelect.value = categoryName;
    if (this.modalCategorySelect) this.modalCategorySelect.value = categoryName;

    if (this.revealInterval) {
      clearInterval(this.revealInterval);
      this.revealInterval = null;
    }
    this.isPlaying = false;
    this.isRoundOver = false;
    this.roundCount = 1;

    const catImages = this.categories[categoryName] || [];
    this.images = catImages.map(item => Object.assign({}, item));
    if (this.totalImagesDisplay) {
      this.totalImagesDisplay.textContent = this.images.length;
    }

    if (this.images.length === 0) {
      this.showEmptyCategoryState(categoryName);
      this.showToast(`Kategorie „${categoryName}“ ausgewählt.`);
    } else {
      this.hideEmptyCategoryState();
      this.shuffleArray(this.images);
      this.setupRound(0);
      this.showToast(`Kategorie „${categoryName}“ aktiviert!`);
    }
  }

  /**
   * Anzeige für leere Kategorie (z. B. Familie zu Beginn ohne Bilder)
   */
  showEmptyCategoryState(categoryName) {
    if (this.btnStart) this.btnStart.disabled = true;
    if (this.btnStep) this.btnStep.disabled = true;
    if (this.btnReveal) this.btnReveal.disabled = true;
    if (this.btnNext) this.btnNext.style.display = 'none';

    if (this.boardSvg) this.boardSvg.style.display = 'none';
    if (this.boardImg) {
      this.boardImg.style.display = 'none';
      this.boardImg.src = '';
    }
    if (this.solutionBanner) this.solutionBanner.classList.remove('show');

    let notice = document.getElementById('empty-category-notice');
    if (!notice) {
      notice = document.createElement('div');
      notice.id = 'empty-category-notice';
      notice.className = 'empty-category-notice';
      const boardContainer = document.querySelector('.board-container');
      if (boardContainer) boardContainer.appendChild(notice);
    }
    notice.style.display = 'flex';

    const title = document.getElementById('empty-category-title');
    if (title) title.textContent = `Kategorie „${categoryName}“ ausgewählt`;

    const desc = document.getElementById('empty-category-desc');
    if (desc) {
      desc.innerHTML = `Im Ordner <code>bilder/${categoryName}/</code> befinden sich aktuell noch keine Bilder.<br>Kopiere einfach Fotos in diesen Ordner oder wähle eine aktive Kategorie mit Bildern:`;
    }

    const btnContainer = document.getElementById('empty-category-buttons');
    if (btnContainer) {
      btnContainer.innerHTML = '';
      const catIcons = {
        'Familie': '👨‍👩‍👧',
        'Spielzeuge': '🧸',
        'Verschiedenes': '🌟'
      };

      const activeCats = Object.keys(this.categories).filter(c => (this.categories[c] || []).length > 0);
      activeCats.forEach(c => {
        const icon = catIcons[c] || '📁';
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'btn btn-primary btn-quick-cat';
        btn.innerHTML = `${icon} ${c} spielen`;
        btn.addEventListener('click', () => {
          this.switchCategory(c);
        });
        btnContainer.appendChild(btn);
      });
    }
  }

  /**
   * Leere Kategorie verbergen und Spielfeld reaktivieren
   */
  hideEmptyCategoryState() {
    const notice = document.getElementById('empty-category-notice');
    if (notice) notice.style.display = 'none';

    if (this.boardSvg) this.boardSvg.style.display = 'block';
    if (this.boardImg) this.boardImg.style.display = 'block';

    if (this.btnStart) this.btnStart.disabled = false;
    if (this.btnStep) this.btnStep.disabled = false;
    if (this.btnReveal) this.btnReveal.disabled = false;
  }

  // Manuelles Laden eigener Bilder über Datei-Auswahl
  handleCustomFolderUpload(fileList) {
    if (!fileList || fileList.length === 0) return;

    const newImages = [];
    for (let i = 0; i < fileList.length; i++) {
      const file = fileList[i];
      if (file.type.startsWith('image/') || /\.(jpg|jpeg|png|webp|gif|svg)$/i.test(file.name)) {
        const url = URL.createObjectURL(file);
        let cleanName = file.name.replace(/\.[^/.]+$/, '');
        cleanName = cleanName.replace(/^\d+[\s_-]*/, '');
        newImages.push({
          name: cleanName,
          file: url,
          category: 'Eigene Auswahl',
          isBlob: true
        });
      }
    }

    if (newImages.length > 0) {
      this.categories['Eigene Auswahl'] = newImages;
      this.populateCategorySelect('Eigene Auswahl');
      this.switchCategory('Eigene Auswahl');
      this.closeSettingsModal();
      this.showToast(`${newImages.length} eigene Bilder erfolgreich importiert!`);
    } else {
      alert('Keine gültigen Bilddateien in der Auswahl gefunden.');
    }
  }

  // Runde vorbereiten
  setupRound(index) {
    if (this.revealInterval) {
      clearInterval(this.revealInterval);
      this.revealInterval = null;
    }

    this.isPlaying = false;
    this.isRoundOver = false;
    this.uncoveredTiles = 0;

    this.btnStart.textContent = '▶ Start';
    this.btnStart.classList.remove('btn-danger', 'btn-secondary');
    this.btnStart.classList.add('btn-primary');
    this.btnNext.style.display = 'none';
    this.solutionBanner.classList.remove('show');
    this.updateProgressBar();

    if (!this.images || this.images.length === 0) {
      this.showEmptyCategoryState(this.currentCategory);
      return;
    }

    if (index >= this.images.length) {
      this.showGameOverModal();
      return;
    }

    this.currentImageIndex = index;
    const item = this.images[this.currentImageIndex];
    this.currentTerm = item.name;

    // Bildquelle setzen: unterstützt Blob, relative Pfade mit Kategorie
    let src = '';
    if (item.isBlob) {
      src = item.file;
    } else if (item.file && (item.file.startsWith('http://') || item.file.startsWith('https://'))) {
      src = item.file;
    } else {
      let filePath = item.file || (item.name + '.jpg');
      if (!filePath.startsWith('bilder/')) {
        if (!filePath.includes('/')) {
          const cat = item.category || this.currentCategory || '';
          filePath = cat ? `${cat}/${filePath}` : filePath;
        }
        src = `bilder/${encodeURI(filePath)}`;
      } else {
        src = encodeURI(filePath);
      }
    }

    this.boardImg.onerror = () => {
      console.warn(`Bild konnte nicht geladen werden: ${src}`);
    };
    this.boardImg.src = src;
    this.solutionWord.textContent = item.name;
    this.roundDisplay.textContent = this.roundCount;

    // Mosaik / Ausschnitte aufbauen
    this.buildTiles();
    this.updatePlayerScoreDisplays();
  }

  /**
   * Mosaik / Ausschnitte aufbauen
   * Erzeugt unregelmäßige, nicht-quadratische Ausschnitte mit leicht unterschiedlicher Größe!
   */
  buildTiles() {
    this.tilesLayer.innerHTML = '';
    this.tileOrder = [];
    this.uncoveredTiles = 0;

    // Dichte & Kachelanzahl bestimmen
    let cols = 7, rows = 6;
    if (this.tileDensity === 'xsmall') { cols = 8; rows = 7; }      // 56 Kacheln
    else if (this.tileDensity === 'small') { cols = 7; rows = 6; }   // 42 Kacheln (Standard)
    else if (this.tileDensity === 'medium') { cols = 6; rows = 5; }  // 30 Kacheln
    else if (this.tileDensity === 'large') { cols = 5; rows = 4; }   // 20 Kacheln

    this.cols = cols;
    this.rows = rows;

    let cells = [];
    if (this.shapeStyle === 'grid') {
      cells = VoronoiMosaicGenerator.generateGrid({ width: 1000, height: 750, cols, rows });
    } else if (this.shapeStyle === 'triangles') {
      cells = VoronoiMosaicGenerator.generate({ width: 1000, height: 750, cols, rows, style: 'triangles' });
    } else {
      // Standard: 'mosaic' (Unregelmäßige Vielecke & variierende Größen)
      cells = VoronoiMosaicGenerator.generate({ width: 1000, height: 750, cols, rows, style: 'mosaic' });
    }

    this.totalTiles = cells.length;

    // Farbpaletten
    const palMap = {
      rainbow: ['tileGrad0', 'tileGrad1', 'tileGrad2', 'tileGrad3', 'tileGrad4', 'tileGrad5', 'tileGrad6', 'tileGrad7', 'tileGrad8', 'tileGrad9'],
      ocean: ['tileGrad0', 'tileGrad3', 'tileGrad6', 'tileGrad8'],
      sunset: ['tileGrad1', 'tileGrad2', 'tileGrad5', 'tileGrad7'],
      classic: ['tileGrad0', 'tileGrad8']
    };
    const palette = palMap[this.tileColorTheme] || palMap.rainbow;

    const badgeRadius = this.totalTiles > 48 ? 12 : (this.totalTiles > 30 ? 14 : 16);
    const fontSize = this.totalTiles > 48 ? 11 : (this.totalTiles > 30 ? 12 : 14);

    cells.forEach((cell, idx) => {
      const g = document.createElementNS('http://www.w3.org/2000/svg', 'g');
      g.setAttribute('class', 'mosaic-tile');
      g.dataset.index = idx;

      // Polygon für den unregelmäßigen Ausschnitt
      const poly = document.createElementNS('http://www.w3.org/2000/svg', 'polygon');
      const pts = cell.points.map(p => `${Math.round(p.x * 10) / 10},${Math.round(p.y * 10) / 10}`).join(' ');
      poly.setAttribute('points', pts);
      const gradId = palette[idx % palette.length];
      poly.setAttribute('fill', `url(#${gradId})`);
      poly.setAttribute('class', 'tile-shape');
      g.appendChild(poly);

      // Nummernbadge im geometrischen Schwerpunkt des Ausschnitts
      const cx = Math.round(cell.cx);
      const cy = Math.round(cell.cy);

      const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
      circle.setAttribute('class', 'tile-badge');
      circle.setAttribute('cx', cx);
      circle.setAttribute('cy', cy);
      circle.setAttribute('r', badgeRadius);
      circle.setAttribute('fill', 'rgba(15, 23, 42, 0.55)');
      circle.setAttribute('stroke', '#ffffff');
      circle.setAttribute('stroke-width', '1.5');
      g.appendChild(circle);

      const text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
      text.setAttribute('class', 'tile-number');
      text.setAttribute('x', cx);
      text.setAttribute('y', cy);
      text.setAttribute('text-anchor', 'middle');
      text.setAttribute('dominant-baseline', 'central');
      text.setAttribute('font-size', fontSize);
      text.textContent = idx + 1;
      g.appendChild(text);

      // Klick auf Ausschnitt deckt ihn sofort auf
      g.addEventListener('click', () => {
        if (!this.isBuzzed && !g.classList.contains('revealed')) {
          this.revealTile(g);
        }
      });

      this.tilesLayer.appendChild(g);
      this.tileOrder.push(g);
    });

    // Zufällige Reihenfolge für das automatische Aufdecken
    this.shuffleArray(this.tileOrder);
    this.updateProgressBar();
  }

  // Runde starten / fortsetzen
  startRound() {
    if (this.isRoundOver) {
      this.nextRound();
      return;
    }

    this.sounds.init();
    this.isPlaying = true;
    this.btnStart.textContent = '⏸ Pause';
    this.btnStart.classList.remove('btn-primary');
    this.btnStart.classList.add('btn-secondary');

    const intervalMs = this.speeds[this.currentSpeed];
    if (intervalMs > 0) {
      if (this.revealInterval) clearInterval(this.revealInterval);
      this.revealInterval = setInterval(() => {
        const remaining = this.tileOrder.filter(t => !t.classList.contains('revealed'));
        if (remaining.length > 0) {
          this.revealTile(remaining[0]);
        } else {
          // Alle Kacheln aufgedeckt!
          this.revealAll(null, false);
        }
      }, intervalMs);
    }
  }

  // Runde pausieren
  pauseRound() {
    this.isPlaying = false;
    if (this.revealInterval) {
      clearInterval(this.revealInterval);
      this.revealInterval = null;
    }
    this.btnStart.textContent = '▶ Weiter';
    this.btnStart.classList.remove('btn-secondary');
    this.btnStart.classList.add('btn-primary');
  }

  // Einzelnen Ausschnitt aufdecken
  revealTile(tile) {
    if (!tile || tile.classList.contains('revealed')) return;

    tile.classList.add('revealed');
    this.uncoveredTiles++;
    this.sounds.playTileClick();
    this.updateProgressBar();

    if (this.uncoveredTiles >= this.totalTiles) {
      this.revealAll(null, false);
    }
  }

  // Nächster Ausschnitt (für Einzelschritt-Modus)
  revealNextTile() {
    const remaining = this.tileOrder.filter(t => !t.classList.contains('revealed'));
    if (remaining.length > 0) {
      this.revealTile(remaining[0]);
    }
  }

  // Fortschrittsbalken aktualisieren
  updateProgressBar() {
    const percent = Math.min(100, Math.round((this.uncoveredTiles / this.totalTiles) * 100));
    this.progressBar.style.width = `${percent}%`;
  }

  // Punkt an Spieler vergeben (Daumen-hoch Button gedrückt: +3 Punkte)
  awardPoint(playerIdx) {
    const player = this.players[playerIdx];
    if (!player) return;

    player.score += 3;
    this.updatePlayerScoreDisplays();

    // Sound & Konfetti
    this.sounds.playCorrect();
    this.confetti.burst(90);

    // Button Animations-Feedback
    const btn = playerIdx === 0 ? this.btnThumb1 : this.btnThumb2;
    if (btn) {
      btn.classList.add('pulse-win');
      setTimeout(() => btn.classList.remove('pulse-win'), 550);
    }

    this.showToast(`🎉 +3 Punkte für ${this.escapeHtml(player.name)}! (Gesamt: ${player.score} Pkt)`);

    // Sprachausgabe
    this.speakSolution(`Richtig, ${player.name}! Das ist ein ${this.currentTerm}`);

    // Bild komplett aufdecken & Lösung anzeigen
    this.revealAll(player, true);
  }

  // Punkt abziehen bei falscher Antwort (Daumen-runter Button: -1 Punkt)
  penalizePlayer(playerIdx) {
    const player = this.players[playerIdx];
    if (!player) return;

    player.score -= 1;
    this.updatePlayerScoreDisplays();

    // Sound & Schüttel-Animation
    this.sounds.playWrong();
    const btnDown = playerIdx === 0 ? this.btnThumbDown1 : this.btnThumbDown2;
    if (btnDown) {
      btnDown.classList.add('pulse-wrong');
      setTimeout(() => btnDown.classList.remove('pulse-wrong'), 500);
    }

    this.showToast(`❌ -1 Punkt für ${this.escapeHtml(player.name)}! (Gesamt: ${player.score} Pkt)`);
  }

  // Punkt abziehen (über Minus-Button oder Daumen-runter)
  decrementPoint(playerIdx) {
    this.penalizePlayer(playerIdx);
  }

  // Punktestand auf 0 zurücksetzen
  resetScores() {
    this.players[0].score = 0;
    this.players[1].score = 0;
    this.updatePlayerScoreDisplays();
    this.showToast('🔄 Punktestand zurückgesetzt (0 : 0)');
  }

  // Punktestand & Namen im Spielfeld aktualisieren
  updatePlayerScoreDisplays() {
    if (this.player1Score) {
      this.player1Score.textContent = `${this.players[0].score} Pkt`;
    }
    if (this.player2Score) {
      this.player2Score.textContent = `${this.players[1].score} Pkt`;
    }
    if (this.sidebarRoundNum) {
      this.sidebarRoundNum.textContent = this.roundCount;
    }
    if (this.player1NameInput && this.player1NameInput !== document.activeElement) {
      this.player1NameInput.value = this.players[0].name;
    }
    if (this.player2NameInput && this.player2NameInput !== document.activeElement) {
      this.player2NameInput.value = this.players[1].name;
    }
  }

  renderPlayers() {
    this.updatePlayerScoreDisplays();
  }

  // Toleranter Begriff-Abgleich (ignoriert Artikel, Groß/Klein, Umlaute, Tippfehler)
  checkTermMatch(input, target) {
    if (!input || !target) return false;

    const normalize = (str) => {
      return (str || '')
        .toLowerCase()
        .replace(/^(der|die|das|ein|eine|einen|einem|einer)\s+/i, '')
        .replace(/ä/g, 'ae')
        .replace(/ö/g, 'oe')
        .replace(/ü/g, 'ue')
        .replace(/ß/g, 'ss')
        .replace(/[^a-z0-9]/g, '');
    };

    const normInput = normalize(input);
    const normTarget = normalize(target);

    // 1. Exakter Treffer
    if (normInput === normTarget) return true;

    // 2. Synonyme aus Bildobjekt prüfen
    const currentItem = this.images[this.currentImageIndex];
    if (currentItem && currentItem.alt) {
      const alts = Array.isArray(currentItem.alt) ? currentItem.alt : [currentItem.alt];
      for (const alt of alts) {
        if (normInput === normalize(alt)) return true;
      }
    }

    // 3. Zusätzliches Wörterbuch für kindgerechte Synonyme & Varianten
    const extraSynonyms = {
      'auto': ['sportwagen', 'pkw', 'wagen', 'fahrzeug', 'flitzer', 'cabrio', 'rennwagen'],
      'feuerwehr': ['feuerwehrauto', 'feuerwehrwagen', 'loeschfahrzeug', 'loeschzug', 'spritzenwagen'],
      'traktor': ['trecker', 'schlepper', 'bulldog'],
      'zug': ['lok', 'lokomotive', 'eisenbahn', 'bahn', 'gueterzug', 'personenzug', 'dampflok'],
      'flugzeug': ['flieger', 'jet', 'passagierflugzeug'],
      'schiff': ['boot', 'dampfer', 'kahn', 'kreuzfahrtschiff', 'frachter'],
      'ball': ['fussball', 'lederball', 'spielball'],
      'buch': ['buecher', 'buchstapel', 'lesebuch'],
      'uhr': ['wanduhr', 'wecker', 'armbanduhr'],
      'lampe': ['leuchte', 'stehlampe', 'schreibtischlampe'],
      'brille': ['sonnenbrille', 'sehbrille'],
      'karotte': ['moehre', 'moehren', 'karotten', 'ruebe'],
      'hase': ['kaninchen', 'feldhase', 'bunny'],
      'katze': ['kater', 'kaetzchen', 'mieze', 'miezekatze'],
      'hund': ['welpe', 'huendchen', 'wauwau', 'doggy'],
      'kuh': ['rind', 'milchkuh', 'rinder'],
      'pferd': ['pony', 'hengst', 'stute', 'gaul', 'fohlen'],
      'schaf': ['schafe', 'lamm', 'widder'],
      'schwein': ['ferkel', 'sau', 'eber'],
      'baer': ['braunbaer', 'eisbaer'],
      'loewe': ['raubkatze'],
      'kaenguru': ['kangooroo'],
      'marienkaefer': ['glueckskaefer', 'kaefer'],
      'teddybaer': ['teddy', 'plueschbaer', 'kuschelbaer', 'stofftier'],
      'heissluftballon': ['ballon', 'luftballon'],
      'blume': ['sonnenblume', 'bluete', 'blumen'],
      'baum': ['eiche', 'laubbaum', 'nadelbaum'],
      'schneemann': ['schneemaenner'],
      'pilz': ['fliegenpilz', 'pilze', 'steinpilz']
    };

    if (extraSynonyms[normTarget]) {
      for (const syn of extraSynonyms[normTarget]) {
        if (normInput === normalize(syn)) return true;
      }
    }

    // 4. Levenshtein-Toleranz (1 Buchstabe Vertipper ab 5 Buchstaben)
    if (normInput.length >= 5 && normTarget.length >= 5) {
      if (this.levenshtein(normInput, normTarget) <= 1) return true;
    }

    return false;
  }

  // Levenshtein-Distanz für kinderfreundliche Schreibfehler-Toleranz
  levenshtein(a, b) {
    if (Math.abs(a.length - b.length) > 1) return 99;
    const d = [];
    for (let i = 0; i <= a.length; i++) d[i] = [i];
    for (let j = 0; j <= b.length; j++) d[0][j] = j;
    for (let i = 1; i <= a.length; i++) {
      for (let j = 1; j <= b.length; j++) {
        const cost = a[i - 1] === b[j - 1] ? 0 : 1;
        d[i][j] = Math.min(
          d[i - 1][j] + 1,
          d[i][j - 1] + 1,
          d[i - 1][j - 1] + cost
        );
      }
    }
    return d[a.length][b.length];
  }

  // Alle Ausschnitte aufdecken & Lösung anzeigen
  revealAll(winnerPlayer = null, wasGuessed = true) {
    this.pauseRound();
    this.isRoundOver = true;

    // Alle Ausschnitte in einer schicken Welle aufdecken
    const tiles = this.tilesLayer.querySelectorAll('.mosaic-tile:not(.revealed)');
    tiles.forEach((t, i) => {
      setTimeout(() => {
        t.classList.add('revealed');
      }, i * 16);
    });

    this.uncoveredTiles = this.totalTiles;
    this.updateProgressBar();

    // Lösung anzeigen
    this.solutionBanner.classList.add('show');
    this.btnStart.textContent = '✔ Gelöst';
    this.btnStart.classList.remove('btn-secondary');
    this.btnStart.classList.add('btn-primary');
    this.btnNext.style.display = 'inline-flex';

    if (!wasGuessed) {
      this.speakSolution(`Das Bild zeigt: ${this.currentTerm}`);
    }

    this.updatePlayerScoreDisplays();
  }

  // Sprachausgabe (TTS für Kinder)
  speakSolution(text) {
    if (!this.speechEnabled || !('speechSynthesis' in window)) return;
    try {
      window.speechSynthesis.cancel();
      const utter = new SpeechSynthesisUtterance(text);
      utter.lang = 'de-DE';
      utter.rate = 0.95;
      utter.pitch = 1.05;
      window.speechSynthesis.speak(utter);
    } catch (e) {
      console.warn('Sprachausgabe nicht verfügbar:', e);
    }
  }

  // Nächste Runde
  nextRound() {
    this.roundCount++;
    this.setupRound(this.currentImageIndex + 1);
  }

  // Einstellungen Modal
  openSettingsModal() {
    const modal = document.getElementById('settings-modal');
    if (this.shapeStyleSelect) this.shapeStyleSelect.value = this.shapeStyle;
    if (this.tileDensitySelect) this.tileDensitySelect.value = this.tileDensity;
    if (this.tileColorSelect) this.tileColorSelect.value = this.tileColorTheme;
    const speechToggle = document.getElementById('speech-toggle-input');
    if (speechToggle) speechToggle.checked = this.speechEnabled;

    modal.classList.add('open');
  }

  closeSettingsModal() {
    document.getElementById('settings-modal').classList.remove('open');
  }

  saveSettings() {
    // Memorbild-Mosaik Einstellungen
    if (this.shapeStyleSelect) this.shapeStyle = this.shapeStyleSelect.value;
    if (this.tileDensitySelect) this.tileDensity = this.tileDensitySelect.value;
    if (this.tileColorSelect) this.tileColorTheme = this.tileColorSelect.value;
    const speechToggle = document.getElementById('speech-toggle-input');
    if (speechToggle) this.speechEnabled = speechToggle.checked;

    // Kategorie-Wechsel über Modal prüfen
    if (this.modalCategorySelect && this.modalCategorySelect.value !== this.currentCategory) {
      this.switchCategory(this.modalCategorySelect.value);
    }

    this.closeSettingsModal();
    if (this.images && this.images.length > 0) {
      this.buildTiles();
    }
    this.showToast('Einstellungen gespeichert!');
  }

  showGameOverModal() {
    this.sounds.playVictory();
    this.confetti.burst(150);

    // Sortiere Spieler nach Punkten
    const sorted = [...this.players].sort((a, b) => b.score - a.score);
    const winner = sorted[0];

    const modal = document.getElementById('gameover-modal');
    const content = document.getElementById('gameover-content');

    let podiumHtml = `
      <div style="text-align: center; margin-bottom: 20px;">
        <div style="font-size: 3.5rem;">🏆</div>
        <h2 style="color: #fbbf24; font-size: 1.8rem; margin: 8px 0;">Glückwunsch!</h2>
        <p style="font-size: 1.2rem; color: white;"><strong>${winner.name}</strong> gewinnt mit <strong>${winner.score}</strong> Punkten!</p>
      </div>
      <div style="display: flex; flex-direction: column; gap: 8px; margin-bottom: 20px;">
    `;

    sorted.forEach((p, idx) => {
      const medal = idx === 0 ? '🥇' : (idx === 1 ? '🥈' : (idx === 2 ? '🥉' : '🎖'));
      podiumHtml += `
        <div style="display: flex; justify-content: space-between; align-items: center; background: rgba(255,255,255,0.08); padding: 10px 16px; border-radius: 8px;">
          <div style="display: flex; align-items: center; gap: 10px;">
            <span>${medal}</span>
            <span style="font-size: 1.2rem;">${p.avatar}</span>
            <span style="font-weight: 700; color: white;">${this.escapeHtml(p.name)}</span>
          </div>
          <span style="font-weight: 900; font-size: 1.2rem; color: #fbbf24;">${p.score} Pkt</span>
        </div>
      `;
    });

    podiumHtml += '</div>';
    content.innerHTML = podiumHtml;
    modal.classList.add('open');
  }

  showToast(msg) {
    if (!this.toastEl) return;
    this.toastEl.textContent = msg;
    this.toastEl.classList.add('show');
    clearTimeout(this.toastTimer);
    this.toastTimer = setTimeout(() => {
      this.toastEl.classList.remove('show');
    }, 2500);
  }

  shuffleArray(arr) {
    for (let i = arr.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [arr[i], arr[j]] = [arr[j], arr[i]];
    }
  }

  escapeHtml(str) {
    return (str || '')
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }
}

// Spiel starten sobald DOM geladen ist
window.addEventListener('DOMContentLoaded', () => {
  window.dalliGame = new DalliGame();
});
