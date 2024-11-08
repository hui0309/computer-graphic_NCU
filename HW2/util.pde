public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
    // f() = a*x + b*y + c = 0

    // float -> int -> float, avoid finite loop
    x1 = floor(x1); x2 = floor(x2);
    y1 = floor(y1); y2 = floor(y2);
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
float crossProduct(Vector3 p1, Vector3 p2, Vector3 p3) {
    return (p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x);
}
boolean isPointOnLineSegment(Vector3 p1, Vector3 p2, Vector3 p3) {
    if(Math.abs(crossProduct(p1, p2, p3)) > 1e-6) return false;
    return (Math.min(p1.x, p2.x) <= p3.x && p3.x <= Math.max(p1.x, p2.x) &&
            Math.min(p1.y, p2.y) <= p3.y && p3.y <= Math.max(p1.y, p2.y));
}
// 計算兩條線段的交點
private Vector3 intersection(Line p, Line q) {
    float denom = (p.point1.x - p.point2.x) * (q.point1.y - q.point2.y) - (p.point1.y - p.point2.y) * (q.point1.x - q.point2.x);
    float intersectX = ((p.point1.x * p.point2.y - p.point1.y * p.point2.x) * (q.point1.x - q.point2.x) - (p.point1.x - p.point2.x) * (q.point1.x * q.point2.y - q.point1.y * q.point2.x)) / denom;
    float intersectY = ((p.point1.x * p.point2.y - p.point1.y * p.point2.x) * (q.point1.y - q.point2.y) - (p.point1.y - p.point2.y) * (q.point1.x * q.point2.y - q.point1.y * q.point2.x)) / denom;
    return new Vector3(intersectX, intersectY, 0);
}
boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.
    // ray casting
    int intersections = 0;
    Vector3 tmp = new Vector3(x, y, 0);
    for(int i = 0; i < vertexes.length; ++i){
        Vector3 p1 = vertexes[i];
        Vector3 p2 = vertexes[(i + 1) % vertexes.length];
        // 在線段上
        boolean onEdge = isPointOnLineSegment(vertexes[i], vertexes[(i + 1) % vertexes.length], tmp);
        if(onEdge){
            return true;
        }
        // 是否可以穿透該條線
        if ((p1.y > tmp.y) != (p2.y > tmp.y)) {
            // 射線的交點
            float xIntersection = p1.x + (tmp.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y);
            if (tmp.x < xIntersection) {
                intersections++;
            }
        }
    }
    return (intersections % 2 == 1);
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
    Vector3 recordmaxV = new Vector3(2000);
    for(int i = 0; i < v.length; ++i){
        recordminV.x = Math.min(recordminV.x, v[i].x);
        recordminV.y = Math.min(recordminV.y, v[i].y);
        recordmaxV.x = Math.max(recordmaxV.x, v[i].x);
        recordmaxV.y = Math.max(recordmaxV.y, v[i].y);
    }
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
    for (int i = 0; i < boundary.length && input.size() != 0; ++i) {
        Vector3 boundary1 = boundary[i];
        Vector3 boundary2 = boundary[(i + 1) % boundary.length];
        Line p = new Line(boundary1, boundary2);
        // 線段是順時針放
        boolean preInside = crossProduct(boundary1, boundary2, input.get(input.size() - 1)) <= 0;
        for (int j = 0; j < input.size(); ++j) {
            boolean curInside = crossProduct(boundary1, boundary2, input.get(j)) <= 0;
            Line q = new Line(input.get((j - 1 + input.size()) % input.size()), input.get(j));
            if (curInside) {
                // 當前點在邊界內
                if (!preInside) {
                    output.add(intersection(p, q)); // 加入交點
                }
                output.add(input.get(j)); // 加入當前點
            } else {
                if (preInside) {
                    output.add(intersection(p, q)); // 加入交點
                }
            }
            preInside = curInside;
        }
        input = output;
        // 用output創建一個新的ArrayList來保留input的原本內容
        // ArrayList 類似 python 的淺拷貝
        input = new ArrayList<>(output); 
        output.clear();
    }
    // output = input;
    Vector3[] result = new Vector3[input.size()];
    for (int i = 0; i < result.length; ++i) {
        result[i] = input.get(i);
    }
    return result;
}
