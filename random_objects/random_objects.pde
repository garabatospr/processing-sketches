
// "random_objects" by garabatospr
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.
// If you do use it,I would like to see what you did.
// Send me an email to mecobi@gmail.com

int iteration = 5;

int nSteps  = 200;

int nShape = 300;

int border = 10;

int time = 0;

Object[] shape;

color[] colors  = {#ff0000,#feb30f,#0aa4f7,#9ca2b0,#000000,#ffffff};
float[] colorW  = {1,2,2,2,3,6};

String[] objects  = {"square","circle","oval","rectangle"};

color myBackground; 

PVector myPos,mySize,mySpeed,myDir;

boolean myFill;


void settings()
{
  size(1350,1080,P2D);
  smooth(8);
}

void setup()
{
  rectMode(CENTER);  
  ellipseMode(CENTER);
  colorMode(HSB, 360, 100, 100,100);

}


void draw()
{

  if (frameCount > iteration)
  {
  
    noLoop();
  
  }

  if (time == 0)
  {
    
    initShape();

  }else 
  {

    setBackground();
    
    for(int i=0;i < nSteps;i++)
    { 
      showObjects();
    }

    save("objects_" + time + ".png");
  }

  time = frameCount % 200; 

}

//////////////////////////////
// set random background color
//////////////////////////////

void setBackground()
{
  myBackground = myRandom(colors,colorW); 

  background(color(hue(myBackground) + randomGaussian()*10,saturation(myBackground) + randomGaussian()*10,brightness(myBackground)-10));
}


////////////////////////////////////
// select random colors with weights
////////////////////////////////////

int myRandom(color colors[],float weights[])
{

  color tt = 0;
  float sum = 0;

  for(int i=0;i < colors.length; i++)
  {
    sum += weights[i];
  }

  float rr = random(0,sum);

  for(int j=0;j < weights.length;j++)
  {

    if (weights[j] >= rr)
    {
      return color(colors[j]);
    }
      rr -= weights[j];
  }

  return tt;

}


////////////////////
// initialize shapes
////////////////////


void initShape()
{

   shape = new Object[nShape];

   for(int i=0; i < nShape;i++)
   {
     myPos   = new PVector(random(50,width - 50),random(50,height- 50));
     mySize  = new PVector(random(1,200),random(1,200));
     mySpeed = new PVector(random(1,1),random(1,1));
     myDir   = new PVector(floor(random(-2,2)),floor(random(-2,2)));

     myFill = true;

     shape[i] = new Object(
                myPos,
                mySize,
                mySpeed,
                myDir,
                myFill);
   }

}


//////////////////////////
// move and display shapes
//////////////////////////

void showObjects()
{
 
  for(int i=0;i < nShape;i++)
  {
    shape[i].display();
    shape[i].move();
  } 
}


