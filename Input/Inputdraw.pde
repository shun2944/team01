void drawInput() {
  background(240);
  textAlign(CENTER, CENTER);
  fill(0);

  textSize(28);
  text("筋トレの記録を入力", width/2, 50);

  // HOMEボタン
  drawHomeButton();

  // 種目選択画面
  if (currentIndex == -1) {
    textSize(22);
    text("種目を選んでください", width/2, 120);

    textSize(20);
    for (int i = 0; i < labels.length; i++) {
      float y = 180 + i * 40;
      text(labels[i], width/2, y);
    }
  }

  // 入力画面
  else {
    textSize(22);
    text(labels[currentIndex] + " の記録を入力", width/2, 150);

    // 入力欄
    stroke(0);
    noFill();
    rect(width/2 - 80, 200, 160, 40);

    fill(0);
    textSize(26);
    text(input, width/2, 220);

    textSize(16);
    fill(100);
    text("Enterで確定", width/2, 260);
  }
}

void drawHomeButton() {
  stroke(0);
  fill(200);
  rect(width - 120, height - 60, 100, 40);
  fill(0);
  textSize(18);
  text("HOME", width - 70, height - 40);
}
