// Auto-Generated Web Engine (Dynamic Ruby AST Transpilation)
// Generated automatically from /lib/*.rb source files
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

  function checkAABB(r1, r2) {
    if (!r1 || !r2) return false;
    const b1 = r1.boundingBox ? r1.boundingBox() : r1;
    const b2 = r2.boundingBox ? r2.boundingBox() : r2;
    return b1.x < b2.x + b2.width &&
           b1.x + b1.width > b2.x &&
           b1.y < b2.y + b2.height &&
           b1.y + b1.height > b2.y;
  }


// Transpiled from camera.rb

class Camera {
  attr_accessor :x, :y, :scroll_speed

  constructor(scroll_speed = 1.5) {
    this.x = 0.0
    this.y = 0.0
    this.scroll_speed = scroll_speed.to_f
  }

  update() {
    this.x += this.scroll_speed
  }
}


// Transpiled from collision_system.rb

class CollisionSystem {
  self() {
    return false unless rect1 && rect2

    rect1[:x] < rect2[:x] + rect2[:width] &&
      rect1[:x] + rect1[:width] > rect2[:x] &&
      rect1[:y] < rect2[:y] + rect2[:height] &&
      rect1[:y] + rect1[:height] > rect2[:y]
  }

  self() {
    results = { kills: 0, score: 0, coins: 0 }

    soundwaves.each do |sw|
      next unless sw.active?

      sw_box = { x: sw.x, y: sw.y, width: Soundwave::WIDTH, height: Soundwave::HEIGHT }

      enemies.each do |enemy|
        next unless enemy.active?

        if check_aabb(sw_box, enemy.bounding_box)
          sw.deactivate!
          enemy.take_damage(1)

          if enemy.hp <= 0
            results[:kills] += 1
            results[:score] += 10
            results[:coins] += 5
          }

          break
        }
      }
    }

    results
  }
}


// Transpiled from enemy.rb

class EvilCat {
  static WIDTH = 32;
  static HEIGHT = 32;
  static SPEED = 3.0;

  attr_accessor :x, :y, :hp, :speed, :active

  constructor(x = 800, y = 284, hp = 1, speed = SPEED) {
    this.x = x.to_f
    this.y = y.to_f
    this.hp = hp
    this.speed = speed.to_f
    this.active = true
  }

  update() {
    this.x -= this.speed
  }

  out_of_bounds_qmark() {
    this.x < -WIDTH
  }

  active_qmark() {
    this.active && !out_of_bounds_qmark() && this.hp > 0
  }

  take_damage(amount = 1) {
    this.hp -= amount
    this.active = false if this.hp <= 0
  }

  bounding_box() {
    { x: this.x, y: this.y, width: WIDTH, height: HEIGHT }
  }

  draw() {
    Gosu.draw_rect(this.x, this.y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  }
}


// Transpiled from enemy_spawner.rb

class EnemySpawner {
  attr_accessor :spawn_timer, :min_interval, :max_interval

  constructor(min_interval = 2.0, max_interval = 3.0) {
    this.min_interval = min_interval.to_f
    this.max_interval = max_interval.to_f
    this.spawn_timer = rand(this.min_interval..this.max_interval)
  }

  update(delta_time = 1.0 / 60.0, boundary_width = 800, boundary_height = 600) {
    this.spawn_timer -= delta_time

    if this.spawn_timer <= 0
      reset_timer
      spawn_y = rand(0..(boundary_height - EvilCat::HEIGHT)).to_f
      EvilCat.new(boundary_width, spawn_y)
    else
      null
    }
  }

  reset_timer() {
    this.spawn_timer = rand(this.min_interval..this.max_interval)
  }
}


// Transpiled from input_handler.rb

class InputHandler {
  self() {
    return [0.0, 0.0] unless window

    dx = 0.0
    dy = 0.0

    if defined?(Gosu) && window.respond_to?(:button_down?)
      dx -= 1.0 if window.button_down?(Gosu::KB_A) || window.button_down?(Gosu::KB_LEFT)
      dx += 1.0 if window.button_down?(Gosu::KB_D) || window.button_down?(Gosu::KB_RIGHT)
      dy -= 1.0 if window.button_down?(Gosu::KB_W) || window.button_down?(Gosu::KB_UP)
      dy += 1.0 if window.button_down?(Gosu::KB_S) || window.button_down?(Gosu::KB_DOWN)
    }

    normalize(dx, dy)
  }

  self() {
    return [0.0, 0.0] if dx == 0.0 && dy == 0.0

    length = Math.sqrt(dx * dx + dy * dy)
    [dx / length, dy / length]
  }
}


// Transpiled from player.rb

class Player {
  static WIDTH = 32;
  static HEIGHT = 32;
  static FIRE_RATE = 0.5;

  attr_accessor :x, :y, :speed, :cooldown, :fire_rate

  constructor(x = 100, y = 284, speed = 4.0, fire_rate = FIRE_RATE) {
    this.x = x.to_f
    this.y = y.to_f
    this.speed = speed.to_f
    this.fire_rate = fire_rate.to_f
    this.cooldown = 0.0
  }

  update(window = null, boundary_width = 800, boundary_height = 600, delta_time = 1.0 / 60.0) {
    if window
      dx, dy = InputHandler.directional_vector(window)
      this.x += dx * this.speed
      this.y += dy * this.speed
    }

    clamp_position(boundary_width, boundary_height)
    update_auto_attack(delta_time)
  }

  update_auto_attack(delta_time = 1.0 / 60.0) {
    this.cooldown -= delta_time if this.cooldown > 0

    if can_shoot_qmark()
      shoot
    else
      null
    }
  }

  can_shoot_qmark() {
    this.cooldown <= 0
  }

  shoot() {
    return null unless can_shoot_qmark()

    this.cooldown = this.fire_rate
    spawn_x = this.x + WIDTH
    spawn_y = this.y + (HEIGHT / 2.0) - (Soundwave::HEIGHT / 2.0)
    Soundwave.new(spawn_x, spawn_y)
  }

  move_by(dx, dy, boundary_width = 800, boundary_height = 600) {
    norm_dx, norm_dy = InputHandler.normalize(dx, dy)
    this.x += norm_dx * this.speed
    this.y += norm_dy * this.speed
    clamp_position(boundary_width, boundary_height)
  }

  clamp_position(boundary_width = 800, boundary_height = 600) {
    max_x = boundary_width - WIDTH
    max_y = boundary_height - HEIGHT

    this.x = this.x.clamp(0.0, max_x.to_f)
    this.y = this.y.clamp(0.0, max_y.to_f)
  }

  draw() {
    Gosu.draw_rect(this.x, this.y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  }
}


// Transpiled from soundwave.rb

class Soundwave {
  static WIDTH = 16;
  static HEIGHT = 8;
  static SPEED = 8.0;

  attr_accessor :x, :y, :speed, :active

  constructor(x, y, speed = SPEED) {
    this.x = x.to_f
    this.y = y.to_f
    this.speed = speed.to_f
    this.active = true
  }

  update() {
    this.x += this.speed
  }

  out_of_bounds_qmark(boundary_width = 800) {
    this.x > boundary_width
  }

  active_qmark() {
    this.active && !out_of_bounds_qmark()
  }

  deactivate_bang() {
    this.active = false
  }

  draw() {
    Gosu.draw_rect(this.x, this.y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  }
}

  // Runtime Game Engine Loop
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
