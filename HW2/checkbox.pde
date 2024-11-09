public class Checkbox {
    private Vector3 pos;
    private float width, height;
    private boolean isChecked;
    private boolean isClicked; // 用來避免多次觸發
    private String label;

    public Checkbox(Vector3 pos, float width, float height, String label) {
        this.pos = pos;
        this.width = width;
        this.height = height;
        this.label = label;
        this.isChecked = false;
        this.isClicked = false;
    }

    public void show() {
        fill(!isClicked ? color(100) : color(255));
        rect(pos.x, pos.y, width, height);  // 顯示勾選框

        // 如果已勾選，顯示勾選標誌
        if (isChecked) {
            stroke(100, 0, 0);
            line(pos.x, pos.y + height / 2, pos.x + width / 3, pos.y + height);
            line(pos.x + width / 3, pos.y + height, pos.x + width, pos.y);
        }

        // 顯示文字標籤
        textSize(15);
        fill(0);
        text(label, pos.x + width + 10, pos.y + height / 2);
    }

    public void click() {
        if (mousePressed) {
            if (!isClicked && mouseOver()) {
                isChecked = !isChecked;
                isClicked = true; // 設置已點擊狀態
            }
        } else {
            isClicked = false; // 當鼠標釋放時重置點擊狀態
        }
    }

    public boolean isChecked() {
        return isChecked;
    }

    private boolean mouseOver() {
        return mouseX >= pos.x && mouseX <= pos.x + width &&
               mouseY >= pos.y && mouseY <= pos.y + height;
    }
}
