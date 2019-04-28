/* @pjs preload="archi2.png";*/

import java.util.Random;
import java.util.Arrays;

PImage img;

float dx,dy;

float[] posX, posY;

float[] posXT, posYT;

Stripe[] stripe;

int tilesX=40, tilesY = 28;

int nStripes = (tilesX)*tilesY;

PVector textPos, objectPos;

int done; 

float speed = 0.5;




/////////////////
// setup function
/////////////////


void setup() {

    rectMode(CENTER);
	  
    img = loadImage("images/archi2.png");	

	  size(1000,700,P3D);

	  background(255);
	
    dx = width/(tilesX);
    dy = height/(tilesY);

    setTiles();

}

void setTiles()
{

    done = 0;

    stripe = new Stripe[nStripes];

    posX     = new float[nStripes];
    posY     = new float[nStripes];
    posXT    = new float[nStripes];
    posYT    = new float[nStripes];


    int[] shuffle1 = new int[nStripes];
    int[] shuffle2 = new int[nStripes];

    int shiftY= 0;

    int inx = 0;

    for(int i=0; i < tilesY;i++)
    {
      int shiftX = 0;

      for(int j=0;j < tilesX;j++)
      {
        posX[inx]  = floor(dx/2 + shiftX);
        posY[inx]  = floor(dy/2 + shiftY);
        posXT[inx] = floor(dx/2 + shiftX);
        posYT[inx] = floor(dy/2 + shiftY);
        shuffle1[inx] = inx;
        shuffle2[inx] = inx;
        shiftX += dx;
        inx++;
      }

      shiftY+= dy;
    }


   shuffleArray(shuffle1);
   shuffleArray(shuffle2);


   for(int i=0; i < nStripes;i++) 
   { 
        float tempX  = posX[shuffle1[i]];
        float tempY  = posY[shuffle1[i]];
        float tempTX = posXT[shuffle2[i]]; 
        float tempTY = posYT[shuffle2[i]];
        float speed =  random(0.01,0.5);
        float temp = random(0,0.01);
        
        stripe[i] = new Stripe(img,new PVector(tempX,tempY),new PVector(tempTX,tempTY),speed,0.01); 
    }


}


////////////////
// draw function
////////////////


void draw () {


    background(0);

    for(int i=0;i < nStripes;i++)
    {
         stripe[i].move();
         stripe[i].display(); 
    }


   if (done >= nStripes)
   {
     setTiles();
   }

}


///////////////
// square class 
///////////////

class Stripe{

	  PImage   textureName;
    PVector  texturePos;
    PVector  pos;
    float    heading;
    float    randomNumber;

		// constructor 

		Stripe(PImage textureName0,PVector texturePos0,PVector pos0,float heading0,float randomNumber0) {
      textureName = textureName0;
      texturePos  = texturePos0;
      pos   = pos0;
      heading = heading0;
      randomNumber = randomNumber0;
    }

    void switchTile()
    {
       stripe[0].pos = stripe[50].pos;
    }

		// display function 

		void display() {


      strokeWeight(2.0);

      noStroke();

			float x1T = texturePos.x  - dx/2; 
			float x2T = texturePos.x  + dx/2; 
			float y1T = texturePos.y  - dy/2;
			float y2T = texturePos.y  + dy/2;


			float x1 = -dx/2;
			float y1 =  dy/2; 

			float x2 =  dx/2;
			float y2 =  dy/2;

			float x3 =  dx/2; 
			float y3 = -dy/2;

			float x4 = -dx/2;
			float y4 = -dy/2;

			pushMatrix();

			translate(pos.x,pos.y,0);

			beginShape();
				texture(textureName);
        vertex(x1,y1,x1T,y2T);
				vertex(x2,y2,x2T,y2T);
				vertex(x3,y3,x2T,y1T);
				vertex(x4,y4,x1T,y1T);
			endShape(CLOSE);

			popMatrix();

		}

		// move function 

		void move() {
	

      float distXY = dist(pos.x,pos.y,texturePos.x,texturePos.y); 


      if(distXY <= 1.0e-4) 
      {
         pos.x = texturePos.x;
         pos.y = texturePos.y;
         heading = 0.0;
         done++;
      }else
      {

        heading = 0.01;

        float distX  = texturePos.x - pos.x;
        float distY  = texturePos.y - pos.y;
    
        pos.x += distX*(heading);
        pos.y += distY*(heading);
      }

    }
}

////////////////
// array shuffle 
////////////////

void shuffleArray(int[] array) {
 
  // with code from WikiPedia; Fisher–Yates shuffle 
  //@ <a href="http://en.wikipedia.org/wiki/Fisher" target="_blank" rel="nofollow">http://en.wikipedia.org/wiki/Fisher</a>–Yates_shuffle
 
  Random rng = new Random();

  // i is the number of items remaining to be shuffled.
  for (int i = array.length; i > 1; i--) {
 
    // Pick a random element to swap with the i-th element.
    int j = rng.nextInt(i);  // 0 <= j <= i-1 (0-based array)
 
    // Swap array elements.
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}
