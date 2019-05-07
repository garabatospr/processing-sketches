/* @pjs preload="archi2.png,colorido.png";*/

// "moving_pixels" by garabatospr 
// http://www.openprocessing.org/sketch/557904
// Licensed under Creative Commons Attribution 
// ShareAlike https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/
// Feel free to do whatever you want with this code.  
// If you do use it,I would like to see what you did. 
// Send me an email to mecobi@gmail.com

PImage img;

Stripe[] stripe;

int nBoxes = 1000;

int nIter = 100;

int iter=0;

PVector texturePos, pos, speed,direction,size;

////////////////
// moving_pixels
////////////////

void setup() {

	  
    img = loadImage("archi2.png");
	  
    size(1000,744,P3D);
	
	  background(0);
	
    stripe = new Stripe[nBoxes];

    int inx = 0;

    int boxSizeX = 65;
    int boxSizeY = 50;

    int dx = floor((1000 - boxSizeX)/15);
    int dy = floor((744  - boxSizeY)/20);


    for(int i=boxSizeX/2;i < 1000;i+=dx)
    {
      for(int j=boxSizeY/2;j < 744;j+=dy)
      {
        texturePos = new PVector(i,j);
        pos = new PVector(i,j);
        speed = new PVector(0,random(2));
        direction = new PVector(1,1);
        size = new PVector(boxSizeX,boxSizeY);
        stripe[inx] = new Stripe(img,texturePos,pos,speed,direction,size,0);
        inx++;
      }
    }

}


////////////////
// draw function
////////////////


void draw () {

  background(0);

  for(int i=0; i < 352;i++)
  {
    stripe[i].display();
    stripe[i].move();
  }

	iter++;
}

///////////////
// square class 
///////////////

class Stripe{

	  PImage   textureName;
    PVector  texturePos;
    PVector  pos;
    PVector  speed;
    PVector  direction;
    PVector  size;
    float    rotAngle;

		// constructor 

		Stripe(PImage textureName0,PVector texturePos0,PVector pos0,PVector speed0,PVector direction0,PVector size0,float rotAngle0) {
      textureName = textureName0;
      texturePos  = texturePos0;
      pos = pos0;
      speed = speed0;
      direction = direction0;
      size = size0;
      rotAngle = rotAngle0;

    }

		// display function 

		void display() {

      noStroke();
			
			float x1T = texturePos.x  - size.x/2; 
			float x2T = texturePos.x  + size.y/2; 
			float y1T = texturePos.y  - size.y/2;
			float y2T = texturePos.y  + size.y/2;


			float x1 = -size.x/2;
			float y1 =  size.y/2; 

			float x2 =  size.x/2;
			float y2 =  size.y/2;

			float x3 =  size.x/2; 
			float y3 = -size.y/2;

			float x4 = -size.x/2;
			float y4 = -size.y/2;

      
			pushMatrix();

			translate(pos.x,pos.y,0);
      rotateZ(PI/2.0);

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


			pos.x = pos.x  + speed.x*(direction.x); 
			pos.y = pos.y  + speed.y*(direction.y); 
      

			if (pos.x > width || pos.x < 0){   
			     direction.x *= -1;  
			}   


			if (pos.y > height || pos.y < 0){  
			    direction.y*= -1; 
			}  

		}
}

