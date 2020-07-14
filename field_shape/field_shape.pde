 
 // color palette 
 
 color[] colors  = {#ff0000,#feb30f,#0aa4f7,#9ca2b0,#000000,#ffffff};
 
 // weights for each color 
  
float[] colorW = {1,2,5,1,1,1};

int border = 0;

int nShapes = 5000;

int nVertex = 1000;

void settings() 
{
  size(800,800,P2D);
  smooth(8);
}

void setup()
{
  colorMode(HSB,360,100,100,100);

  color myBackground = color(0,0,100);

  background(myBackground);

  noLoop();

}

void draw()
{

  for(int i=0;i < nShapes;i++)
  {

     color temp1 = myRandom(colors, colorW);
     
     color myFill= color(hue(temp1) + randomGaussian()*5, 
                         saturation(temp1) + randomGaussian()*5, 
                         brightness(temp1) - 10, 
                         random(10, 100));


     color temp2 = myRandom(colors, colorW);
     
     color myStroke = color(hue(temp2) + randomGaussian()*5, 
                            saturation(temp2) + randomGaussian()*5, 
                            brightness(temp2) - 10, 
                            random(10, 100));

    fill(myFill);
    stroke(myStroke);
    fieldShape(new PVector(random(border,width - border),
                           random(border,height - border)),
                           20) ;
  }


  //save("field_shape.png");

}


void fieldShape(PVector p,float myScale)
{

  float stepSize = 1;

  strokeWeight(1);

  beginShape();

  for(int i=0;i < nVertex;i++)
  {

    p.x += vector__field(p.x,p.y,myNoise).x*stepSize;
    p.y += vector__field(p.x,p.y,myNoise).y*stepSize;
    
    vertex(p.x,p.y);
  }

  endShape();

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


 ////////////////////////
 // field vector function
 ////////////////////////


 PVector vector__field (float x, float y,float myScale) {


   x = map(x, border, width - border,  -myScale, myScale);
   y = map(y, border, height - border, -myScale, myScale);


   float u, v;

   u = sin(5*y) + cos(3*y);
   v = sin(3*x) - cos(5*x);

   return new PVector(u, v);
 }

