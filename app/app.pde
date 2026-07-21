// ----- 画面状態 -----
final int HOME  = 0;
final int INPUT = 1;
final int GAME  = 2;
int gameState = HOME;
// ----- オブジェクト -----
Player player;
Enemy enemy;
Battle battle;
Input inputScreen;
// ----- Home画面のボタン領域 -----
float btnInputX, btnInputY, btnInputW = 220, btnInputH = 50;
float btnGameX, btnGameY, btnGameW = 220, btnGameH = 50;
// プレイヤーの画像
PImage[] playerImages;
void setup() {
  size(600, 500);
  textAlign(CENTER, CENTER);
  playerImages = new PImage[5];
  playerImages[0] = loadImage("level1.png");
  playerImages[1] = loadImage("level2.png");
  playerImages[2] = loadImage("level3.png");
  playerImages[3] = loadImage("level4.png");
  playerImages[4] = loadImage("level5.png");
  // Playerのコンストラクタ名を、元のapp.pdeに合わせている
  player = new Player(width/2, height - 150, 15, playerImages[0], 0);
  player.setImages(playerImages);
  battle = new Battle(player, 100);
  enemy = battle.enemy;
  inputScreen = new Input();
  btnInputX = width/2 - btnInputW/2;
  btnInputY = 330;
  btnGameX = width/2 - btnGameW/2;
  btnGameY = 400;
  load();
}
void draw() {
  background(245);
  if (gameState == HOME) {
    drawHome();
  } else if (gameState == INPUT) {
    drawInput();
  } else if (gameState == GAME) {
    drawGame();
  }
}
// =====================================================
// Home画面
// =====================================================
void drawHome() {
  fill(30);
  textSize(24);
  text("grow up game", width/2, 50);
  player.display();
  fill(30);
  textSize(16);
  text("EXP: " + nf(player.exp, 0, 1), width/2, 200);
  text("HP: " + player.lives + " / " + player.maxLives, width/2, 225);
  text("ATK: " + player.attackPower, width/2, 250);
  text("TIME: " + battle.getWinCount(), width/2, 275);
  drawButton(btnInputX, btnInputY, btnInputW, btnInputH, "grow up");
  drawButton(btnGameX, btnGameY, btnGameW, btnGameH, "game");
}
void drawButton(float x, float y, float w, float h, String label) {
  fill(220);
  stroke(30);
  rect(x, y, w, h, 8);
  fill(30);
  noStroke();
  textSize(16);
  text(label, x + w/2, y + h/2);
}
// =====================================================
// Input / Game
// =====================================================
void drawInput() {
  inputScreen.display();
  // Inputからは計算済みEXPだけを受け取る
  float gainedExp = inputScreen.consumeExp();
  if (gainedExp > 0) {
    player.addExp(gainedExp);
    save();
  }
  drawButton(width/2 - 100, height/2 + 130, 200, 44, "Home");
}
void drawGame() {
  battle.display();
  if (battle.consumeSaveRequest()) save();
  drawButton(width/2 - 100, height/2 + 130, 200, 44, "Home");
}
void add(float gainedExp) {
  player.addExp(gainedExp);
}
void updateImage() {
  // 画像の切り替えはPlayer.display()内でレベルに応じて行う
}
// =====================================================
// クリック処理(画面遷移)
// =====================================================
void mousePressed() {
  if (gameState == HOME) {
    if (isInside(mouseX, mouseY, btnInputX, btnInputY, btnInputW, btnInputH)) {
      gameState = INPUT;
    } else if (isInside(mouseX, mouseY, btnGameX, btnGameY, btnGameW, btnGameH)) {
      battle.start();
      gameState = GAME;
    }
  } else if (gameState == INPUT || gameState == GAME) {
    if (isInside(mouseX, mouseY, width/2 - 100, height/2 + 130, 200, 44)) {
      inputScreen.reset();
      gameState = HOME;
    } else if (gameState == INPUT) {
      inputScreen.handleMouse(mouseX, mouseY);
    }
  }
}
void keyPressed() {
  if (gameState != GAME) return;
  if (battle.isFinished() && (key == 'r' || key == 'R')) {
    battle.start();
  } else {
    player.setKey(keyCode, true);
  }
}
void keyReleased() {
  if (gameState == GAME) player.setKey(keyCode, false);
}
void keyTyped() {
  if (gameState == INPUT) inputScreen.handleKey(key);
}
boolean isInside(float px, float py, float x, float y, float w, float h) {
  return px > x && px < x + w && py > y && py < y + h;
}
// =====================================================
// 保存 / 読み込み
// =====================================================
void save() {
  savePlayer();
  saveEnemy();
}
void load() {
  player.exp = loadPlayer();
  player.updateStats();
  battle.setSavedEnemyMaxHp(loadEnemy());
}
void savePlayer() {
  String[] data = new String[1];
  data[0] = str(player.exp);
  saveStrings("save_player.txt", data);
}
float loadPlayer() {
  String[] data = loadStrings("save_player.txt");
  if (data != null) return float(data[0]);
  return 0;
}
void saveEnemy() {
  String[] data = new String[1];
  data[0] = str(battle.getNextEnemyMaxHp());
  saveStrings("save_enemy.txt", data);
}
float loadEnemy() {
  String[] data = loadStrings("save_enemy.txt");
  if (data != null) return float(data[0]);
  return 100;
}
