void mousePressed() {
  // HOMEボタン判定
  if (mouseX > width - 120 && mouseX < width - 20 &&
      mouseY > height - 60 && mouseY < height - 20) {

    // 入力状態をリセットしてHOMEへ
    currentIndex = -1;
    input = "";
    gameState = HOME;
    return;
  }

  // 種目選択
  if (gameState == INPUT && currentIndex == -1) {
    for (int i = 0; i < labels.length; i++) {
      float y = 180 + i * 40;
      if (mouseY > y - 20 && mouseY < y + 20) {
        currentIndex = i;
      }
    }
  }
}

void keyTyped() {
  if (gameState != INPUT) return;
  if (currentIndex == -1) return;

  // 数字入力
  if (key >= '0' && key <= '9') {
    input += key;
  }
  // バックスペース
  else if (key == BACKSPACE && input.length() > 0) {
    input = input.substring(0, input.length() - 1);
  }
  // Enterで確定
  else if (key == ENTER || key == RETURN) {

    if (input.length() > 0) {

      float raw = float(input);

      // 他の人が作る計算式（仮）
      float result = calcExp(raw, currentIndex);

      values[currentIndex] = result;
      exp += result;

    }

    // 種目選択に戻る
    input = "";
    currentIndex = -1;
  }
}
