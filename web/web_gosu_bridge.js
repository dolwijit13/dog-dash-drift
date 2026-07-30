// Web Gosu Bridge for Ruby.wasm Execution Engine
window.WebGosu = {
  canvas: null,
  ctx: null,
  keys: {},
  
  init: function() {
    this.canvas = document.getElementById('gameCanvas');
    if (this.canvas) {
      this.ctx = this.canvas.getContext('2d');
    }
    
    window.addEventListener('keydown', (e) => { this.keys[e.code] = true; });
    window.addEventListener('keyup', (e) => { this.keys[e.code] = false; });
    
    const status = document.getElementById('status');
    if (status) status.innerText = 'Ruby WebAssembly Game Engine Ready (60 FPS)';
  },
  
  isKeyDown: function(code) {
    return !!this.keys[code];
  },
  
  clear: function(color) {
    if (!this.ctx) return;
    this.ctx.fillStyle = color || '#1e1e2e';
    this.ctx.fillRect(0, 0, 800, 600);
  },
  
  drawRect: function(x, y, w, h, color) {
    if (!this.ctx) return;
    this.ctx.fillStyle = color;
    this.ctx.fillRect(x, y, w, h);
  },
  
  drawLine: function(x1, y1, x2, y2, color) {
    if (!this.ctx) return;
    this.ctx.strokeStyle = color;
    this.ctx.beginPath();
    this.ctx.moveTo(x1, y1);
    this.ctx.lineTo(x2, y2);
    this.ctx.stroke();
  },

  drawText: function(text, x, y, color, font) {
    if (!this.ctx) return;
    this.ctx.fillStyle = color || '#ffffff';
    this.ctx.font = font || 'bold 16px monospace';
    this.ctx.fillText(text, x, y);
  }
};

window.addEventListener('DOMContentLoaded', () => {
  window.WebGosu.init();
});
