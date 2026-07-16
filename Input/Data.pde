String input = "";
int currentIndex = -1;

// 種目名
String[] labels = {
  "ベンチプレス",
  "スクワット",
  "デッドリフト",
  "腕立て伏せ"
};

// 計算結果の保存
float[] values = new float[labels.length];

// 最終経験値
float exp = 0;
