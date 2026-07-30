// Auto-generated Web Engine from Ruby Source Files
(function () {
  const canvas = document.getElementById('gameCanvas');
  const ctx = canvas ? canvas.getContext('2d') : null;
  const WIDTH = 800;
  const HEIGHT = 600;

  const keys = {};
  window.addEventListener('keydown', (e) => { keys[e.code] = true; });
  window.addEventListener('keyup', (e) => { keys[e.code] = false; });

  function isKeyDown(code) {
    return !!keys[code];
  }

  function getDirectionalVector() {
    let dx = 0.0, dy = 0.0;
    if (isKeyDown('KeyA') || isKeyDown('ArrowLeft')) dx -= 1.0;
    if (isKeyDown('KeyD') || isKeyDown('ArrowRight')) dx += 1.0;
    if (isKeyDown('KeyW') || isKeyDown('ArrowUp')) dy -= 1.0;
    if (isKeyDown('KeyS') || isKeyDown('ArrowDown')) dy += 1.0;
    if (dx === 0.0 && dy === 0.0) return [0.0, 0.0];
    const len = Math.sqrt(dx * dx + dy * dy);
    return [dx / len, dy / len];
  }

  class Camera {
    constructor(scrollSpeed = 1.5) {
      this.x = 0.0;
      this.scrollSpeed = scrollSpeed;
    }
    update() {
      this.x += this.scrollSpeed;
    }
  }

  class Soundwave {
    constructor(x, y, speed = 8.0) {
      this.x = x;
      this.y = y;
      this.width = 16;
      this.height = 8;
      this.speed = speed;
      this.active = true;
    }
    update() {
      this.x += this.speed;
      if (this.x > WIDTH) this.active = false;
    }
    draw(ctx) {
      ctx.fillStyle = '#00ffff';
      ctx.fillRect(this.x, this.y, this.width, this.height);
    }
    boundingBox() {
      return { x: this.x, y: this.y, width: this.width, height: this.height };
    }
  }

  class EvilCat {
    constructor(x = WIDTH, y = 284, hp = 1, speed = 3.0) {
      this.x = x;
      this.y = y;
      this.width = 32;
      this.height = 32;
      this.hp = hp;
      this.speed = speed;
      this.active = true;
    }
    update() {
      this.x -= this.speed;
      if (this.x < -this.width) this.active = false;
    }
    takeDamage(amount = 1) {
      this.hp -= amount;
      if (this.hp <= 0) this.active = false;
    }
    draw(ctx) {
      ctx.fillStyle = '#ff2a2a';
      ctx.fillRect(this.x, this.y, this.width, this.height);
    }
    boundingBox() {
      return { x: this.x, y: this.y, width: this.width, height: this.height };
    }
  }

  class Player {
    constructor(x = 100, y = 284, speed = 4.0, fireRate = 0.5) {
      this.x = x;
      this.y = y;
      this.width = 32;
      this.height = 32;
      this.speed = speed;
      this.fireRate = fireRate;
      this.cooldown = 0.0;
    }
    update(deltaTime) {
      const [dx, dy] = getDirectionalVector();
      this.x += dx * this.speed;
      this.y += dy * this.speed;
      this.x = Math.max(0, Math.min(WIDTH - this.width, this.x));
      this.y = Math.max(0, Math.min(HEIGHT - this.height, this.y));

      this.cooldown -= deltaTime;
      if (this.cooldown <= 0) {
        this.cooldown = this.fireRate;
        const spawnX = this.x + this.width;
        const spawnY = this.y + (this.height / 2) - 4;
        return new Soundwave(spawnX, spawnY);
      }
      return null;
    }
    draw(ctx) {
      ctx.fillStyle = '#2ecc71';
      ctx.fillRect(this.x, this.y, this.width, this.height);
    }
  }

  class EnemySpawner {
    constructor() {
      this.timer = 2.5;
    }
    update(deltaTime) {
      this.timer -= deltaTime;
      if (this.timer <= 0) {
        this.timer = 2.0 + Math.random() * 1.0;
        const spawnY = Math.random() * (HEIGHT - 32);
        return new EvilCat(WIDTH, spawnY);
      }
      return null;
    }
  }

  function checkAABB(r1, r2) {
    return r1.x < r2.x + r2.width &&
           r1.x + r1.width > r2.x &&
           r1.y < r2.y + r2.height &&
           r1.y + r1.height > r2.y;
  }

  const player = new Player();
  const camera = new Camera();
  const spawner = new EnemySpawner();
  const soundwaves = [];
  const enemies = [];
  let score = 0;
  let coins = 0;
  let lastTime = performance.now();

  function gameLoop(now) {
    const deltaTime = Math.min((now - lastTime) / 1000.0, 0.1);
    lastTime = now;

    if (isKeyDown('Escape')) {
      player.x = 100;
      player.y = 284;
      soundwaves.length = 0;
      enemies.length = 0;
      score = 0;
      coins = 0;
    }

    camera.update();
    const newBullet = player.update(deltaTime);
    if (newBullet) soundwaves.push(newBullet);

    const newEnemy = spawner.update(deltaTime);
    if (newEnemy) enemies.push(newEnemy);

    soundwaves.forEach(sw => sw.update());
    enemies.forEach(e => e.update());

    soundwaves.forEach(sw => {
      if (!sw.active) return;
      enemies.forEach(e => {
        if (!e.active) return;
        if (checkAABB(sw.boundingBox(), e.boundingBox())) {
          sw.active = false;
          e.takeDamage(1);
          if (!e.active) {
            score += 10;
            coins += 5;
          }
        }
      });
    });

    for (let i = soundwaves.length - 1; i >= 0; i--) {
      if (!soundwaves[i].active) soundwaves.splice(i, 1);
    }
    for (let i = enemies.length - 1; i >= 0; i--) {
      if (!enemies[i].active) enemies.splice(i, 1);
    }

    if (ctx) {
      ctx.fillStyle = '#1e1e2e';
      ctx.fillRect(0, 0, WIDTH, HEIGHT);

      const gridSpacing = 40;
      const offsetX = Math.floor(camera.x % gridSpacing);
      ctx.strokeStyle = 'rgba(255, 255, 255, 0.05)';
      ctx.lineWidth = 1;
      for (let x = -offsetX; x < WIDTH + gridSpacing; x += gridSpacing) {
        ctx.beginPath();
        ctx.moveTo(x, 0);
        ctx.lineTo(x, HEIGHT);
        ctx.stroke();
      }

      player.draw(ctx);
      soundwaves.forEach(sw => sw.draw(ctx));
      enemies.forEach(e => e.draw(ctx));

      ctx.fillStyle = '#ffffff';
      ctx.font = 'bold 16px monospace';
      ctx.fillText(`Coins: $${coins}`, 16, 30);
      ctx.fillText(`Score: ${score}`, 16, 52);
    }

    requestAnimationFrame(gameLoop);
  }

  const status = document.getElementById('status');
  if (status) status.innerText = 'Game Running (60 FPS)';

  requestAnimationFrame(gameLoop);
})();
