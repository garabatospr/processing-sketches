 class Object
 {
 
   PVector pos;
   PVector size;
   PVector speed;
   PVector direction;
   boolean myFill;
   float   myWeight;
   color   fillColor;
   color   strokeColor;
   String  type;
 
 
   Object(PVector pos0,PVector size0,PVector speed0,PVector direction0,boolean myFill0)
   {
     pos   = pos0;
     size  = size0;
     speed = speed0;
     direction = direction0;
     myFill = myFill0;
     myWeight = random(0,10);
     color temp1 = myRandom(colors,colorW);
     color temp2 = myRandom(colors,colorW);
     fillColor  = color(hue(temp1) + randomGaussian()*10,saturation(temp1),brightness(temp1)-10,random(0,100));
     strokeColor  = color(hue(temp2) + randomGaussian()*10,saturation(temp2),brightness(temp2)-10,random(0,100));
     type = objects[floor(random(0,4))];
   }
 
 
   void display()
   {
     strokeWeight(myWeight);
     if (myFill)
     {
       fill(fillColor);
     }else
     {
       noFill();
     }
     stroke(strokeColor);
     selectObject(type);
 
   }
 
   void selectObject(String myType)
   {
     if (myType == "square")
     {
       rect(pos.x,pos.y,size.x,size.x);
     }
     else if (myType == "circle")
     {
       ellipse(pos.x,pos.y,size.x,size.x);
     }
     else if (myType == "oval")
     {
       ellipse(pos.x,pos.y,size.x,size.y);
     }else
     {
       rect(pos.x,pos.y,size.x,size.y);
     }
   }
   
   
 
   void move()
   {
     pos.x = pos.x  + speed.x*(direction.x);
     pos.y = pos.y  + speed.y*(direction.y);
     
     
     if (pos.x < border || pos.x > width - border)
     {   
         direction.x *= -1;
     }
 
 
     if (pos.y <  border || pos.y > height - border)
     {
         direction.y *= -1;
     }
   }
 }

