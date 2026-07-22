class Enemy extends Entity {
  float health;
  float maxHealth;
  PImage img;

  Enemy(float x, float y, float r, float health, PImage img ) 
{ super(x, y, r); this.health = health; this.maxHealth = health; this.img = img;}
void takeDamage(float amount) { health = max(0, health - amount); }

  @Override
  void display() {
    imageMode(CENTER);        
    image(img, x, y, r * 2, r * 2);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text("ENEMY", x, y-35);
  }
}
