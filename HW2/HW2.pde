Engine engine;

void setup() {
    size(1000, 600);
    engine = new Engine();
}

void draw() {
    background(255);
    engine.run();
}

// 當有滑鼠事件再重畫即可
void mousePressed() {
  redraw();
}
