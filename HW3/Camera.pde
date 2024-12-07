public class Camera {
    Matrix4 projection = new Matrix4();
    Matrix4 worldView = new Matrix4();
    public int wid;
    public int hei;
    public float near;
    public float far;
    Transform transform;

    Camera() {
        wid = 256;
        hei = 256;
        near = 0;
        far = 100;
        worldView.makeIdentity();
        projection.makeIdentity();
        setSize(wid, hei, near, far);
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

    Matrix4 Matrix() {
        return projection.mult(worldView);
    }

    void setSize(int w, int h, float n, float f) {
        wid = w;
        hei = h;
        near = n;
        far = f;
        // TODO HW3
        // This function takes four parameters, which are 
        // the width of the screen, the height of the screen
        // the near plane and the far plane of the camera.
        // Where GH_FOV has been declared as a global variable.
        // Finally, pass the result into projection matrix.
        projection = new Matrix4();
        float aspect = wid / hei;
        float tan_fov = (float)Math.tan(Math.toRadians(GH_FOV / 2));
        projection.set(0, 0, 1);
        projection.set(1, 1, aspect);
        projection.set(2, 2, far / (far - near) * tan_fov);
        projection.set(2, 3, far * near / (near - far) * tan_fov);
        projection.set(3, 2, tan_fov);
    }

    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {

    }

    /*
        | right      0|       | 1 0 0 Px |
        | up         0|   x   | 0 1 0 Py |
        | -forword   0|       | 0 0 1 Pz |
        | 0          1|       | 0 0 0  1 |
    */
    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // TODO HW3
        // This function takes two parameters, which are the position of the camera and
        // the point the camera is looking at.
        // We uses topVector = (0,1,0) to calculate the eye matrix.
        // Finally, pass the result into worldView matrix.
        Vector3 _forward = lookat.sub(pos).unit_vector();
        Vector3 up = Vector3.UnitY();
        Vector3 right = Vector3.cross(_forward, up).unit_vector();
        up = Vector3.cross(right, _forward).unit_vector();
        Matrix4 r = new Matrix4(right, up, _forward.mult(-1));
        r.set(3, 3, 1.0f);
        Matrix4 tranE = Matrix4.Trans(pos.mult(-1));
        worldView = r.mult(tranE);
    }
}
