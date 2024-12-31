public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
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

public boolean isPointOnLineSegment(Vector3 p1, Vector3 p2, Vector3 p3) {
    if(Math.abs((Vector3.cross(p2.sub(p1), p3.sub(p1))).length()) > 1e-6) return false;
    return (Math.min(p1.x, p2.x) <= p3.x && p3.x <= Math.max(p1.x, p2.x) &&
            Math.min(p1.y, p2.y) <= p3.y && p3.y <= Math.max(p1.y, p2.y));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2
    // You need to check the coordinate p(x,v) if inside the vertexes. 
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
    Vector3 recordminV = new Vector3(1.0 / 0.0);
    Vector3 recordmaxV = new Vector3(-1.0 / 0.0);
    // TODO HW2
    // You need to find the bounding box of the vertexes v.

    float minX = Float.MAX_VALUE, minY = Float.MAX_VALUE;
    float maxX = -Float.MAX_VALUE, maxY = -Float.MAX_VALUE;

    for (Vector3 vertex : v) {
        minX = Math.min(minX, vertex.x);
        minY = Math.min(minY, vertex.y);
        maxX = Math.max(maxX, vertex.x);
        maxY = Math.max(maxY, vertex.y);
    }

    return new Vector3[] { new Vector3(minX, minY, 0), new Vector3(maxX, maxY, 0) };
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
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.
   for (int i = 0; i < boundary.length && input.size() != 0; ++i) {
        Vector3 boundary1 = boundary[i];
        Vector3 boundary2 = boundary[(i + 1) % boundary.length];
        // 線段是逆時針
        Vector3 AB = boundary2.sub(boundary1);
        Vector3 AC = (input.get(input.size() - 1)).sub(boundary1);
        boolean preInside =  ((Vector3.cross(AB, AC)).length() >= 0);
        for (int j = 0; j < input.size(); ++j) {
            Vector3 AD = (input.get(j)).sub(boundary1);    
            boolean curInside = ((Vector3.cross(AB, AD)).length() >= 0);
            Vector3 prePoint = input.get((j - 1 + input.size()) % input.size());
            Vector3 nowPoint = input.get(j);
            
            float denom = (boundary1.x - boundary2.x) * (prePoint.y - nowPoint.y) - (boundary1.y - boundary2.y) * (prePoint.x - nowPoint.x);
            float intersectX = ((boundary1.x * boundary2.y - boundary1.y * boundary2.x) * (prePoint.x - nowPoint.x) - (boundary1.x - boundary2.x) * (prePoint.x * nowPoint.y - prePoint.y * nowPoint.x)) / denom;
            float intersectY = ((boundary1.x * boundary2.y - boundary1.y * boundary2.x) * (prePoint.y - nowPoint.y) - (boundary1.y - boundary2.y) * (prePoint.x * nowPoint.y - prePoint.y * nowPoint.x)) / denom;

            Vector3 crossDot = new Vector3(intersectX, intersectY, 0);
            
            if (curInside) {
                // 當前點在邊界內
                if (!preInside) {
                    output.add(crossDot); // 加入交點
                }
                output.add(input.get(j)); // 加入當前點
            } else {
                if (preInside) {
                    output.add(crossDot); // 加入交點
                }
            }
            preInside = curInside;
        }
        input.clear();  // 清空現有內容
        input.addAll(output);  // 直接把 output 放入 input，減少複製操作
        output.clear();
    }

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

public float getDepth(float x, float y, Vector3[] vertex) {
    // TODO HW3
    // You need to calculate the depth (z) in the triangle (vertex) based on the
    // positions x and y. and return the z value;
    Vector3 AB = vertex[1].sub(vertex[0]);
    Vector3 AC = vertex[2].sub(vertex[0]);
    Vector3 n = Vector3.cross(AB, AC);
    if(n.z < 1e-6) return Float.MAX_VALUE;
    float d = -1 * Vector3.dot(n, vertex[0]);
    return -(n.x * x + n.y * y + d) / n.z;
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A = verts[0].homogenized();
    Vector3 B = verts[1].homogenized();
    Vector3 C = verts[2].homogenized();

    Vector4 AW = verts[0];
    Vector4 BW = verts[1];
    Vector4 CW = verts[2];

    // TODO HW4
    // Calculate the barycentric coordinates of point P in the triangle verts using
    // the barycentric coordinate system.
    // Please notice that you should use Perspective-Correct Interpolation otherwise
    // you will get wrong answer.

    //未校正過的
    Vector3 v0 = B.sub(A);
    Vector3 v1 = C.sub(A);
    Vector3 v2 = P.sub(A);
    float d00 = Vector3.dot(v0, v0);
    float d01 = Vector3.dot(v0, v1);
    float d11 = Vector3.dot(v1, v1);
    float d20 = Vector3.dot(v2, v0);
    float d21 = Vector3.dot(v2, v1);
    float denom = d00 * d11 - d01 * d01;
    float v = (d11 * d20 - d01 * d21) / denom;
    float w = (d00 * d21 - d01 * d20) / denom;
    float u = 1.0f - v - w;

    // 透視校正
    u = u / AW.w;
    v = v / BW.w;
    w = w / CW.w;
    float sum = u + v + w; // Osum = 1 
    u /= sum;
    v /= sum;
    w /= sum;
    float[] result = {u, v, w};
    return result;
}

Vector3 interpolation(float[] abg, Vector3[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

Vector4 interpolation(float[] abg, Vector4[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

float interpolation(float[] abg, float[] v) {
    return v[0] * abg[0] + v[1] * abg[1] + v[2] * abg[2];
}
