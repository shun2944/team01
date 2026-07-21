// Input画面で選ぶ種目
String[] exerciseLabels = {
  "ベンチプレス",
  "スクワット",
  "デッドリフト",
  "腕立て伏せ"
};
float COEF_BENCH = 1.2;
float COEF_SQUAT = 1.5;
float COEF_DEADLIFT = 1.5; // デッドリフト用。必要なら後から調整できる。
float COEF_PUSHUP = 1.0;
float benchPress(float weight, int reps, int sets) { return weight * reps * sets * COEF_BENCH; }
float squat(float weight, int reps, int sets) { return weight * reps * sets * COEF_SQUAT; }
float deadlift(float weight, int reps, int sets) { return weight * reps * sets * COEF_DEADLIFT; }
float pushUp(int reps, int sets) { return reps * sets * COEF_PUSHUP; }
