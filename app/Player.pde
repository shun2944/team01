// =====================================================
// GameObject / Character / Player
// =====================================================
// 画像が未確定なので、displayは今のところ ellipse のプレースホルダー。
// 後で PImage を使う形に差し替える想定(imgフィールドはコメントアウトで用意だけしておく)。

class GameObject {
  float x, y, size;
  // PImage img; // 画像を使う場合はここに追加

  GameObject(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  boolean hit(GameObject other) {
    float d = dist(x, y, other.x, other.y);
    return d < (this.size/2 + other.size/2);
  }
}

class Character extends GameObject {
  int hp, maxHp, attack;

  Character(float x, float y, float size, int maxHp, int attack) {
    super(x, y, size);
    this.maxHp = maxHp;
    this.hp = maxHp;
    this.attack = attack;
  }

  boolean isDead() {
    return hp <= 0;
  }
}

class Player extends Character {
  float exp;
  int defeatedCount = 0;
  float startX, startY;

  Player(float x, float y, float size, float startExp) {
    // hp, attack はexpから計算するので、いったん仮の値でsuper()を呼ぶ
    super(x, y, size, 100, 10);
    exp = startExp;
    startX = x;
    startY = y;
    updateStats();
  }

  void move(float mx, float my) {
    x = mx;
    y = my;
  }

  void reset() {
    x = startX;
    y = startY;
  }

  void add(float gainedExp) {
    exp += gainedExp;
    updateStats();
  }

  // expから hp, maxHp, attack を再計算する(計算式は仮)
  void updateStats() {
    maxHp = int(100 + exp * 0.5);
    attack = int(10 + exp * 0.1);
    hp = maxHp;
  }

  void display() {
    // exp が大きいほど色が濃く、サイズが大きくなるプレースホルダー
    float t = constrain(exp / 500.0, 0, 1); // 0〜1に正規化(仮の上限500)
    float displaySize = size + t * 30;
    color c = lerpColor(color(150, 200, 255), color(255, 120, 60), t);

    noStroke();
    fill(c);
    ellipse(x, y, displaySize, displaySize);
  }
}
