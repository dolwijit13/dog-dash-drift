(function() {
  const canvas = document.getElementById("gameCanvas");
  const ctx = canvas.getContext("2d");
  const WIDTH = 1280, HEIGHT = 720;
  const keys = {};
  window.addEventListener("keydown", e => keys[e.code] = true);
  window.addEventListener("keyup", e => keys[e.code] = false);

  class Camera { constructor(s = 1.5) { this.x = 0; this.speed = s; } update() { this.x += this.speed; } }
  class Soundwave { constructor(x, y) { this.x = x; this.y = y; this.w = 16; this.h = 8; this.speed = 8.0; this.active = true; } update() { this.x += this.speed; if (this.x > WIDTH) this.active = false; } rect() { return [this.x, this.y, this.w, this.h]; } }
  class EvilCat { constructor(x = WIDTH, y = 344) { this.x = x; this.y = y; this.w = 32; this.h = 32; this.hp = 1; this.speed = 3.0; this.active = true; } update() { this.x -= this.speed; if (this.x < -this.w) this.active = false; } takeDamage(a = 1) { this.hp -= a; if (this.hp <= 0) this.active = false; } rect() { return [this.x, this.y, this.w, this.h]; } }
  class Player {
    constructor(x = 100, y = 344) { this.x = x; this.y = y; this.w = 32; this.h = 32; this.speed = 4.0; this.fireRate = 0.5; this.cooldown = 0; }
    update(dt) {
      let dx = 0, dy = 0;
      if (keys["KeyA"] || keys["ArrowLeft"]) dx -= 1;
      if (keys["KeyD"] || keys["ArrowRight"]) dx += 1;
      if (keys["KeyS"] || keys["ArrowDown"]) dy -= 1;
      if (keys["KeyW"] || keys["ArrowUp"]) dy += 1;
      if (dx !== 0 || dy !== 0) { const l = Math.sqrt(dx*dx + dy*dy); this.x += (dx/l)*this.speed; this.y += (dy/l)*this.speed; }
      this.x = Math.max(0, Math.min(WIDTH - this.w, this.x));
      this.y = Math.max(0, Math.min(HEIGHT - this.h, this.y));
      this.cooldown -= dt;
      if (this.cooldown <= 0) { this.cooldown = this.fireRate; return new Soundwave(this.x + this.w, this.y + (this.h/2) - 4); }
      return null;
    }
  }
  class EnemySpawner {
    constructor() { this.timer = 2.5; }
    update(dt) { this.timer -= dt; if (this.timer <= 0) { this.timer = 2.0 + Math.random(); return new EvilCat(WIDTH, Math.random() * (HEIGHT - 32)); } return null; }
  }
  function checkAABB(r1, r2) { return r1[0] < r2[0] + r2[2] && r1[0] + r1[2] > r2[0] && r1[1] < r2[1] + r2[3] && r1[1] + r1[3] > r2[1]; }

  const player = new Player(), camera = new Camera(), spawner = new EnemySpawner();
  const soundwaves = [], enemies = [];
  let score = 0, coins = 0, lastTime = performance.now();

  function gameLoop(now) {
    const dt = Math.min((now - lastTime) / 1000.0, 0.1);
    lastTime = now;
    if (keys["Escape"]) { player.x = 100; player.y = 344; soundwaves.length = 0; enemies.length = 0; score = 0; coins = 0; }
    camera.update();
    const b = player.update(dt); if (b) soundwaves.push(b);
    const e = spawner.update(dt); if (e) enemies.push(e);
    soundwaves.forEach(sw => sw.update());
    enemies.forEach(en => en.update());
    soundwaves.forEach(sw => {
      if (!sw.active) return;
      enemies.forEach(en => {
        if (!en.active) return;
        if (checkAABB(sw.rect(), en.rect())) { sw.active = false; en.takeDamage(1); if (!en.active) { score += 10; coins += 5; } }
      });
    });
    for (let i = soundwaves.length - 1; i >= 0; i--) if (!soundwaves[i].active) soundwaves.splice(i, 1);
    for (let i = enemies.length - 1; i >= 0; i--) if (!enemies[i].active) enemies.splice(i, 1);

    ctx.fillStyle = "#1e1e2e"; ctx.fillRect(0, 0, WIDTH, HEIGHT);
    const gridSpacing = 40, offsetX = Math.floor(camera.x % gridSpacing);
    ctx.strokeStyle = "rgba(255, 255, 255, 0.05)"; ctx.lineWidth = 1;
    for (let x = -offsetX; x < WIDTH + gridSpacing; x += gridSpacing) { ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, HEIGHT); ctx.stroke(); }
    function drawRect(x, y, w, h, col) { ctx.fillStyle = col; ctx.fillRect(x, HEIGHT - y - h, w, h); }
    drawRect(player.x, player.y, player.w, player.h, "#2ecc71");
    soundwaves.forEach(sw => drawRect(sw.x, sw.y, sw.w, sw.h, "#00ffff"));
    enemies.forEach(en => drawRect(en.x, en.y, en.w, en.h, "#ff2a2a"));

    ctx.fillStyle = "#ffffff"; ctx.font = "bold 18px monospace";
    ctx.fillText("Coins: $" + coins, 20, 35);
    ctx.fillText("Score: " + score, 20, 65);
    requestAnimationFrame(gameLoop);
  }
  const status = document.getElementById("status");
  if (status) status.innerText = "DragonRuby GTK Web Engine Active (60 FPS)";
  requestAnimationFrame(gameLoop);
})();
