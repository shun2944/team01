class Input {
  String input = "";
  int currentIndex = -1;
  int inputStep = 0;
  float weight;
  float reps;
  float completedExp = 0;

  void display() {
    background(240);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(28);
    text("筋トレの記録を入力", width/2, 50);

    if (currentIndex == -1) {
      textSize(22);
      text("種目を選んでください", width/2, 120);
      textSize(20);
      for (int i = 0; i < exerciseLabels.length; i++) {
        text(exerciseLabels[i], width/2, 180 + i * 40);
      }
      return;
    }

    textSize(22);
    text(exerciseLabels[currentIndex] + " の記録を入力", width/2, 130);
    textSize(18);
    text(getFieldLabel(), width/2, 175);
    stroke(0);
    noFill();
    rect(width/2 - 80, 200, 160, 40);
    fill(0);
    textSize(26);
    text(input, width/2, 220);
    textSize(16);
    fill(100);
    text("Enterで次へ", width/2, 260);
  }

  void handleMouse(float mx, float my) {
    if (currentIndex != -1) return;
    for (int i = 0; i < exerciseLabels.length; i++) {
      float y = 180 + i * 40;
      if (my > y - 20 && my < y + 20) {
        currentIndex = i;
        inputStep = 0;
      }
    }
  }

  void handleKey(char typedKey) {
    if (currentIndex == -1) return;
    if ((typedKey >= '0' && typedKey <= '9') || (typedKey == '.' && input.indexOf('.') == -1)) {
      input += typedKey;
    } else if (typedKey == BACKSPACE && input.length() > 0) {
      input = input.substring(0, input.length() - 1);
    } else if ((typedKey == ENTER || typedKey == RETURN) && input.length() > 0) {
      advance();
    }
  }

  void advance() {
    float value = float(input);
    boolean isPushUp = currentIndex == 3;
    int lastStep = isPushUp ? 1 : 2;

    if (inputStep == 0) weight = value; // 腕立て伏せでは回数として使う
    else if (inputStep == 1 && !isPushUp) reps = value;

    if (inputStep < lastStep) {
      inputStep++;
      input = "";
      return;
    }

    completedExp = calculateExp(value);
    reset();
  }

  float calculateExp(float sets) {
    if (currentIndex == 0) return benchPress(weight, int(reps), int(sets));
    if (currentIndex == 1) return squat(weight, int(reps), int(sets));
    if (currentIndex == 2) return deadlift(weight, int(reps), int(sets));
    return pushUp(int(weight), int(sets));
  }

  String getFieldLabel() {
    if (currentIndex == 3) return inputStep == 0 ? "回数" : "セット数";
    return inputStep == 0 ? "重量 (kg)" : inputStep == 1 ? "回数" : "セット数";
  }

  float consumeExp() {
    float result = completedExp;
    completedExp = 0;
    return result;
  }

  void reset() {
    input = "";
    currentIndex = -1;
    inputStep = 0;
    weight = 0;
    reps = 0;
  }
}
