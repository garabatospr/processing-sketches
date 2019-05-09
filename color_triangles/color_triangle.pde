import megamu.mesh.*;
import com.cage.colorharmony.*;

// "color_triangle" by Elio Ramos (aka garabatospr)
// Licensed under Creative Commons Attribution
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.
// If you do use it,I would like to see what you did.
// Send me an email to mecobi@gmail.com



ColorHarmony colorHarmony = new ColorHarmony(this);

color[] colors = new color[8];

PImage img; 

int np = 10000;

int nTriangles = np;

float[][] points;

Triangle[] triangles;

//float xPos,yPos;

// triangle class

class Triangle {

  PVector vertex1,vertex2,vertex3;

  PVector centroid;

  Triangle(PVector vertex1In,PVector vertex2In,PVector vertex3In,PVector centroidIn) {

    vertex1 = vertex1In;
    vertex2 = vertex2In;
    vertex3 = vertex3In;
    centroid = centroidIn;
  }

  PVector getVertex1() {
    return vertex1;
  }

  PVector getVertex2() {
    return vertex2;
  }

  PVector getVertex3() {
    return vertex3;
  }

  PVector getCentroid() {
    return centroid;
  }

  void drawTriangle() {
    beginShape();
      fill(colors[(int)random(8)]);
      vertex(vertex1.x,vertex1.y);
      vertex(vertex2.x,vertex2.y);
      vertex(vertex3.x,vertex3.y); 
    endShape(CLOSE);
  }



}

Delaunay myDelaunay;

int inx = 0;
int inxTriangle = 0; 


void setup()
{ 
  colors = colorHarmony.Complementary("33C4FF");
 
  size(800,800);
  background(0); 
  //noLoop();
  smooth(20);
}


// construct a circular grid with center and radius


void circularGrid(float xCenter, float yCenter,float rad) 
{

 points     = new float[np][2];

 float theta0 = 0.01;
 float theta1 = 2*PI;
 float dtheta = (theta1 - theta0)/50.0;
 int   ntheta = floor((theta1 - theta0)/dtheta); 


 float r0 = 0;
 float r1  = rad;
 float dr  = (r1 - r0)/(np/ntheta);

 float drad = float(ntheta)/np;

 int ip = 0;

 for(float ang = theta0; ang < theta1; ang+= dtheta)
 {
   for(float r= r0;r< r1;r+=dr)
   {

      float x = xCenter + r*cos(ang);
      float y = yCenter + r*sin(ang); 

      if (ip > np - 1)
      {
        break; 
      }

      points[ip][0] = x;
      points[ip][1] = y;

      ip++;
   }
}

  drawDelaunay(points);

}


// draw one rectangular piece


void drawOnePiece(float xmin,float xmax,float ymin,float ymax)
{

  points     = new float[np][2];

  float borde = 10;

  for(int i=0;i < np;i++)
  {

    float x = random(xmin - borde,xmax + borde);
    float y = random(ymin - borde,ymax + borde);

    points[i][0] = x;
    points[i][1] = y; 
  }

  drawDelaunay(points);

}

void draw()
{

  if (frameCount > 20)
  {
    noLoop();
  }

  background(0);

  float borde = 1;

  int gridSizeX = 1;
  int gridSizeY = 1;

  for(int i=0;i < gridSizeX; i++)
  {
    for(int j=0;j < gridSizeY;j++)
    {
      drawOnePiece(i*width/gridSizeX + borde,(i+1)*width/gridSizeY - borde,j*height/gridSizeX + borde ,(j+1)*height/gridSizeY - borde); 
      colorTriangles();
    }
  }

  //saveFrame("palette"+"-#####.png");

  /* for(int i=0;i < 100;i++) */
  /* { */
  /*   float tempX = random(0,width); */
  /*   float tempY = random(0,height); */
  /*   float radMin = 100; */
  /*   float radMax = 500; */
  /*   float rad    = random(radMin,radMax); */
  /*   circularGrid(tempX,tempY,rad); */
  /*   colorTriangles(); */
  /* } */ 

  inx++;
}


// draw a color each triangle 

void colorTriangles()
{
  for(int i=0;i < nTriangles;i++)
  {
    triangles[i].drawTriangle();
    PVector centroid = triangles[i].getCentroid();
    //fill(255);
    //float temp = random(0,10);
    /* line(centroid.x,centroid.y,centroid.x + randomGaussian(),centroid.y + randomGaussian()); */
  }
}


// draw delaunay 

void drawDelaunay(float points[][])
{

  myDelaunay = new Delaunay( points );

  triangles = new Triangle[nTriangles];

  float[][] myEdges = myDelaunay.getEdges();

  for(int i=0;i < np;i++)
  {

    beginShape();

    float p1X = myEdges[i][0];
    float p1Y = myEdges[i][1]; 

    float p2X = myEdges[i + 1][0];
    float p2Y = myEdges[i + 1][1];

    float p3X = myEdges[i + 2][0];
    float p3Y = myEdges[i + 2][1];

    PVector v1 = new PVector(p1X,p1Y);
    PVector v2 = new PVector(p2X,p2Y);
    PVector v3 = new PVector(p3X,p3Y);  
 
    int centroidX = floor((p1X + p2X + p3X)/3.0);
    int centroidY = floor((p1Y + p2Y + p3Y)/3.0);

    PVector centroid = new PVector(centroidX,centroidY);

    triangles[i] = new Triangle(v1,v2,v3,centroid);

    vertex(p1X,p1Y);
    vertex(p2X,p2Y); 
    vertex(p3X,p3Y);

    endShape(CLOSE);

    //noStroke();

    strokeWeight(0.1); 
    stroke(0); 
}}

