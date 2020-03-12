// "automatismo" by garabatospr
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.
// If you do use it,I would like to see what you did.
// Send me an email to mecobi@gmail.com

import nice.palettes.*;

ColorPalette palette;

int iteration = 100;

float border = 100;


int nCircles    = 5;  

int nRectangles = 10;

int nTriangles  = 10;  

int nLines      = 10;

int nText       = 10; 


void settings()
{
  size(1000,1000,P2D);
  smooth(8);
}

void setup() 
{

  colorMode(HSB,360,100,100,100);

  rectMode(CENTER);

  palette = new ColorPalette(this);

  background(0,0,100);

}

void draw()
{

  palette.getPalette();


  for(int i=0; i < palette.colors.length;i++)
  {
    float h = hue(palette.colors[i]);
    float s = saturation(palette.colors[i]);
    float b = brightness(palette.colors[i]);
  }

  background(0,0,100);
  

  if (frameCount >= iteration)
  {
    noLoop();
  }

  float objectSize = 200;

  float centroX = width/2 + randomGaussian()*50;
  float centroY =height/2 + randomGaussian()*50;

  pushMatrix();


  for(int i=0;i < nCircles;i++)
  {
    myCircle(centroX + randomGaussian()*border,centroX + randomGaussian()*border,objectSize); 
  }


  for(int i=0;i < nRectangles;i++)
  {
    myRectangle(centroX + randomGaussian()*border,centroX + randomGaussian()*border,objectSize); 
  }


  for(int i=0;i < nLines;i++)
  {
    myLine(centroX + randomGaussian()*border,centroY + randomGaussian()*border); 
  }


  for(int i=0;i < nTriangles;i++)
  {
    myTriangle(centroY + randomGaussian()*border,centroY + randomGaussian()*border); 
  }


  for(int i=0;i < nText;i++)
  {
    myText(centroY + randomGaussian()*border/2,centroY + randomGaussian()*border/2); 
  }


  popMatrix();

  saveFrame("automatic-######.png");


}


// draw Triangle 

void myTriangle(float xPos,float yPos)
{

  fill(palette.colors[(int)random(4)]);
  pushMatrix();
  translate(xPos,yPos);
  scale(20);
  rotate(random(0,2*PI)); 
  strokeWeight(random(0.1,0.5));
  if (random(0,1.0) < 0.5)
  {
    noFill();
  }
  triangle(random(-5,5),random(-5,5),random(-5,5),random(-5,5),random(-5,5),random(-5,5));
  popMatrix();
}


// draw Line 

void myText(float xPos,float yPos)
{
  pushMatrix();
  translate(xPos,yPos);
  fill(palette.colors[(int)random(4)]);
  textSize(random(100,200));
  textAlign(CENTER);
  char c = (char) int(random(33, 127));
  text(c,0,0);
  popMatrix();
}

// draw Line 

void myLine(float xPos,float yPos)
{
  pushMatrix();
  translate(xPos,yPos);
  scale(random(1,4));
  rotate(random(0,2*PI));
  noStroke();
  fill(palette.colors[(int)random(4)]);
  rect(-20,-20,random(1,5),random(70,100)); 
  popMatrix();
}


// draw Circle 

void myCircle(float xPos,float yPos,float objectSize)
{

  pushMatrix();
  translate(xPos,yPos);
  noStroke();
  stroke(palette.colors[(int)random(4)]);
  fill(palette.colors[(int)random(4)]);
  strokeWeight(random(5,15));
  float rad = objectSize*randomGaussian();
  ellipse(0,0,rad,rad);
  popMatrix();
}


// draw Rectangle 

void myRectangle(float xPos,float yPos,float objectSize)
{

  noStroke();
  stroke(palette.colors[(int)random(4)]);
  fill(palette.colors[(int)random(4)]);
  if (random(0,1.0) < 0.5)
  {
    noFill();
  }
  strokeWeight(random(0.1,5));
  float rad = objectSize*randomGaussian();
  rect(xPos,yPos,rad,rad);
}


