 //mouse pressing action
  int fractal = -1;
  // Length of the largest triangle
  float length1 = 800;
  // Height of largest triangle with side length of 1
  float height1 = sqrt(3) / 2;
  float x1=0;
  float y1=height1 * length1;
  float x2=length1 / 2;
  float y2=0;
  float x3=length1;
  float y3=height1 * length1;
  
  // Height of each iteration is half the height of the previous
  // Number of triangles drawn increases by 3^n
  boolean once = true;
  public void setup() {
    //size of the new window 
    size(1000, 1000);
    background(255);
  }

  public void draw() {
    //draw triangle in the middle of the window
    
    translate(100, 50);

    // PImage background = loadImage("JpvpTYA.png");
    // image(background,0,0);
    //if (once){
     stroke(100);
     fill(255,0,0);
     
      //SierpinskiFractal(0, height1 * length1, length1 / 2, 0, length1, height1 * length1, fractal);
   
    //once=!once;
    //}
      //LEFT: fractal+=1;
     // SierpinskiFractal((x1+x2)/2,(y1+y2)/2,(x2+x3)/2,(y2+y3)/2,(x3+x1)/2,(y3+y1)/2, fractal);
  
  }
    
    
    
    //increase fractal when mouse is pressed
    

  
  public void SierpinskiFractal(float x1, float y1, float x2, float y2, float x3, float y3, int fract){
    
    if (fract <= fractal){
      stroke(255);
      fill(40,40,200);
      triangle(x1, y1, x2, y2, x3, y3);
      
      float Xx = (x1+x2)/2;//(length1 / 2) / 2;
      float Xy = (y1+y2)/2;//(height1 * length1) / 2;
      float Yx = (x2+x3)/2;//(length1 + length1 / 2) / 2;
      float Yy = (y2+y3)/2;//(height1 * length1) / 2;
      float Zx = (x1+x3)/2;//(length1) / 2;
      float Zy = (y1+y3)/2;//height1 * length1;
      
      SierpinskiFractal(x2, y2, Xx, Xy, Yx, Yy, fract+1);
      SierpinskiFractal(x1, y1, Xx, Xy, Zx, Zy,fract+1);
      SierpinskiFractal(Zx, Zy, Yx, Yy, x3, y3,fract+1);

    }
    
  }
  void keyPressed(){
    if (key=='r'){
      if (fractal>-1){
      background(255);
      fractal=fractal-1;
    SierpinskiFractal(0, height1 * length1, length1 / 2, 0, length1, height1 * length1, 0);
    }
    }
  }
  void mousePressed(){
    fractal=fractal+1;
    SierpinskiFractal(0, height1 * length1, length1 / 2, 0, length1, height1 * length1, 0);
  }
  void mouseReleased(){
  }