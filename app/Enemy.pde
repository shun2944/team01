// =====================================================
// Enemy
// =====================================================
// levelという概念は持たず、maxHpだけを「敵の強さの実体」として保存する。
// attackはmaxHpから比例計算する(計算式は仮)。

class Enemy extends Character {

  Enemy(float x, float y, float size, int startMaxHp) {
    super(x, y, size, startMaxHp, startMaxHp / 4);
  }

  // 倒された時に呼ぶ想定(GAME画面実装時に使用)
  void levelUp() {
    maxHp += 20;
    updateStats();
  }

  // maxHpから hp, attack を再計算する
  void updateStats() {
    hp = maxHp;
    attack = maxHp / 4;
  }

  void display() {
    noStroke();
    fill(220, 60, 60);
    ellipse(x, y, size, size);
  }
}
