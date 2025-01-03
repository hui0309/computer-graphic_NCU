# computer-graphic_HW4

## 描述
1. 這是一個3D小畫家，可供使用者對物體、攝像機及光照進行一些基本操作
2. 使用工具：上課教材、ChatGPT、補充教材

## 功能說明
1. 含有透視矯正來計算重心座標

##### 功能 1 程式碼及展示

| ![重心座標](./HW4/demo/barycentric1.png) | ![考慮透視](./HW4/demo/barycentric2.png) |
---------------------------------------|---------------------------------------|
2. Phong Shading
   - 透過頂點內插任意點向量計算任意點光照  

##### 功能 2 程式碼及展示

| ![Vertex](./HW4/demo/phongVertex.png) | ![Fragment](./HW4/demo/phongFragment.png) | ![Matrial](./HW4/demo/phongMaterial.png) |
|-------------------------------------|-------------------------------------|------------------------------------|
3. Flat Shading
   - 透過三角形方向向量計算任意點光照  

##### 功能 3 程式碼及展示

| ![Vertex](./HW4/demo/flatVertex.png) | ![Fragment](./HW4/demo/flatFragment.png) | ![Matrial](./HW4/demo/flatMaterial.png) |
|-------------------------------------|-------------------------------------|------------------------------------|

4. Gouraud Shading
   - 透過計算三角形頂點光照內插任意點光照  

##### 功能 4 程式碼及展示

| ![Vertex](./HW4/demo/gouraudVertex.png) | ![Fragment](./HW4/demo/gouraudFragment.png) | ![Matrial](./HW4/demo/gouraudMaterial.png) |
|-------------------------------------|-------------------------------------|------------------------------------|

5. 三個 shading 比較圖

| phong | flat | gouraud |
|-----------------------------------------|---------------------------------------------|--------------------------------------------|
| ![phong](./HW4/demo/phong.png)|![flat](./HW4/demo/flat.png)| ![gouraud](./HW4/demo/gouraud.png)|


## 成果展示
![示範GIF](./HW4/demo/HW4.gif)

------------------------------------------------------------------


# computer-graphic_HW3

## 描述
1. 這是一個3D小畫家，可供使用者對物體及攝像機進行一些基本操作
2. 使用工具：上課教材、ChatGPT

## 功能說明
1. 可做移動、旋轉、縮放  
   - 透過 Matrix 將物件從 Local Space 轉至 World Space  
   - 在 Homogenious Space 做空間轉換  

2. 將圖形填滿顏色  
   - 透過 Ray Casting 檢測要填滿的地方  
   - 透過物件的頂點資訊調整 Ray Casting 檢測範圍 

##### 功能 1&2 程式碼及展示

| ![物件旋轉](./HW3/demo/rotMat.png) | ![localToWorld](./HW3/demo/localToWorld.png) |
---------------------------------------|---------------------------------------|


![示範GIF](./HW3/demo/transfrom.gif)

3. 調整視野範圍 
   - 透過 Matrix 將物件從 World Space 轉至 Camera Space
   - 透過 Matrix 將物件從 Camera Space(3D) 轉至 Image Space(2D)
   - 透過按鍵可對 Camera 坐平移
      - 'X':往+x移動；'x':往-x移動
      - 'y':往+y移動；'y':往-y移動
      - 'z':往+z移動；'z':往-z移動

##### 功能 3 程式碼及展示

| ![camSpace](./HW3/demo/camSpace.png) | ![imgSpace](./HW3/demo/imgSpace.png) | ![alt text](./HW3/demo/camControl.png) |
|-------------------------------------|-------------------------------------|------------------------------------|

![示範GIF](./HW3/demo/camera.gif)

4. Depth Buffer
   - 透過計算三角形深度決定渲染的顏色 

##### 功能 4 程式碼及展示

![Depth](./HW3/demo/depth.png)

![示範GIF](./HW3/demo/depth.gif)

5. Culling
   - 計算View 及 三角形夾角判別內外 

##### 功能 5 程式碼及展示

![Culling](./HW3/demo/cullFun.png)

| ![culling](./HW3/demo/culling.png)   | ![noculling](./HW3/demo/noCulling.png) |
|-------------------------------------|---------------------------------------|
| culling                            | no culling                            |


## 成果展示
![示範GIF](./HW3/demo/HW3.gif)

------------------------------------------------------------------

# computer-graphic_HW2

## 描述
1. 這是一個2D小畫家，可供使用者繪圖，旋轉、縮放、平移，並處理了圖像不夠連續的問題。
2. 使用工具：延伸閱讀、上課教材、ChatGPT

## 功能說明
1. 可做移動、旋轉、縮放  
   - 透過 Matrix 將物件從 Local Space 轉至 World Space  
   - 在 Homogenious Space 做空間轉換  

2. 將圖形填滿顏色  
   - 透過 Ray Casting 檢測要填滿的地方  
   - 透過物件的頂點資訊調整 Ray Casting 檢測範圍  

##### 功能 1&2 程式碼及展示

| ![物件移動](./HW2/demo/transform.png) | ![Ray Casting](./HW2/demo/raycasting.png) | ![Bounding Box](./HW2/demo/boundbox.png) |
|---------------------------------------|-------------------------------------------|------------------------------------------|

![示範GIF](./HW2/demo/transfrom_raycasting.gif)

3. 偵測畫框邊緣  
   - 透過圖形線段與外框的線段判斷有無交點，修改當前繪製圖像的形狀  

##### 功能 3 程式碼及展示

| ![偵測範示 1](./HW2/demo/shAlgorithm1.png) | ![偵測範示 2](./HW2/demo/shAlgorithm1.png) |
|--------------------------------------------|--------------------------------------------|

![示範GIF](./HW2/demo/shAlgorithm.gif)

4. SSAA  
   - 做一個 2*2 的 cell 去降低邊緣不夠連續的問題  
   - 使用 checkbox 讓每個物件都可以獨立調整是否要 SSAA  
   - 這邊只是呈現我能透過該方法改善，並沒有讓它能完成騙過肉眼（計算量有點大）  

##### 功能 4 程式碼及展示

| ![SSAA 範示 1](./HW2/demo/SSAA1.png) | ![SSAA 範示 2](./HW2/demo/SSAA2.png) |
|--------------------------------------|-------------------------------------|

![示範GIF](./HW2/demo/SSAA.gif)

## 成果展示
![示範GIF](./HW2/demo/HW2.gif)

------------------------------------------------------------------

# computer-graphic_HW1

## 描述
1. 這是一個小畫家，目前支援繪製點、線以及一些基本圖案。  
2. 參考教材：上課筆記、延伸閱讀、ChatGPT

## 功能說明
1. 畫線  
   - 透過中點演算法  
   - 考慮斜率降低誤差  
![示範GIF](./HW1/demo/line.gif)

2. 畫多邊形  
![示範GIF](./HW1/demo/polygon.gif)

3. 隨意畫  
![示範GIF](./HW1/demo/pencil.gif)

4. 畫圓  
   - 透過中點演算法  
   - 透過圓的對稱性減少計算  
![示範GIF](./HW1/demo/circle.gif)

5. 畫橢圓  
   - 透過中點演算法  
   - 考慮斜率降低誤差  
   - 透過橢圓的對稱性減少計算  
![示範GIF](./HW1/demo/ellipse.gif)

6. 畫曲線  
   - 透過曲線公式  
![示範GIF](./HW1/demo/curve.gif)

7. 擦除（滾動滑鼠即可改變擦除範圍）  
![示範GIF](./HW1/demo/eraser.gif)

## 成果展示
![示範GIF](./HW1/demo/HW1.gif)
