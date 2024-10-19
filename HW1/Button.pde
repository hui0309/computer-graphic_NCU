public class Box {
    public Vector3 pos;
    public Vector3 size;
    protected color box_color = color(0);

    public Box(float x, float y, float w, float h) {
        pos = new Vector3(x, y, 0);
        size = new Vector3(w, h, 0);
    }

    public Box(Vector3 p, Vector3 s) {
        pos = p;
        size = s;
    }

    public Box setBoxColor(color c) {
        box_color = c;
        return this;
    }

    public void show() {
        fill(box_color);
        noStroke();
        rect(pos.x, pos.y, size.x, size.y);
    }

    public boolean checkInSide(Vector3 p) {
        if (p.x >= pos.x && p.x <= pos.x + size.x && p.y >= pos.y && p.y <= pos.y + size.y)
            return true;
        return false;
    }

    public boolean checkInSide() {
        if (mouseX >= pos.x && mouseX <= pos.x + size.x && mouseY >= pos.y && mouseY <= pos.y + size.y)
            return true;
        return false;
    }

}

public class Button extends Box {
    protected color click_color;
    protected boolean press = false;
    protected boolean once = false;
    protected PImage image = null;

    public Button(float x, float y, float w, float h) {
        super(x, y, w, h);
    }

    public Button(Vector3 p, Vector3 s) {
        super(p, s);
    }

    public Button setImage(PImage img) {
        image = img;
        return this;
    }

    public void run(ButtonFunction bf) {
        click(bf);
        show();
    }

    @Override
    public void show() {
        if (!press)
            fill(box_color);
        else
            fill(click_color);
        noStroke();
        rect(pos.x, pos.y, size.x, size.y);
        if (image != null)
            image(image, pos.x, pos.y, size.x, size.y);
    }

    public void setClickColor(color c) {
        click_color = c;
    }

    public Button setBoxAndClickColor(color c1, color c2) {
        setBoxColor(c1);
        setClickColor(c2);
        return this;
    }

    public void click(ButtonFunction bf) {

        if (!checkInSide())
            return;
        if (mousePressed) {
            press = true;
            if (!once) {
                bf.function();
                once = true;
            }
        } else {
            press = false;
            once = false;
        }
    }

}

public class ShapeButton extends Button {
    private boolean selected = false;

    public ShapeButton(float x, float y, float w, float h) {
        super(x, y, w, h);
    }

    public ShapeButton(Vector3 p, Vector3 s) {
        super(p, s);
    }

    @Override
    public void show() {
        super.show();
        if (selected) {
            stroke(255, 0, 0);
            noFill();
            rect(pos.x - 2, pos.y - 2, size.x + 4, size.y + 4);
        }
    }

    public void beSelect() {
        resetButton();
        setSelected(true);
    }

    public void setSelected(boolean b) {
        selected = b;
    }

    public Renderer getRendererType() {
        return null;
    }
}

public class ColorButton extends Button {
    // 顏色與圖片數組
    private color[] colors = new color[8];
    private PImage[] images = new PImage[8];

    // 當前選中的顏色和圖片
    private color currentColor;
    private PImage currentImage;
    private int selectedColorIndex = 0; // 顏色與圖片的索引

    public ColorButton(float x, float y, float w, float h) {
        super(x, y, w, h);

        // 初始化顏色
        colors[0] = color(0, 0, 0);       // black
        colors[1] = color(255, 0, 0);     // red
        colors[2] = color(0, 255, 0);     // green
        colors[3] = color(0, 0, 255);     // blue
        colors[4] = color(255, 255, 0);   // yellow
        colors[5] = color(0, 255, 255);   // cray
        colors[6] = color(255, 0, 255);   // purple
        colors[7] = color(255, 255, 255); // white

        // 初始化圖片
        images[0] = loadImage("black.png");
        images[1] = loadImage("red.png");
        images[2] = loadImage("green.png");
        images[3] = loadImage("blue.png");
        images[4] = loadImage("yellow.png");
        images[5] = loadImage("cray.png");
        images[6] = loadImage("purple.png");
        images[7] = loadImage("white.png");

        // 初始選中的顏色和圖片
        currentColor = colors[selectedColorIndex];
        currentImage = images[selectedColorIndex];
    }

    @Override
    public void show() {
        // 繪製當前顏色
        fill(currentColor);
        noStroke();
        rect(pos.x, pos.y, size.x, size.y);

        // 顯示當前圖片
        if (currentImage != null) {
            image(currentImage, pos.x, pos.y, size.x, size.y);
        }

        // 如果按鈕被按下，顯示紅色邊框
        if (press) {
            stroke(255, 0, 0);
            noFill();
            rect(pos.x - 2, pos.y - 2, size.x + 4, size.y + 4);
        }
    }

    @Override
    public void click(ButtonFunction bf) {
        // 按鈕點擊事件
        if (!checkInSide())
            return;
        if (mousePressed) {
            press = true;
            if (!once) {
                // 循環選擇下一個顏色和圖片
                selectedColorIndex = (selectedColorIndex + 1) % colors.length;
                currentColor = colors[selectedColorIndex];
                currentImage = images[selectedColorIndex];
                bf.function(); // 執行傳入的函數
                once = true;
            }
        } else {
            press = false;
            once = false;
        }
    }

    // 返回當前選中的顏色
    public color getCurrentColor() {
        return currentColor;
    }

    // 手動設置顏色
    public void setCurrentColor(color c) {
        currentColor = c;
    }
}
