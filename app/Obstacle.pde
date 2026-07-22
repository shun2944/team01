class Obstacle extends Entity {
  float centerX, centerY;
  float orbitRadius;
  float angle;
  float angleSpeed;
  PImage img;


  Obstacle(float centerX, float centerY, float orbitRadius, float angleSpeed, float startAngle, PImage img) {
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
    this.img = img;
  }

  @Override
  void update() {
    angle += angleSpeed;
    x = centerX + cos(angle) * orbitRadius;
    y = centerY + sin(angle) * orbitRadius;
  }

  @Override
  void display() {
    imageMode(CENTER);
    image(img, x, y, r * 2, r * 2);
  }
}
