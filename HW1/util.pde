public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).

    /*
    stroke(0);
    noFill();
    line(x1,y1,x2,y2);
    */
    
    // f() = a*x + b*y + c = 0
    float a = Math.abs(y2 - y1);
    float b = Math.abs(x2 - x1);
    // next step
    float sx = (x1 > x2? -1 : 1);
    float sy = (y1 > y2? -1 : 1);

    // check slope dir
    float m = a / b;  
    float d = (m > 1? b - 0.5 * a : a - 0.5 * b); 
    while(true){
        drawPoint(x1, y1, color(0, 0, 0));
        if(m > 1 && y1 != y2){
            if(d > 0){
                d -= a;
                x1 += sx;
            }
            d += b;
            y1 += sy;
        }
        else if(m <= 1 && x1 != x2){
            if(d > 0){
                d -= b;
                y1 += sy;
            }
            d += a;
            x1 += sx;
        }
        else break;
    }
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */

    // x^2 + y^2 = r^2
    float x1 = 0, y1 = r, d = 1.25 - r;
    float e = 3, se = -2 * r + 5;
    while(x1 <= y1){
        // circle is point symmetry
        drawPoint(x + x1, y + y1, color(0, 0, 0));
        drawPoint(x - x1, y + y1, color(0, 0, 0));
        drawPoint(x + x1, y - y1, color(0, 0, 0));
        drawPoint(x - x1, y - y1, color(0, 0, 0));
        drawPoint(x + y1, y + x1, color(0, 0, 0));
        drawPoint(x - y1, y + x1, color(0, 0, 0));
        drawPoint(x + y1, y - x1, color(0, 0, 0));
        drawPoint(x - y1, y - x1, color(0, 0, 0));
        if(d < 0){
            d += e;
        }
        else{
            --y1;
            d += se;
            se += 2;
        }
        e += 2; se += 2;
        ++x1; //no move, cross line
    }   
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // float x1 = 0;
    // float y1 = r2;

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

    // x ^ 2 / r1 ^ 1 + y ^ 2 / r2 ^ 2 = 1;
    float x1 = 0, y1 = r2;
    float r1_sq = r1 * r1;
    float r2_sq = r2 * r2;
    float dx = 2 * r2_sq * x1;
    float dy = 2 * r1_sq * y1;

    // Region 1: x / r1 ^ 2 的增加速度小於 y / r2 ^ 2 的減少速度
    float d1 = r2_sq - r1_sq * r2 + 0.25f * r1_sq;
    while (dx < dy) {
        // ellipse is point symmetry
        drawPoint(x + x1, y + y1, color(0, 0, 0));
        drawPoint(x - x1, y + y1, color(0, 0, 0));
        drawPoint(x + x1, y - y1, color(0, 0, 0));
        drawPoint(x - x1, y - y1, color(0, 0, 0));

        if (d1 < 0) {
            dx += 2 * r2_sq;
            d1 += dx + r2_sq;
        } else {
            y1--;
            dx += 2 * r2_sq;
            dy -= 2 * r1_sq;
            d1 += dx - dy + r2_sq;
        }
        x1++;
    }

    // Region 2:  y / r2 ^ 2 的減少速度大於或等於 x1/r1^2 的增加速度
    float d2 = r2_sq * (x1 + 0.5f) * (x1 + 0.5f) + r1_sq * (y1 - 1) * (y1 - 1) - r1_sq * r2_sq;
    while (y1 >= 0) {
        // ellipse is point symmetry
        drawPoint(x + x1, y + y1, color(0, 0, 0));
        drawPoint(x - x1, y + y1, color(0, 0, 0));
        drawPoint(x + x1, y - y1, color(0, 0, 0));
        drawPoint(x - x1, y - y1, color(0, 0, 0));

        if (d2 > 0) {
            dy -= 2 * r1_sq;
            d2 += r1_sq - dy;
        } else {
            x1++;
            dx += 2 * r2_sq;
            dy -= 2 * r1_sq;
            d2 += dx - dy + r1_sq;
        }
        y1--;
    }


}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    

    // float t = 0;
    // float dt = 0.001;
    // // (1 - t) ^ 3 * p1 + (1 - t) ^ 2 * p2 + (1 - t) * p3 + p4
    // while (t <= 1) {
    //     float x = (float) (Math.pow(1 - t, 3) * p1.x + 3 * Math.pow(1 - t, 2) * t * p2.x + 3 * (1 - t) * Math.pow(t, 2) * p3.x + Math.pow(t, 3) * p4.x);
    //     float y = (float) (Math.pow(1 - t, 3) * p1.y + 3 * Math.pow(1 - t, 2) * t * p2.y + 3 * (1 - t) * Math.pow(t, 2) * p3.y + Math.pow(t, 3) * p4.y);

    //     drawPoint(x, y, color(0, 0, 0));

    //     t += dt;
    // }
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // left -> right, top -> bottom
    float left = min(p1.x, p2.x);
    float right = max(p1.x, p2.x);
    float top = min(p1.y, p2.y);
    float bottom = max(p1.y, p2.y);
    
    for (float x = left; x <= right; ++x) {
        for (float y = top; y <= bottom; ++y) {
            // bg color
            drawPoint(x, y, color(250)); 
        }
    }

}

public void drawPoint(float x, float y, color c) {
    
    // bar tools
    if(y <= 40){
        return;
    }
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
