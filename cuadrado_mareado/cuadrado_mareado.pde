PImage img;

PImage temp;

Square square;


float xdirection = 1;

float ydirection = 1;

float zoom = 1.01;

float rSize = 16;


/////////////////
// setup function
/////////////////


void setup() {

    img =  loadImage("imagenes/archi2.png");


    size(1000,744,P3D);

    square = new Square(100,height/2,1,1);


}

////////////////
// draw function
////////////////


void draw () {

    image(img,0,0);
    
		filter(GRAY);

    square.move();
    square.display();


}

///////////////
// square class 
///////////////

class Square {

		float xpos;
		float ypos; 
		float xspeed;
		float yspeed;

		// constructor 

		Square(float tempXPos,float tempYPos,float tempXSpeed,float tempYSpeed) {
			xpos = tempXPos;
			ypos = tempYPos; 
			xspeed = tempXSpeed;
			yspeed = tempYSpeed;
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

			float rSize = 8;
			float xBoxSize = 600;
			float yBoxSize = 600;


			float x1T = xpos - width/rSize; 
			float x2T = xpos + width/rSize; 
			float y1T = ypos - height/rSize; 
			float y2T = ypos + height/rSize; 


			// "zoom" box dimensiones

			float x1 = -xBoxSize/rSize;
			float y1 =  yBoxSize/rSize;

			float x2 =  xBoxSize/rSize;
			float y2 =  yBoxSize/rSize;

			float x3 =  xBoxSize/rSize;
			float y3 = -yBoxSize/rSize;

			float x4 = -xBoxSize/rSize;
			float y4 = -yBoxSize/rSize;

			//pushMatrix();

			translate(xpos/zoom,ypos/zoom,0);

			rotateZ(frameCount*0.05*radians(-20));

			strokeWeight(3.0);

			beginShape();
				texture(img);
				vertex(x1,y1,x1T/zoom,y2T/zoom);
				vertex(x2,y2,x2T/zoom,y2T/zoom);
				vertex(x3,y3,x2T/zoom,y1T/zoom);
				vertex(x4,y4,x1T/zoom,y1T/zoom);
			endShape(CLOSE);

			//popMatrix();

		}

		// move function 

		void move() {

			xpos = xpos + xspeed*(xdirection);
			ypos = ypos + yspeed*(ydirection);


			if (xpos/zoom > (width-(width/rSize) - rSize/2) || xpos/zoom  <  (width/rSize + rSize/2)){
				xdirection *= -1;
			}


			if (ypos/zoom  > (height-(height/rSize) + rSize/2) || ypos/zoom < (height/rSize - rSize/2)){
				ydirection *= -1;
			}

		}
}
