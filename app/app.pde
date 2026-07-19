// ----- 画面状態 -----
final int HOME  = 0;
final int INPUT = 1;
final int GAME  = 2;
int gameState = HOME;

// ----- オブジェクト -----
Player player;
Enemy enemy;

// ----- Home画面のボタン領域 -----
float btnInputX, btnInputY, btnInputW = 220, btnInputH = 50;
float btnGameX,  btnGameY,  btnGameW  = 220, btnGameH  = 50;

//プレイヤーの画像
PImage[] playerImages;

void setup() {
  size(600, 500);
  textAlign(CENTER, CENTER);
  playerImages = new PImage[5]; // 例: レベル1〜5
  playerImages[0] = loadImage("level1.png");
  playerImages[1] = loadImage("level2.png");
  playerImages[2] = loadImage("level3.png");
  playerImages[3] = loadImage("level4.png");
  playerImages[4] = loadImage("level5.png");
  

  player = new Player(width/2, height - 150, 60, playerImages[0], 0); // exp=0からスタート
  enemy  = new Enemy(width/2, 100, 60, 40);           // maxHp=40からスタート

  btnInputX = width/2 - btnInputW/2;
  btnInputY = 330;
  btnGameX  = width/2 - btnGameW/2;
  btnGameY  = 400;

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

  // キャラ表示(expに応じて色・サイズが変化)
  player.display();

  // ステータス表示
  fill(30);
  textSize(16);
  text("EXP: " + nf(player.exp, 0, 1), width/2, 200);
  text("HP: " + player.hp + " / " + player.maxHp, width/2, 225);
  text("ATK: " + player.attack, width/2, 250);
  text("TIME: " + player.defeatedCount, width/2, 275);

  // ボタン(仮の四角形)
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
// INPUT / GAME はまだ未実装なので仮表示のみ
// =====================================================
void drawInput() {
  fill(30);
  textSize(20);
  text("INPUT", width/2, height/2 - 20);
  drawButton(width/2 - 100, height/2 + 30, 200, 44, "Home");
}

void drawGame() {
  fill(30);
  textSize(20);
  text("GAME", width/2, height/2 - 20);
  drawButton(width/2 - 100, height/2 + 30, 200, 44, "Home");
}

void add(float gainedExp) {
    exp += gainedExp;
    updateImage(); // expの値に応じて画像を更新
  }
  
void updateImage() {
    img = playerImages[level - 1]; // レベルに応じた画像に差し替え
  }


// =====================================================
// クリック処理(画面遷移)
// =====================================================
void mousePressed() {
  if (gameState == HOME) {
    if (isInside(mouseX, mouseY, btnInputX, btnInputY, btnInputW, btnInputH)) {
      gameState = INPUT;
    } else if (isInside(mouseX, mouseY, btnGameX, btnGameY, btnGameW, btnGameH)) {
      gameState = GAME;
    }
  } else if (gameState == INPUT || gameState == GAME) {
    // 仮のHomeに戻るボタン(中央下の領域)
    if (isInside(mouseX, mouseY, width/2 - 100, height/2 + 30, 200, 44)) {
      gameState = HOME;
    }
  }
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
  enemy.maxHp = loadEnemy();
}

void savePlayer() {
  String[] data = new String[1];
  data[0] = str(player.exp);

  saveStrings("save_player.txt", data);
}

float loadPlayer() {
  String[] data = loadStrings("save_player.txt");

  if (data != null) {
    return float(data[0]);
  }

  return 0;
}

void saveEnemy() {
  String[] data = new String[1];
  data[0] = str(enemy.maxHp);

  saveStrings("save_enemy.txt", data);
}

int loadEnemy() {
  String[] data = loadStrings("save_enemy.txt");

  if (data != null) {
    return int(data[0]);
  }

  return 0;  // 初期値
}
