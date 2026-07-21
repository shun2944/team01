class Battle {
  final int PLAYING = 0;
  final int WIN = 1;
  final int LOSE = 2;
  final float BASE_ENEMY_HEALTH = 100;
  final float ENEMY_HEALTH_PER_WIN = 20;

  Player player;
  Enemy enemy;
  ArrayList<Obstacle> obstacles;
  int state = PLAYING;
  int winCount;
  boolean saveRequested = false;

  Battle(Player player, float savedEnemyMaxHp) {
    this.player = player;
    winCount = max(0, round((savedEnemyMaxHp - BASE_ENEMY_HEALTH) / ENEMY_HEALTH_PER_WIN));
    createEnemy();
  }

  void createEnemy() {
    enemy = new Enemy(width/2, height/2, 40, getNextEnemyMaxHp());
    obstacles = new ArrayList<Obstacle>();
    obstacles.add(new Obstacle(enemy.x, enemy.y, 120, 0.015, 0));
    obstacles.add(new Obstacle(enemy.x, enemy.y, 120, 0.015, PI));
    obstacles.add(new Obstacle(enemy.x, enemy.y, 180, -0.010, HALF_PI));
    obstacles.add(new Obstacle(enemy.x, enemy.y, 180, -0.010, HALF_PI + PI));
    obstacles.add(new Obstacle(enemy.x, enemy.y, 240, 0.008, 0));
  }

  void start() {
    state = PLAYING;
    player.updateStats();
    player.lives = player.maxLives;
    player.resetPosition();
    enemy.maxHealth = getNextEnemyMaxHp();
    enemy.health = enemy.maxHealth;
  }

  void display() {
    background(30);
    if (state == PLAYING) update();

    enemy.display();
    for (Obstacle obstacle : obstacles) obstacle.display();
    player.display();
    drawUI();

    if (state == WIN) drawEndMessage("YOU WIN!", color(80, 220, 120));
    else if (state == LOSE) drawEndMessage("GAME OVER", color(220, 80, 80));
  }

  void update() {
    player.handleInput();
    player.update();
    for (Obstacle obstacle : obstacles) obstacle.update();

    for (Obstacle obstacle : obstacles) {
      if (player.checkCollision(obstacle)) {
        player.loseLife();
        player.resetPosition();
        if (player.lives <= 0) state = LOSE;
        break;
      }
    }

    if (player.checkCollision(enemy)) {
      enemy.takeDamage(player.attackPower);
      player.resetPosition();
      if (enemy.health <= 0) {
        state = WIN;
        winCount++;
        saveRequested = true;
      }
    }
  }

  int getWinCount() { return winCount; }
  float getNextEnemyMaxHp() { return BASE_ENEMY_HEALTH + winCount * ENEMY_HEALTH_PER_WIN; }
  boolean isFinished() { return state == WIN || state == LOSE; }

  void setSavedEnemyMaxHp(float savedEnemyMaxHp) {
    winCount = max(0, round((savedEnemyMaxHp - BASE_ENEMY_HEALTH) / ENEMY_HEALTH_PER_WIN));
    enemy.maxHealth = getNextEnemyMaxHp();
    enemy.health = enemy.maxHealth;
  }

  boolean consumeSaveRequest() {
    boolean result = saveRequested;
    saveRequested = false;
    return result;
  }

  void drawUI() {
    fill(255);
    textSize(18);
    textAlign(LEFT, TOP);
    text("LIFE: " + player.lives, 20, 20);
    text("Lv." + player.getLevel() + "  ATK: " + nf(player.attackPower, 0, 1), 20, 44);
    text("WIN: " + winCount, 20, 68);

    float barW = 300;
    float barH = 20;
    float bx = width/2 - barW/2;
    float by = 20;
    float ratio = constrain(enemy.health / enemy.maxHealth, 0, 1);
    noFill();
    stroke(255);
    rect(bx, by, barW, barH);
    noStroke();
    fill(220, 80, 80);
    rect(bx, by, barW * ratio, barH);
    fill(255);
    textAlign(CENTER, TOP);
    text("ENEMY HP", width/2, by + barH + 4);
  }

  void drawEndMessage(String message, color messageColor) {
    fill(0, 180);
    rect(0, 0, width, height);
    fill(messageColor);
    textSize(48);
    textAlign(CENTER, CENTER);
    text(message, width/2, height/2 - 20);
    fill(255);
    textSize(18);
    text("press [R] to restart", width/2, height/2 + 30);
  }
}
