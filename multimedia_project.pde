
//© 2022 Boucelham Ahlem <boucah@hotmail.com>

//REF and Inspiration From 
// Michael Pinn - http://www.openprocessing.org/sketch/157286
 
// Note: You Will need the Minim Sound Library added to make this work.
 
float n4;
float n6;
 
//MUSIC  
import ddf.minim.*;
import ddf.minim.signals.*;
import com.hamoid.*;
VideoExport videoExport;
Minim minim;
AudioPlayer mySound;
 
 
 float yoff = 0.0;        // 2nd dimension of perlin noise
 boolean recording = false;
 

//MAIN SETUP
void setup () {
  fullScreen(P3D);
  noCursor();
  smooth();
  background (0);
  beginShape();
 
  
  minim = new Minim(this);
  mySound = minim.loadFile("storms.mp3");    
  mySound.play();
}
 
void draw () {
 
  fill(0,50);  
  noStroke();
  rect(0, 0, width, height);
  rect(0, 0, width-50, height-50);
  translate(width/2, height/2);
  
  
  
  for (int i = 0; i < mySound.bufferSize() - 1; i++) {
    
    float xoff = 0;
    float angle = sin(i+n4)*7; 
    float angle2 = sin(i+n6)*200; 
 
    float x = sin(radians(i))*(angle2+30); 
    float y = cos(radians(i))*(angle2+30);
 
    float x3 = sin(radians(i))*(500/angle); 
    float y3 = cos(radians(i))*(500/angle);
   
   fill (#E5DBCE, 40);  //beige
   circle(x+i*10,y+i*10,mySound.right.get(i)*100);
   
   fill (#FCF8FF, 40); //grey
   circle(x-i*10,y-i*10,mySound.left.get(i)*100);
   


   fill (#901100, 35);  //Red
   circle(-x+i*10,-y+i*10,mySound.right.get(i)*100);
    

    //Will generate many rectangles around the main circle
  fill ( #FFBDA0, 100); //saumon
  rect(x3, y3, mySound.left.get(i)*20, mySound.left.get(i)*10);
 
 
    // Ligne de mire turquoise remplie de carrés
  fill ( #32777C  , 10); //turquoise
  rect(x3, y, mySound.right.get(i)*100, mySound.right.get(i)*100);
 
   //Main circle
   fill( #ffffff , 70); //wt
   ellipse(x3, y3, mySound.right.get(i)*10, mySound.right.get(i)*20);
    
    
   //Draw noise wave
   float y_noise = map(noise(xoff, yoff), 0, 1, 200,300);
 
  
   if (mySound.left.get(i)*1000 < 0) fill (#B39CD0, 10);
   else 
   {   
     if (mySound.left.get(i)*1000 > 0) fill (#00896F, 5);
   }

     // Set the vertex
    vertex(x3, y_noise); 
    // Increment x dimension for noise
    xoff += 0.05;
    
    xoff += 0.05;
    yoff += 0.08;
    endShape(CLOSE);
  
  }
 
  n4 += 0.008;
  n6 += 0.04;
  
  if(recording) saveFrame("project/frame_####.png");
  
  
}

void keyPressed()
{
  if ( mySound.isPlaying() && key == ' ' )
  {
    mySound.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( mySound.position() == mySound.length() )
  {
    mySound.rewind();
    mySound.play();
  }
  else if (mySound.isPlaying() && key == 'r') recording = !recording;
  else
  {
    mySound.play();
  }
}

void rec(){
  if (frameCount == 1){
    videoExport = new VideoExport(this,"project/movie.mp4");
    videoExport.setFrameRate(60);
    videoExport.startMovie();
}
    videoExport.saveFrame();
}
