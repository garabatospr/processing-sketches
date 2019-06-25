// "perlin_square" by garabatospr 
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution 
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.  
// If you do use it,I would like to see what you did. 
// Send me an email to mecobi@gmail.com

int nShapes = 1;

int nIterations = 300;

int shapeSize = 250;

PImage img; 

PShape[] s = new PShape[nShapes]; 

void settings() 
{
  size(1000,1000);  
}


void setup() 
{

  colorMode(HSB,360,100,100,100);

  background(360);

  for(int i = 0; i < s.length;i++)
  {
      s[i] = mySquare(width/2,height/2);
  }

}

// PShape 

PShape mySquare(float xCenter,float yCenter)
{ 

  PShape s;


  float sizeX = shapeSize;
  float sizeY = shapeSize;

  // vertices of the square 

  PVector p1 = new PVector(xCenter + sizeX,yCenter + sizeY);
  PVector p2 = new PVector(xCenter + sizeX,yCenter - sizeY);
  PVector p3 = new PVector(xCenter - sizeX,yCenter - sizeY);
  PVector p4 = new PVector(xCenter - sizeX,yCenter + sizeY);

  // number of interpolated points 

  float nPoints = 1000;

  strokeWeight(1);

  s = createShape();

  s.beginShape();

  // generate additional vertices for each edge 
 
  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p1.x,p2.x,i/nPoints);
    float y = lerp(p1.y,p3.y,i/nPoints);
    s.vertex(x,y);
  }


  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p2.x,p3.x,i/nPoints);
    float y = lerp(p2.y,p3.y,i/nPoints);
    s.vertex(x,y);
  }


  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p3.x,p4.x,i/nPoints);
    float y = lerp(p3.y,p4.y,i/nPoints);
    s.vertex(x,y);
  }


  for(int i=0;i <= nPoints;i++)
  {
    float x = lerp(p4.x,p1.x,i/nPoints);
    float y = lerp(p4.y,p1.y,i/nPoints);
    s.vertex(x,y);
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
    tx += 0.05;
    ty += 0.05;
  }

  return s;
}

void draw() 
{

    if(frameCount > nIterations)
    {
      noLoop();
    }


   for(int i=0;i < s.length;i++)
   {
     s[i]= distortShape(s[i]);
     shape(s[i],0,0);
   }
}
