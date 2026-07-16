class Entity {
  float x, y;   // 座標
  float r;      // 当たり判定用の半径

  Entity(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  // 更新処理（必要な子クラスでオーバーライド）
  void update() {
    // 基本は何もしない
  }

  // 描画処理（子クラスでオーバーライドして見た目を変える）
  void display() {
    // ★画像を貼りたい場合はここをimage()に差し替える
    // 例）image(myImage, x - r, y - r, r * 2, r * 2);
    fill(200);
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }

  // 円同士の当たり判定
  boolean checkCollision(Entity other) {
    float d = dist(x, y, other.x, other.y);
    return d < (this.r + other.r);
  }
}
