class Enemy extends Entity {
  float health;
  float maxHealth; // 最大体力（後から数値調整OK）

  Enemy(float x, float y, float r, float health) {
    super(x, y, r);
    this.health = health;
    this.maxHealth = health;
  }

  void takeDamage(float amount) {
    health -= amount;
    if (health < 0) health = 0;
  }

  @Override
  void display() {
    // ★画像を貼りたい場合はここをimage()に差し替える
    //image(enemyImage, x - r, y - r, r * 2, r * 2);
    fill(220, 90, 90);
    noStroke();
    ellipse(x, y, r * 2, r * 2);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text("ENEMY", x, y);
  }
}
