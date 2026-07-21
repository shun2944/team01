class Enemy extends Entity {
  float health;
  float maxHealth;

  Enemy(float x, float y, float r, float health) { super(x, y, r); this.health = health; this.maxHealth = health; }
  void takeDamage(float amount) { health = max(0, health - amount); }

  @Override
  void display() {
    fill(220, 90, 90); noStroke(); ellipse(x, y, r * 2, r * 2);
    fill(255); textAlign(CENTER, CENTER); textSize(12); text("ENEMY", x, y);
  }
}
