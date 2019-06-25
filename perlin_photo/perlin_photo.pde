int nShapes = 20;

int nIterations = 1000;

int shapeSize = 500;

PImage img; 

PShape[] s = new PShape[nShapes]; 

void settings() 
{
  size(1080,1350,P3D);  
}


void setup() 
{

  img = loadImage("monalisa.png");

  textureMode(IMAGE);

  colorMode(HSB,360,100,100,100);

  background(360);
  
  int border = 10;

  for(int i = 0; i < s.length;i++)
  {
      s[i] = mySquare(random(border,width - border),random(border,height - border));
  }


  image(img,0,0);

  shape(s[0]);

}

// PShape 

PShape mySquare(float xCenter,float yCenter)
{ 

  PShape s;


  float sizeX = random(0,shapeSize);
  float sizeY = random(0,shapeSize);

  // vertices of the square 

  PVector p1 = new PVector(xCenter + sizeX,yCenter + sizeY);
  PVector p2 = new PVector(xCenter + sizeX,yCenter - sizeY);
  PVector p3 = new PVector(xCenter - sizeX,yCenter - sizeY);
  PVector p4 = new PVector(xCenter - sizeX,yCenter + sizeY);

  // number of interpolated points 

  float nPoints = 2000;

  //strokeWeight(1);

  noStroke();

  //noFill();
   
  s = createShape();

  s.beginShape();

  s.texture(img);

  // generate additional vertices for each edge 
 
  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p1.x,p2.x,i/nPoints);
    float y = lerp(p1.y,p3.y,i/nPoints);
    s.vertex(x,y,x,y);
  }


  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p2.x,p3.x,i/nPoints);
    float y = lerp(p2.y,p3.y,i/nPoints);
    s.vertex(x,y,x,y);
  }


  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p3.x,p4.x,i/nPoints);
    float y = lerp(p3.y,p4.y,i/nPoints);
    s.vertex(x,y,x,y);
  }


  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p4.x,p1.x,i/nPoints);
    float y = lerp(p4.y,p1.y,i/nPoints);
    s.vertex(x,y,x,y);
  }

  s.endShape(CLOSE);

  return s;

}


// distort square withe Perline noise 

PShape distortShape(PShape s)
{

  float tx = 0.1;
  float ty = 100000;

  for(int i = 0;i < s.getVertexCount();i++)
  {
    PVector v = s.getVertex(i);
    float xNoise = map(noise(tx),0,1,-5,5);
    float yNoise = map(noise(ty),0,1,-5,5);
    v.x += xNoise % width;
    v.y += yNoise % height;
    s.setVertex(i,v);
    tx += 0.005;
    ty += 0.005;
  }

  return s;
}

void draw() 
{

    // show original image as background 

    image(img,0,0);

    if(frameCount > nIterations)
    {
      noLoop();
    }


   for(int i=0;i < s.length;i++)
   {
     s[i]= distortShape(s[i]);
     shape(s[i],0,0);
   }

   saveFrame("frames/####.png");
}
