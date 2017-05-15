import ddf.minim.*;
import ddf.minim.analysis.*;

float zDist = 11, zmin = -150, zmax = 250, zstep = 2.8, rad = 200;
int nb = int((zmax - zmin) / zDist);
PVector[] circles = new PVector[nb];
color[] colors = new color[nb];
Boolean bnw = true, dots = false;

Minim minim;
AudioPlayer song;
FFT fft;
float highestAmp=0,freq,frequency;
float amplitude;
float threshold = 0;


void setup() {
  fullScreen(P3D);
  
  minim = new Minim(this);
  // importation de la musique à partir du dossier data
  song = minim.loadFile("rone.mp3");
  song.play();
  fft = new FFT(song.left.size(), 44100);
  
  noFill();
  strokeWeight(2);
  colorMode(HSB);
  for (int i = 0; i < nb; i++) {
    circles[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax, zmin));
    colors[i] = color(random(110, 255), 0, random(60, 150));
    colors[i] = color(random(220, 255), 255, 255);
  }
}

void draw() {
  background(20);
  
  highestAmp=0;
  amplitude=0;
  frequency = 0;
  fft.forward(song.left);
  // création d'un thread calculant en permanence les valeurs de level de la musique jouée
  threshold = song.mix.level() * 200;
  
  println(threshold);
  
  //searching from 0Hz to 20000Hz. getting the band, and from the band the frequency
     for(int i = 0; i < 20000; i++) {
            amplitude = fft.getFreq(i);
            if (amplitude > highestAmp){
                highestAmp = amplitude;
                frequency = i;
            }
          }
  
  translate(width/2, height/2);
  PVector pv;
  float fc = (float)frameCount, a;
  if (dots) beginShape(POINTS); 

  for (int i = 0; i < nb; i++) {
    pv = circles[i];
    pv.z += zstep;
    pv.x = (noise((fc*2 + pv.z) / 550) - .5) * height * map(pv.z, zmin, zmax, 6, 0);
    pv.y = (noise((fc*2 - 3000 - pv.z) / 550) - .5) * height * map(pv.z, zmin, zmax, 6, 0);

    a = map(pv.z, zmin, zmax, 0, 255);
    
    stroke(map(pv.z, zmin, zmax, 0, 255), a);
    float r = map(pv.z, zmin, zmax, rad*.1, rad);


    pushMatrix();
    translate(pv.x, pv.y, pv.z);
    ellipse(0, 0, r*7, r*7);
    popMatrix();
    

    if (pv.z > zmax) {
      circles[i].z = zmin;
    }
  }
  
}