class Player extends Entity {
  final int EXP_PER_LEVEL = 100;
  final float BASE_ATTACK = 5;
  final float ATTACK_PER_LEVEL = 3;
  int lives;
  int maxLives;
  float attackPower;
  float speed = 4;
  float startX, startY;
  boolean up, down, left, right;
  float exp = 0;
  PImage[] images;

  Player(float x, float y, float r, int lives, float attackPower) {
    super(x, y, r);
    this.lives = lives;
    this.maxLives = lives;
    this.attackPower = attackPower;
    this.startX = x;
    this.startY = y;
  }

  // 元のapp.pdeからそのまま呼べる形
  Player(float x, float y, float r, PImage image, float exp) {
    this(x, y, r, 3, 5);
    this.exp = exp;
    this.images = new PImage[5];
    this.images[0] = image;
    updateStats();
  }

  void setImages(PImage[] images) { this.images = images; }
  int getLevel() { return int(exp / EXP_PER_LEVEL) + 1; }
  void addExp(float gainedExp) { exp += gainedExp; updateStats(); }
  void updateStats() { attackPower = BASE_ATTACK + int(exp / EXP_PER_LEVEL) * ATTACK_PER_LEVEL; }

  void setKey(int code, boolean pressed) {
    if (code == UP) up = pressed;
    if (code == DOWN) down = pressed;
    if (code == LEFT) left = pressed;
    if (code == RIGHT) right = pressed;
  }

  void handleInput() {
    float dx = 0, dy = 0;
    if (up) dy--;
    if (down) dy++;
    if (left) dx--;
    if (right) dx++;
    if (dx != 0 || dy != 0) {
      float len = sqrt(dx * dx + dy * dy);
      x += dx / len * speed;
      y += dy / len * speed;
    }
    x = constrain(x, r, width - r);
    y = constrain(y, r, height - r);
  }

  @Override
  void display() {
    int imageIndex = constrain(getLevel() - 1, 0, 4);
    if (images != null && images[imageIndex] != null) image(images[imageIndex], x-r, y-r, r*2, r*2);
    else { fill(80, 160, 255); noStroke(); ellipse(x, y, r * 2, r * 2); }
  }

  void loseLife() { lives--; }
  void resetPosition() { x = startX; y = startY; }
}
