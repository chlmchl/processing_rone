import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;
float highestAmp=0,freq,frequency;
float amplitude;


void setup(){
        size(1000, 1000);
        
        
        // initialize Minim and catching the output
        minim = new Minim(this);
        in = minim.getLineIn(Minim.MONO, 4096, 44100);
        fft = new FFT(in.left.size(), 44100);
}


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
          //write the frequency on the screen
             if(frequency>500) {
            background(255);
            fill(0);          
          }
          else {
            background(0);
            fill(255);            
          }
     
          ellipse(width/2,height/2,frequency, frequency);
          text(frequency, 10, 20);
          
       
}