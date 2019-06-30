
// "perlin_line" by garabatospr 
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution 
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.  
// If you do use it,I would like to see what you did. 
// Send me an email to mecobi@gmail.com


int nShapes = 1;

int nIterations = 2000;

int shapeSize = 500;

int nPoints = 2000;


float tempX = 0.001;
float tempY = 10000.0;

PImage img; 

PShape[] s = new PShape[nShapes]; 

float[] tx = new float[nShapes];
float[] ty = new float[nShapes];

void settings() 
{
  size(1000,1000);

  for(int i=0;i < nShapes;i++)
  {
    tx[i] = random(0,1);
    ty[i] = random(1000,10000);
  }

  smooth(10);
}


void setup() 
{

  frameRate(30);

  colorMode(HSB,360,100,100,100);

  background(0);

  float border = 500;

  for(int i = 0; i < s.length;i++)
  {
      s[i] = myLine(-10,random(border,height - border),nPoints);
  }

}

// PShape 

PShape myLine(float xCenter,float yCenter,int nPoints)
{ 

  PShape s;

  strokeWeight(0.1);

  float step = (2.0*shapeSize)/nPoints;

  s = createShape();

  //noFill();

  s.beginShape();

  // generate additional vertices for each edge 
 
  for(float y=-shapeSize; y < shapeSize; y+=step)
  {
    s.vertex(xCenter,yCenter + y);
  }



  s.endShape(CLOSE);

  return s;

}


// distort line with Perlin noise 

PShape distortShape(PShape s,float tx,float ty)
{

  for(int i = 0;i < s.getVertexCount();i++)
  {
    PVector v = s.getVertex(i);
    float xNoise = map(noise(tx),0,1,-5,5);
    float yNoise = map(noise(ty),0,1,-5,5);
    float sign = sin(0.05*frameCount);
    v.x += sign*(xNoise % width);
    v.y += sign*(yNoise % height);
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

   // displace line and distort 

   for(int i=0;i < s.length;i++)
   {
    s[i]= distortShape(s[i],tx[i],ty[i]);
    float xNoise = map(noise(tempX),0,1,0,5);
    float yNoise = map(noise(tempY),0,1,-100,100);
    s[i].translate(2 + cos(xNoise),cos(yNoise));
    shape(s[i],0,0);
   }
    
   tempX += 0.05;
   tempY += 0.05;

   //saveFrame("frames_random4/####.png");
}
