class Obstacle extends Entity {
  float centerX, centerY;
  float orbitRadius; // 周回半径
  float angle;        // 現在の角度
  float angleSpeed;   // 回転速度（+で時計回り、-で反時計回り）

  Obstacle(float centerX, float centerY, float orbitRadius, float angleSpeed, float startAngle) {
    super(
      centerX + cos(startAngle) * orbitRadius,
      centerY + sin(startAngle) * orbitRadius,
      15
    );
    this.centerX = centerX;
    this.centerY = centerY;
    this.orbitRadius = orbitRadius;
    this.angleSpeed = angleSpeed;
    this.angle = startAngle;
  }

  @Override
  void update() {
    angle += angleSpeed;
    x = centerX + cos(angle) * orbitRadius;
    y = centerY + sin(angle) * orbitRadius;
  }

  @Override
  void display() {
    // ★画像を貼りたい場合はここをimage()に差し替える
    // 例）image(obstacleImage, x - r, y - r, r * 2, r * 2);
    fill(240, 200, 60);
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }
}
