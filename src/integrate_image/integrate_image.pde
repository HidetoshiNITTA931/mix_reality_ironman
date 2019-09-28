import kinect4WinSDK.Kinect;                      // kinect4WinSDK ライブラリを使う
 
Kinect kine = new Kinect(this);              // Kinect オブジェクト "kine" の宣言
 
void setup() {
  size(640, 480);                            // ウィンドウのサイズ設定
}
 
void draw() {
  background(0);                             // 背景を黒く塗りつぶす
  image(kine.GetImage(), 0, 0, 640, 480);    // Kinect のカラー画像を描画
}
