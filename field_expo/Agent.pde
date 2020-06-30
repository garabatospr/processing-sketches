

class Agent 
{
  PVector p, pOld;
  PVector direction;
  PVector rangeX, rangeY;
  float   stepSize, angle;
  float   noiseScale;
  float   noiseStrength;
  boolean isOutside = false;
  color   myStroke;
  float   strokeWidth;


  Agent() 
  {
    p = new PVector(random(border,width-border),random(border,height-border));
    rangeX = new PVector(border,width-border); 
    rangeY = new PVector(border,height-border); 
    pOld = new PVector(p.x,p.y);
    direction = new PVector(random(-1,1),random(-1,1));
    noiseScale = 200;
    noiseStrength = 20;
    stepSize = random(10,20);
    color temp = myRandom(colors,colorW);
    myStroke = color(hue(temp) + randomGaussian()*10,
                     saturation(temp) + randomGaussian()*10,
                     brightness(temp) - 10,
                     random(10,100));
    strokeWidth = random(0,10);
  }

  void display()
  {
  
    angle = noise(p.x/noiseScale,p.y/noiseScale) * noiseStrength;

    p.x += cos(angle) * stepSize*direction.x;
    p.y += sin(angle) * stepSize*direction.y;

    if(p.x < rangeX.x) isOutside = true;
    else if(p.x > rangeX.y) isOutside = true;
    else if(p.y < rangeY.x) isOutside = true;
    else if(p.y > rangeY.y) isOutside = true;

    if (isOutside) 
    {
      p.x = random(0,width);
      p.y = random(0,height);
      pOld.set(p);
    }

    strokeWeight(strokeWidth*stepSize);
    stroke(myStroke); 
    strokeWeight(strokeWidth);

    line(pOld.x,pOld.y, p.x,p.y);
   
    pOld.set(p);

    isOutside = false;
  }
 }
