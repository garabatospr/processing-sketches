
PImage img;

Square[] square;

int nSquares = 100;


// texture_scanner 


void setup() {

    img =  loadImage("imagenes/archi2.png");

    size(1000,744,P3D);

    square = new Square[nSquares];

    for(int i = 0; i < nSquares;i++)
    {
       float randPosX   = random(1)*width;
       float randPosY   = random(1)*height;
       float randSpeedX = random(1.0,1.2);
       float randSpeedY = random(1.0,1.2);
       int   randSize   = floor(random(20,60));
       square[i] = new Square(randPosX,randPosY,randSpeedX,randSpeedY,1,1,randSize);
    }

}

float distance(float x1,float y1,float x2,float y2)
{
    return pow(pow(x2 - x1,2) + pow(y2 - y1,2),0.5);
}

////////////////
// draw function
////////////////


void draw () {

    //clear();

    image(img,0,0);
    
		filter(GRAY);

    for(int i=0; i < nSquares;i++)
    {
       square[i].move(); 
       square[i].display();
    }

}

///////////////
// square class 
///////////////

class Square {

		float xpos;
		float ypos; 
		float xspeed;
		float yspeed;
    float xDirection;
    float yDirection;
    float boxSize;

		// constructor 

		Square(float tempXPos,float tempYPos,float tempXSpeed,float tempYSpeed,
           int  tempXDirection,int tempYDirection,int tempBoxSize) {
			xpos = tempXPos;
			ypos = tempYPos; 
			xspeed = tempXSpeed;
			yspeed = tempYSpeed;
      xDirection = tempXDirection;
      yDirection = tempYDirection;
      boxSize = tempBoxSize;
		}

		// return x coordinate 

		float getX() {
			return xpos; 
		}

		// return y coordinate 

		float getY() {
			return ypos;
		}

		// display function 

		void display() {

      noStroke();

      float zoom = 1.1;

			float x1T = xpos - (boxSize/2); 
			float x2T = xpos + (boxSize/2); 
			float y1T = ypos - (boxSize/2);
			float y2T = ypos + (boxSize/2);


			float x1 = -(boxSize/2);
			float y1 =  (boxSize/2);

			float x2 =  (boxSize/2);
			float y2 =  (boxSize/2);

			float x3 =  (boxSize/2);
			float y3 = -(boxSize/2);

			float x4 = -(boxSize/2);
			float y4 = -(boxSize/2);

			pushMatrix();

			translate(xpos,ypos,0);

			strokeWeight(3.0);

			beginShape();
				texture(img);
				vertex(x1,y1,x1T/zoom,y2T/zoom);
				vertex(x2,y2,x2T/zoom,y2T/zoom);
				vertex(x3,y3,x2T/zoom,y1T/zoom);
				vertex(x4,y4,x1T/zoom,y1T/zoom);
			endShape(CLOSE);

			popMatrix();

		}

		// move function 

		void move() {

			xpos = xpos + xspeed*(xDirection);
			ypos = ypos + yspeed*(yDirection);

			 
			if (xpos > width - (boxSize/2) || xpos <  (boxSize/2)){
				xDirection *= -1;
			}


			if (ypos > height - (boxSize/2) || ypos < (boxSize/2)){
				yDirection *= -1;
			}

		}
}
