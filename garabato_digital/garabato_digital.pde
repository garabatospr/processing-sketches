
// "garabato_digital" by garabatospr
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.
// If you do use it,I would like to see what you did.
// Send me an email to mecobi@gmail.com


PShape s;

PImage img;

int border  = 0;
int square  = 10;
int nFrames = 100;
float step  = 10;

float rad = 10;

void settings()
{
  size(800,800,P2D);
  smooth(8);
}

color colors[] = {#21243D,#FF7C7C,#FFD082,#88E1F2};

void setup()
{
  colorMode(HSB,360,100,100,100);
  background(360);
}

void draw()
{

  noStroke();

  walk(random(border,width-border),random(border,height-border));
  
  shape(s,0,0);


  if (frameCount > nFrames)
  {
    noLoop();
     
    strokeWeight(30);
    noFill();
    stroke(0);
    rect(square,square,width - square*2,height - square*2);

    int rimage = int(random(0,1000));

    for(int i=0;i < 5;i++)
    {
     strokeWeight(5);
     stroke(0);
     float tt1 = random(square*2,height-square*2);
     float tt2 = random(square*2,height-square*2);
     line(0,tt1,width,tt1);
     line(tt2,0,tt2,height);
    }

    save(rimage + ".png");
  }


}


void walk(float x,float y)
{

  s = createShape();

  s.setStrokeWeight(random(1,2));
   
  s.beginShape();

  color tempColor = colors[int(random(0,4))];

  float tH = hue(tempColor);
  float tS = saturation(tempColor) + randomGaussian()*10;
  float tB = brightness(tempColor);

  s.fill(color(tH,tS,tB),random(10,100));

  s.stroke(color(tH,tS,tB),random(10,100));
 
  float ang = 0.0;

  while(ang <= 2*PI)
  {
  
    x = x + step*cos(ang);
    y = y + step*sin(ang);

    s.curveVertex(x + randomGaussian()*30,y + randomGaussian()*30); 

    ang += 0.1;
  }

  s.endShape(CLOSE);

}
