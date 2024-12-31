import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;

public Vector4 renderer_size;
static public float GH_FOV = 45.0f;
static public float GH_NEAR_MIN = 1e-3f;
static public float GH_NEAR_MAX = 1e-1f;
static public float GH_FAR = 1000.0f;
static public Vector3 AMBIENT_LIGHT = new Vector3(0.3, 0.3, 0.3);

public boolean debug = false;

public float[] GH_DEPTH;
public PImage renderBuffer;

Engine engine;
Camera main_camera;
Vector3 cam_position;
Vector3 lookat;

Light basic_light;

void setup() {
    size(1000, 600);
    renderer_size = new Vector4(20, 50, 520, 550);
    lookat = new Vector3(0, 0, 0);
    setDepthBuffer();
    main_camera = new Camera();
    cam_position = main_camera.transform.position;
    engine = new Engine();
    engine.renderer.addGameObject(basic_light);
    engine.renderer.addGameObject(main_camera);

}

void setDepthBuffer(){
    renderBuffer = new PImage(int(renderer_size.z - renderer_size.x) , int(renderer_size.w - renderer_size.y));
    GH_DEPTH = new float[int(renderer_size.z - renderer_size.x) * int(renderer_size.w - renderer_size.y)];
    for(int i = 0 ; i < GH_DEPTH.length;i++){
        GH_DEPTH[i] = 1.0;
        renderBuffer.pixels[i] = color(1.0*250);
    }
}

void draw() {
    // backGouraud(255);

    engine.run();
    // cameraControl();
}

String selectFile() {
    JFileChooser fileChooser = new JFileChooser();
    fileChooser.setCurrentDirectory(new File("."));
    fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
    FileNameExtensionFilter filter = new FileNameExtensionFilter("Obj Files", "obj");
    fileChooser.setFileFilter(filter);

    int result = fileChooser.showOpenDialog(null);
    if (result == JFileChooser.APPROVE_OPTION) {
        String filePath = fileChooser.getSelectedFile().getAbsolutePath();
        return filePath;
    }
    return "";
}

// void cameraControl() {
//     // TODO HW3 (Optional)
//     // You can write your own camera control function here.
//     // Use setPositionOrientation(Vector3 position,Vector3 lookat) to modify the
//     // ViewMatrix.
//     // Hint : Use keyboard event and mouse click event to change the position of the
//     // camera.     
//     float movSpeed = 0.5f;
//     float maxX = 20.0f;
//     float maxY = 20.0f;
//     float maxZ = 0.0f;
//     float minX = -20.0f;
//     float minY = -20.0f;
//     float minZ = -20.0f;

//     if(keyPressed){
//         if(key == 'X'){
//             cam_position.x = min(cam_position.x + movSpeed, maxX);
//         }
//         if(key == 'x'){
//             cam_position.x = max(cam_position.x - movSpeed, minX);
//         }
//         if(key == 'Y'){
//             cam_position.y = min(cam_position.y + movSpeed, maxY);
//         }
//         if(key == 'y'){
//             cam_position.y = max(cam_position.y - movSpeed, minY);
//         }
//         if(key == 'Z'){
//             cam_position.z = min(cam_position.z + movSpeed, maxZ);
//         }
//         if(key == 'z'){
//             cam_position.z = max(cam_position.z - movSpeed, minZ);
//         }
//         if(key == 'W'){
//             cam_position.z = min(cam_position.z + movSpeed, maxZ);
//         }
//         if(key == 'w'){
//             cam_position.z = max(cam_position.z - movSpeed, minZ);
//         }
//          if(key == 'X'){
//             cam_position.x = min(cam_position.x + movSpeed, maxX);
//         }
//         if(key == 'x'){
//             cam_position.x = max(cam_position.x - movSpeed, minX);
//         }
//     }
//     main_camera.setPositionOrientation(cam_position, new Vector3(0,0,1));
// }
