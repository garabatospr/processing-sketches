
// "field_expo" by garabatospr
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.
// If you do use it,I would like to see what you did.
// Send me an email to mecobi@gmail.com


// color palette 

color[] colors  = {#ff0000,#feb30f,#0aa4f7,#9ca2b0,#000000,#ffffff};


// weights for each color 

float[] colorW  = {3,3,3,3,8,8};
color myBackground;

// picture frame 

int border = 100;

Agent[] agents = new Agent[10000]; 

int agentsCount = 5000;

void settings()
{
  size(1350,1080,P2D);
  smooth(8);
}


void setup(){

  colorMode(HSB,360,100,100,100);

  myBackground = color(0,0,100);

  background(myBackground);

  strokeCap(SQUARE);

  for(int i=0; i<agents.length; i++) 
  {
    agents[i] = new Agent();
  }

}


void draw()
{

  // display agents 
  
  for(int i=0; i<agentsCount;i++)
  {
    agents[i].display();
  } 
  
  
  // draw picture frame 
  
  noFill();
  stroke(color(0,0,0));
  strokeWeight(50);
  rect(border,border,width - border*2,height - border*2);

 
  saveFrame("frames/####.png");

  if (frameCount > 1000)
  {
    noLoop();
  }

}


//////////////////////////////////////////////////////////
// select colors from color palettes with specific weights
//////////////////////////////////////////////////////////

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
