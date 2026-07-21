class Entity {
  float x, y;
  float r;
  Entity(float x, float y, float r) { this.x = x; this.y = y; this.r = r; }
  void update() { }
  void display() { fill(200); noStroke(); ellipse(x, y, r * 2, r * 2); }
  boolean checkCollision(Entity other) { return dist(x, y, other.x, other.y) < this.r + other.r; }
}
