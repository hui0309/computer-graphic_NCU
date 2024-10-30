public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
    // stroke(0);
    // noFill();
    // line(x1,y1,x2,y2);
    // line(0,0,50,50);
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

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.

    return false;
}

public Vector3[] findBoundBox(Vector3[] v) {
    
    
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2

    Vector3 recordminV = new Vector3(0);
    Vector3 recordmaxV = new Vector3(999);
    Vector3[] result = { recordminV, recordmaxV };
    return result;

}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.

    output = input;

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}
