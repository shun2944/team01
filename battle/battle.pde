final int STATE_PLAYING = 0;
final int STATE_WIN     = 1;
final int STATE_LOSE    = 2;
int gameState = STATE_PLAYING;

Player player;
Enemy enemy;
ArrayList<Obstacle> obstacles;

// ---- 経験値 → 攻撃力 ----
// playerExp は「別のところ」（レベル管理システムなど）から渡ってくる想定の値。
// 今回はダミーとして "playerdata.json" というファイルから読み込む実装にしている。
int playerExp = 0;
final int EXP_PER_LEVEL     = 100; // このEXPごとにレベルが1上がる
final float BASE_ATTACK     = 5;   // Lv.1時点の攻撃力
final float ATTACK_PER_LEVEL = 3;  // レベル1につき攻撃力+3

// ---- 撃破するたびに敵が強くなる永続データ ----
final String SAVE_FILE = "savedata.json"; // 勝利数を保存するファイル
int winCount = 0;                   // 通算で敵を倒した回数（ファイルに保存・復元）
final float BASE_ENEMY_HEALTH    = 100; // 1体目の敵の体力
final float ENEMY_HEALTH_PER_WIN = 20;  // 1勝するごとに次の敵の体力が+20

void setup() {
  size(800, 600);

  loadGameData();              // winCount をファイルから読み込む
  playerExp = loadPlayerExp(); // 経験値を読み込む（外部連携部分）

  float attackPower = calcAttackPower(playerExp);
  float enemyHealth = calcEnemyHealth(winCount);

  // 敵キャラ：x, y, 半径, 体力（winCountに応じて自動計算）
  enemy = new Enemy(width / 2, height / 2, 40, enemyHealth);

  // プレイヤー：x, y, 半径, ライフ, 攻撃力（経験値から自動計算）
  player = new Player(60, height - 60, 15, 3, attackPower);

  // 障害物を複数、軌道半径・速度・初期角度を変えて配置
  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(enemy.x, enemy.y, 120,  0.015, 0));
  obstacles.add(new Obstacle(enemy.x, enemy.y, 120,  0.015, PI));
  obstacles.add(new Obstacle(enemy.x, enemy.y, 180, -0.010, HALF_PI));
  obstacles.add(new Obstacle(enemy.x, enemy.y, 180, -0.010, HALF_PI + PI));
  obstacles.add(new Obstacle(enemy.x, enemy.y, 240,  0.008, 0));
}

// ---- 経験値から攻撃力を計算 ----
float calcAttackPower(int exp) {
  int level = exp / EXP_PER_LEVEL;
  return BASE_ATTACK + level * ATTACK_PER_LEVEL;
}

// ---- 通算勝利数から敵の最大体力を計算 ----
float calcEnemyHealth(int wins) {
  return BASE_ENEMY_HEALTH + wins * ENEMY_HEALTH_PER_WIN;
}

// ---- 経験値の読み込み（外部システム連携用のダミー実装） ----
int loadPlayerExp() {
  // ★ここを、実際に経験値を管理している別プログラム／DB／APIなどから
  //   値を受け取る処理に置き換える。
  //   例）ネットワーク経由でAPIを叩く、共有DBを参照する、等。
  JSONObject data = loadJSONObject("playerdata.json");
  if (data != null) {
    return data.getInt("exp", 0);
  }
  return 0; // ファイルが無い・読み込めない場合は経験値0として扱う
}

// ---- 勝利数（敵の強さ）の読み込み・保存 ----
void loadGameData() {
  JSONObject data = loadJSONObject(SAVE_FILE);
  if (data != null) {
    winCount = data.getInt("winCount", 0);
  }
}

void saveGameData() {
  JSONObject data = new JSONObject();
  data.setInt("winCount", winCount);
  saveJSONObject(data, SAVE_FILE);
}

void draw() {
  background(30);

  if (gameState == STATE_PLAYING) {
    updateGame();
  }

  drawGame();

  if (gameState == STATE_WIN) {
    drawEndMessage("YOU WIN!", color(80, 220, 120));
  } else if (gameState == STATE_LOSE) {
    drawEndMessage("GAME OVER", color(220, 80, 80));
  }
}

// ---- 更新処理 ----
void updateGame() {
  player.handleInput();
  player.update();

  for (Obstacle o : obstacles) {
    o.update();
  }

  // 障害物との当たり判定
  for (Obstacle o : obstacles) {
    if (player.checkCollision(o)) {
      onPlayerHitObstacle();
      break;
    }
  }

  // 敵との当たり判定（体当たり）
  if (player.checkCollision(enemy)) {
    onPlayerHitEnemy();
  }
}

// ---- 描画処理 ----
void drawGame() {
  enemy.display();
  for (Obstacle o : obstacles) {
    o.display();
  }
  player.display();

  drawUI();
}

// ---- イベント処理 ----
void onPlayerHitObstacle() {
  player.loseLife();
  player.resetPosition();

  if (player.lives <= 0) {
    gameState = STATE_LOSE;
  }
}

void onPlayerHitEnemy() {
  enemy.takeDamage(player.attackPower);
  player.resetPosition();

  if (enemy.health <= 0) {
    gameState = STATE_WIN;
    winCount++;        // 撃破回数を+1
    saveGameData();    // ファイルに保存 → 次回はこの分だけ敵が強くなる
  }
}

// ---- UI ----
void drawUI() {
  fill(255);
  textSize(18);
  textAlign(LEFT, TOP);
  text("LIFE: " + player.lives, 20, 20);
  text("Lv." + (playerExp / EXP_PER_LEVEL) + "  ATK: " + nf(player.attackPower, 0, 1), 20, 44);
  text("WIN: " + winCount, 20, 68);

  float barW = 300;
  float barH = 20;
  float bx = width / 2 - barW / 2;
  float by = 20;
  float ratio = constrain(enemy.health / (float) enemy.maxHealth, 0, 1);

  noFill();
  stroke(255);
  rect(bx, by, barW, barH);
  noStroke();
  fill(220, 80, 80);
  rect(bx, by, barW * ratio, barH);

  fill(255);
  textAlign(CENTER, TOP);
  text("ENEMY HP", width / 2, by + barH + 4);
}

void drawEndMessage(String msg, color c) {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(c);
  textSize(48);
  textAlign(CENTER, CENTER);
  text(msg, width / 2, height / 2 - 20);

  fill(255);
  textSize(18);
  text("press [R] to restart", width / 2, height / 2 + 30);
}

// ---- 入力 ----
void keyPressed() {
  if (gameState == STATE_PLAYING) {
    player.setKey(keyCode, true);
  }

  if ((gameState == STATE_WIN || gameState == STATE_LOSE) && (key == 'r' || key == 'R')) {
    restartGame();
  }
}

void keyReleased() {
  player.setKey(keyCode, false);
}

void restartGame() {
  gameState = STATE_PLAYING;
  enemy.maxHealth = calcEnemyHealth(winCount); // 勝利数に応じて敵を強化
  enemy.health = enemy.maxHealth;
  player.lives = player.maxLives;
  player.resetPosition();
}
