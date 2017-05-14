import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;

AudioInput in;
FFT fft;
float highestAmp=0,freq,frequency;
float amplitude;
float volume = 0;

void setup() {
  size(800,800, P2D);
  background(255);
   // initialize Minim and catching the output
        minim = new Minim(this);        
        in = minim.getLineIn(Minim.MONO, 4096, 44100);
        fft = new FFT(in.left.size(), 44100);
} // fermer setup

void draw() {
  
      highestAmp=0;
      amplitude=0;
      frequency = 0;
      fft.forward(in.left);
      
       //searching from 0Hz to 20000Hz. getting the band, and from the band the frequency
     for(int i = 0; i < 20000; i++) {
            amplitude = fft.getFreq(i);
            if (amplitude > highestAmp){
                highestAmp = amplitude;
                frequency = i;
            }
          }
          /*write the frequency on the screen
             if(amplitude>20) {
            background(255);
            fill(0);          
          }
          else {
            background(0);
            fill(255);            
          }*/
          
    // 1. effet de fade out
  noStroke();
  fill(0,10);
  rect(0,0,width/2,height); 
  
  stroke(255);
  fill(255);
  arc(width/2,height/2,amplitude*20000,amplitude*20000,PI,PI+HALF_PI);
  
  noStroke();
  fill(0,10);
  rect(0,0,width/2,height); 
  
  stroke(255);
  fill(255);
  arc(width/2,height/2,frequency/4,frequency/4,HALF_PI,PI);
  
  noStroke();
  fill(0,10);
  rect(width/2,0,width/2,height);
  
  noStroke();
  fill(255);
  arc(width/2,height/2,frequency/4,frequency/4,PI+HALF_PI,PI+PI);
  
    noStroke();
  fill(0,10);
  rect(0,0,width/2,height); 
  
  stroke(255);
  fill(255);
  arc(width/2,height/2,amplitude*20000,amplitude*20000,0,HALF_PI);
  
  /*fill(0);
  ellipse(width/2,height/2,amplitude*10000,amplitude*10000);*/
  
  
} // fermer draw