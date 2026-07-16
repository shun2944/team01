
float COEF_BENCH    = 1.2;  // ベンチプレス
float COEF_SQUAT    = 1.5;  // スクワット
float COEF_PULLUP   = 3.0;  // 懸垂
float COEF_PUSHUP   = 1.0;  // 腕立て伏せ
float COEF_SITUP    = 1.0;  // 腹筋
float COEF_DUMBBELL = 2.0;  // ダンベル運動
float COEF_RUNNING  = 2.0;  // ランニング（分ベース）
float COEF_PLANK    = 0.5;  // プランク（秒ベース）

float benchPress(float weight, int reps, int sets) {
  return weight * reps * sets * COEF_BENCH;
}

/** スクワットの基礎ポイント */
float squat(float weight, int reps, int sets) {
  return weight * reps * sets * COEF_SQUAT;
}

/** ダンベル運動の基礎ポイント */
float dumbbell(float weight, int reps, int sets) {
  return weight * reps * sets * COEF_DUMBBELL;
}


/** 懸垂の基礎ポイント */
float pullUp(int reps, int sets) {
  return reps * sets * COEF_PULLUP;
}

/** 腕立て伏せの基礎ポイント */
float pushUp(int reps, int sets) {
  return reps * sets * COEF_PUSHUP;
}

/** 腹筋の基礎ポイント */
float sitUp(int reps, int sets) {
  return reps * sets * COEF_SITUP;
}


/** ランニングの基礎ポイント（分） */
float running(float minutes) {
  return minutes * COEF_RUNNING;
}

/** プランクの基礎ポイント（秒） */
float plank(float seconds, int sets) {
  return seconds * sets * COEF_PLANK;
}
