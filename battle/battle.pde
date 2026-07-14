// ボール1
float x1 = 200;
float y1 = 150;
float dx1 = 7;
float dy1 = 7;

// ボール2
float x2 = 100;
float y2 = 50;
float dx2 = -5;
float dy2 = 5;

// 半径
float r = 20;

// 最大HP
float maxHp = 1000;

// 現在HP
float hp1 = 800;
float maxhp1 = hp1;
float hp2 = 600;
float maxhp2 = hp2;

// 攻撃力
float at1 = 100;
float at2 = 4;

// バーの最大幅
float barWidth = 150;

// 接触判定
boolean hit = false;

// エフェクト
float effectX;
float effectY;
int hitTimer = 0;

void setup() {
  size(500, 400);
  textSize(14);
}

void draw() {
  background(255);

  // -------------------------
  // ボール移動
  // -------------------------
  if (hp1 > 0) {
    x1 += dx1;
    y1 += dy1;
  }

  if (hp2 > 0) {
    x2 += dx2;
    y2 += dy2;
  }

  // -------------------------
  // 壁で反射
  // -------------------------
  if (hp1 > 0) {
    if (x1 - r <= 0 || x1 + r >= width) dx1 = -dx1;
    if (y1 - r <= 0 || y1 + r >= height - 50) dy1 = -dy1;
  }

  if (hp2 > 0) {
    if (x2 - r <= 0 || x2 + r >= width) dx2 = -dx2;
    if (y2 - r <= 0 || y2 + r >= height - 50) dy2 = -dy2;
  }

  // -------------------------
  // 接触判定
  // -------------------------
  if (hp1 > 0 && hp2 > 0) {

    float d = dist(x1, y1, x2, y2);

    if (d <= r * 2) {

      if (!hit) {

        hp1 -= at2;
        hp2 -= at1;

        hp1 = max(hp1, 0);
        hp2 = max(hp2, 0);

        // エフェクト
        effectX = (x1 + x2) / 2;
        effectY = (y1 + y2) / 2;
        hitTimer = 10;

        hit = true;
      }

    } else {
      hit = false;
    }
  }

  // -------------------------
  // ボール描画
  // -------------------------
  if (hp1 > 0) {
    fill(255, 0, 0);
    ellipse(x1, y1, r * 2, r * 2);
  }

  if (hp2 > 0) {
    fill(0, 0, 255);
    ellipse(x2, y2, r * 2, r * 2);
  }

  // -------------------------
  // ヒットエフェクト
  // -------------------------
  if (hitTimer > 0) {

    noStroke();

    fill(255, 255, 0, 180);
    ellipse(effectX, effectY, 50, 50);

    fill(255, 150, 0, 220);
    ellipse(effectX, effectY, 30, 30);

    fill(255);
    ellipse(effectX, effectY, 10, 10);

    hitTimer--;
  }

  // -------------------------
  // Player1
  // -------------------------
  fill(0);
  textAlign(LEFT);
  text("Player1  ATK:" + (int)at1, 20, height - 35);

  stroke(0);
  noFill();
  rect(20, height - 25, barWidth, 15);

  noStroke();
  fill(0, 255, 0);
  rect(20, height - 25, hp1 / maxHp * barWidth, 15);

  fill(0);
  text((int)hp1 + " / " + (int)maxhp1, 20, height - 5);

  // -------------------------
  // Player2
  // -------------------------
  fill(0);
  text("Player2  ATK:" + (int)at2, width - 170, height - 35);

  stroke(0);
  noFill();
  rect(width - 170, height - 25, barWidth, 15);

  noStroke();
  fill(0, 255, 0);
  rect(width - 170, height - 25, hp2 / maxHp * barWidth, 15);

  fill(0);
  text((int)hp2 + " / " + (int)maxhp2, width - 170, height - 5);

  // -------------------------
  // 勝者表示
  // -------------------------
  fill(0);
  textAlign(CENTER);
  textSize(30);

  if (hp1 <= 0 && hp2 > 0) {
    text("Player2 WIN!", width / 2, 30);
  }

  if (hp2 <= 0 && hp1 > 0) {
    text("Player1 WIN!", width / 2, 30);
  }

  if (hp1 <= 0 && hp2 <= 0) {
    text("DRAW!", width / 2, 30);
  }

  textSize(14);
}
