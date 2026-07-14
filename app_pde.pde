// ===== 画面の状態 =====
final int HOME  = 0;
final int INPUT = 1;
final int GAME  = 2;

int gameState = HOME; // 起動時はホーム画面から

Player player;
Enemy enemy;

void setup() {
  size(600, 400);
  player = new Player(300, 350, 30, 100, 10);
  enemy  = new Enemy(300, 100, 30, 1);
}

void draw() {
  background(255);

  if (gameState == HOME) {
    drawHome();
  } else if (gameState == INPUT) {
    drawInput();
  } else if (gameState == GAME) {
    drawGame();
  }
}

void drawHome() {
  textAlign(CENTER, CENTER);
  text("タップしてスタート", width/2, height/2);
}

void drawInput() {
  textAlign(CENTER, CENTER);
  text("筋トレの記録を入力", width/2, height/2);
  // ここに入力欄のUIを後で追加
}

void drawGame() {
  player.move(mouseX, mouseY);

  if (player.hit(enemy)) {
    enemy.hp -= player.attack;
    player.reset();
  }

  player.display();
  enemy.display();
}

// ===== 画面遷移のきっかけ(クリックなど) =====
void mousePressed() {
  if (gameState == HOME) {
    gameState = INPUT;
  } else if (gameState == INPUT) {
    gameState = GAME;
  }
}
