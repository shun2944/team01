class Player extends Entity {
  int lives;
  int maxLives;
  float attackPower;   // 攻撃力（後から数値調整OK）
  float speed = 4;

  float startX, startY; // 衝突時に戻るスタート地点

  boolean up, down, left, right;

  Player(float x, float y, float r, int lives, float attackPower) {
    super(x, y, r);
    this.lives = lives;
    this.maxLives = lives;
    this.attackPower = attackPower;
    this.startX = x;
    this.startY = y;
  }

  void setKey(int code, boolean pressed) {
    if (code == UP) up = pressed;
    if (code == DOWN) down = pressed;
    if (code == LEFT) left = pressed;
    if (code == RIGHT) right = pressed;
  }

  void handleInput() {
    float dx = 0, dy = 0;
    if (up) dy -= 1;
    if (down) dy += 1;
    if (left) dx -= 1;
    if (right) dx += 1;

    if (dx != 0 || dy != 0) {
      float len = sqrt(dx * dx + dy * dy);
      x += (dx / len) * speed;
      y += (dy / len) * speed;
    }

    x = constrain(x, r, width - r);
    y = constrain(y, r, height - r);
  }

  @Override
  void display() {
    // ★画像を貼りたい場合はここをimage()に差し替える
  //   image(playerImage[n], x - r, y - r, r * 2, r * 2);
    fill(80, 160, 255);
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }

  void loseLife() {
    lives--;
  }

  void resetPosition() {
    x = startX;
    y = startY;
  }
}
