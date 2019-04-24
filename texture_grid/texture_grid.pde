PImage img1,img2;

Ball[] balls;

float iter = 0;

///////////////
// texture-grid 
///////////////

void setup() { 

  img1 = loadImage("imagenes/garabatos5.png");
  img2 = loadImage("imagenes/garabatos.png");

  int temp = 100;

  balls = new Ball[165];

  int row = 25;

  int inx = 0;

  PImage img;

  float period = 0.01;


  for(int i=0;i < 15;i++)
  {

    int col = 50;

    for(int j=0; j< 11;j++)
    {

      img = img1;

      balls[inx] = new Ball(col,row,random(5,30),1,img,period); 
      col += 50;
      inx++;
    }
    row += 50;
    period +=0.005;
  }
  
  size(600,750,P3D);

}

void draw() {
  background(0);

  stroke(255);
  strokeWeight(0.5); 
 
  for(int i = 25;i < height;i+=25)
  {
    line(0,i,width,i);
  }


  for(int i = 25;i < height;i+=25)
  {
    line(i,0,i,height);
  }



  for (Ball b : balls) {
    b.update();
    b.display();
    b.checkBoundaryCollision();
  }



}



class Ball {
  PVector position;
  PVector velocity;
  float radius, m;
  float zoom;
  PImage img;
  float period;

  Ball(float x, float y, float r_,float z_,PImage i_,float p_){
    position = new PVector(x, y);
    if (random(1.0) > 0.5)
    {
      velocity = new PVector(random(-1,1),0);
    }else
    {
      velocity = new PVector(0,random(-1,1));
    }
    radius = r_;
    m = radius*.1;
    zoom = z_;
    img = i_;
    period = p_;
  }

  void update() {
    position.add(velocity);
  }

  void checkBoundaryCollision() {
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }

  void radiusUpdate() {
  
     radius = radius + 0.1*sin(period*iter);
     iter+=0.01;
  }
  void display() {

     fill(204);
     pushMatrix();
		 beginShape();
		 texture(img);
     noStroke();
     stroke(255);
     strokeWeight(0.5);
     float ang = 0;
		 while(ang < 2*PI)
		 {
			 float tempX = position.x + (radius)*cos(ang);
			 float tempY = position.y + (radius)*sin(ang);
			 vertex(tempX,tempY,tempX/zoom,tempY/zoom);
			 ang +=0.1;
		 }
		 endShape(CLOSE);
		 popMatrix(); 
  }
}
