import megamu.mesh.*;

// "mesh_delaunay" by garabatospr 
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution 
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.  
// If you do use it,I would like to see what you did. 
// Send me an email to mecobi@gmail.com

// image 

PImage img; 

// number of sampling points 

int np = 10000;

float[][] points = new float[np][2];

Delaunay myDelaunay;

int inx = 0;

String fileName;

void settings()
{
  fileName = "samurai";
  img=loadImage("imagenes/" + fileName + ".png");
  size(img.width,img.height);
}

void setup()
{
  //noLoop();
  smooth(5);
}

/////////////////////////////
// rectangular grid of points 
/////////////////////////////

void drawOnePiece(float xmin,float xmax,float ymin,float ymax)
{
  for(int i=0;i < np;i++)
  {

    float x = random(xmin,xmax);
    float y = random(ymin,ymax); 

    points[i][0] = x;
    points[i][1] = y;
  }
  
  drawDelaunay(points);

}




void draw()
{

  background(0);

  noStroke();

  if(inx > 10) 
  { 
     noLoop(); 
  } 

  
  float xPos = 0;
  float yPos = width/4;

  float borde = -1;

  int gridSize = 8;

  for(int i=0;i < gridSize; i++)
  {
    for(int j=0;j < gridSize;j++)
    {
      drawOnePiece(i*width/gridSize + borde,(i+1)*width/gridSize - borde,j*height/gridSize + borde ,(j+1)*height/gridSize - borde);
    }
  }

  saveFrame("samurai_" + "delaunay"+ ".png");

  inx++;

}

void drawDelaunay(float points[][])
{

  myDelaunay = new Delaunay( points );

  float[][] myEdges = myDelaunay.getEdges();

  strokeWeight(0.01);


  for(int i=0;i < np;i++)
  {

    beginShape();

    float p1X = myEdges[i][0];
    float p1Y = myEdges[i][1]; 

    float p2X = myEdges[i + 1][0];
    float p2Y = myEdges[i + 1][1];

    float p3X = myEdges[i + 2][0];
    float p3Y = myEdges[i + 2][1];

    int centroideX = floor((p1X + p2X + p3X)/3.0);
    int centroideY = floor((p1Y + p2Y + p3Y)/3.0);

    vertex(p1X,p1Y);
    vertex((p1X + p2X)/2,(p1Y + p2Y)/2);
    vertex(p2X,p2Y); 
    vertex((p2X + p3X)/2,(p2Y + p3Y)/2);
    vertex (p3X,p3Y);

    endShape(CLOSE);

    fill(img.get(centroideX,centroideY));

  }


}
