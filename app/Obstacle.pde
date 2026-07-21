class Obstacle extends Entity {
  float centerX, centerY, orbitRadius, angle, angleSpeed;

  Obstacle(float centerX, float centerY, float orbitRadius, float angleSpeed, float startAngle) {
    super(centerX + cos(startAngle) * orbitRadius, centerY + sin(startAngle) * orbitRadius, 15);
    this.centerX = centerX; this.centerY = centerY; this.orbitRadius = orbitRadius;
    this.angleSpeed = angleSpeed; this.angle = startAngle;
  }

  @Override
  void update() { angle += angleSpeed; x = centerX + cos(angle) * orbitRadius; y = centerY + sin(angle) * orbitRadius; }

  @Override
  void display() { fill(240, 200, 60); noStroke(); ellipse(x, y, r * 2, r * 2); }
}
