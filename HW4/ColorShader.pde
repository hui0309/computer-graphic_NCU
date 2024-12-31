public class PhongVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];
        
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];

        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }

        Vector4[][] result = { gl_Position, w_position, w_normal };

        return result;
    }
}

public class PhongFragmentShader extends FragmentShader {
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];
        Vector3 w_position = (Vector3) varying[1];
        Vector3 w_normal = (Vector3) varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Light light = basic_light;
        Camera cam = main_camera;

        // TODO HW4
        // In this section, we have passed in all the variables you need.
        // Please use these variables to calculate the result of Phong shading
        // for that point and return it to GameObject for rendering
        
        //ambient
        // Vector3 ambient;

        //diffusion
        Vector3 norm = w_normal.unit_vector();
        Vector3 lightDir = (light.transform.position.sub(position)).unit_vector();
        float diff = max(Vector3.dot(norm, lightDir), 0.0);
        Vector3 diffuse = light.light_color.mult(diff * kdksm.x * light.intensity);

        //specular
        Vector3 viewDir = (cam.transform.position.sub(w_position)).unit_vector();
        Vector3 reflectDir = norm.mult(2 * Vector3.dot(lightDir, norm)).sub(lightDir);

        float spec = pow(max(Vector3.dot(viewDir, reflectDir), 0.0), kdksm.z);
        Vector3 specular = light.light_color.mult(spec * kdksm.y * light.intensity);

        Vector3 result = (diffuse.add(specular)).product(albedo);

        return result.getVector4();
    }
}

public class FlatVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        // 以三角形向量著色
        Vector3 normal = Vector3.cross(
            aVertexPosition[1].sub(aVertexPosition[0]),
            aVertexPosition[2].sub(aVertexPosition[0])
        ).unit_vector();
        Vector3[] aVertexNormal = new Vector3[3];
        for(int i = 0; i < 3; aVertexNormal[i] = normal, ++i);
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];

        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];

        // TODO HW4
        // Here you have to complete Flat shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note: Here the first variable must return the position of the vertex.
        // Subsequent variables will be interpolated and passed to the fragment shader.
        // The return value must be a Vector4.

        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }

        Vector4[][] result = { gl_Position, w_position, w_normal };
        return result;
    }
}

public class FlatFragmentShader extends FragmentShader {
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];
        Vector3 w_position = (Vector3) varying[1];
        Vector3 w_normal = (Vector3) varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Light light = basic_light;
        Camera cam = main_camera;

        // TODO HW4
        // Here you have to complete Flat shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note : In the fragment shader, the first 'varying' variable must be its
        // screen position.
        // Subsequent variables will be received in order from the vertex shader.
        // Additional variables needed will be passed by the material later.D
        //ambient
        // Vector3 ambient;
        //diffusion
        Vector3 norm = w_normal.unit_vector();
        Vector3 lightDir = (light.transform.position.sub(position)).unit_vector();
        float diff = max(Vector3.dot(norm, lightDir), 0.0);
        Vector3 diffuse = light.light_color.mult(diff * kdksm.x * light.intensity);

        //specular
        Vector3 viewDir = (cam.transform.position.sub(w_position)).unit_vector();
        Vector3 reflectDir = norm.mult(2 * Vector3.dot(lightDir, norm)).sub(lightDir);
        float spec = pow(max(Vector3.dot(viewDir, reflectDir), 0.0), kdksm.z);
        Vector3 specular = light.light_color.mult(spec * kdksm.y * light.intensity);

        Vector3 result = (diffuse.add(specular)).product(albedo);

        return result.getVector4();
    }
}

public class GouraudVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0]; // 頂點位置數組
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];   // 頂點法向量數組
        Matrix4 MVP = (Matrix4) uniform[0];                   // MVP 矩陣
        Matrix4 M = (Matrix4) uniform[1];                     
        Vector3 albedo = (Vector3) uniform[2];                // albedo
        Vector3 kdksm = (Vector3) uniform[3];                 // 材質屬性：k_d, k_s, shininess

        Light light = basic_light;
        Camera cam = main_camera;

        Vector4[] gl_Position = new Vector4[3]; 
        Vector4[] vertexColor = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];

        // TODO HW4
        // Here you have to complete Gouraud shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.
        // Note: Here the first variable must return the position of the vertex.
        // Subsequent variables will be interpolated and passed to the fragment shader.
        // The return value must be a Vector4.
        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
            
            //diffusion
            Vector3 norm = w_normal[i].xyz().unit_vector();
            Vector3 lightDir = (light.transform.position.sub(gl_Position[i].xyz())).unit_vector();
            float diff = max(Vector3.dot(norm, lightDir), 0.0);
            Vector3 diffuse = light.light_color.mult(diff * kdksm.x * light.intensity);

            //specular
            Vector3 viewDir = (cam.transform.position.sub(w_position[i].xyz())).unit_vector();
            Vector3 reflectDir = norm.mult(2 * Vector3.dot(lightDir, norm)).sub(lightDir);
            float spec = pow(max(Vector3.dot(viewDir, reflectDir), 0.0), kdksm.z);
            Vector3 specular = light.light_color.mult(spec * kdksm.y * light.intensity);

            vertexColor[i] = (diffuse.add(specular)).product(albedo).getVector4();
        }

        Vector4[][] result = { gl_Position, vertexColor };

        return result;
    }
}

public class GouraudFragmentShader extends FragmentShader {
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];
        Vector3 vectexColor = (Vector3) varying[1];
        // TODO HW4
        // Here you have to complete Gouraud shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note : In the fragment shader, the first 'varying' variable must be its
        // screen position.
        // Subsequent variables will be received in order from the vertex shader.
        // Additional variables needed will be passed by the material later.

        return vectexColor.getVector4();
    }
}
