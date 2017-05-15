import ddf.minim.*;

// déclaration de la class particule et des variables 
Particle[] p = new Particle[200];
float spring = 0.0000001; // attraction 
float threshold = 0;
float m=0; // variable de temps
float zDist = 11, zmin = -150, zmax = 250, zstep = 2.8, rad = 200;
int nb = int((zmax - zmin) / zDist);
PVector[] circles = new PVector[nb];
color[] colors = new color[nb];
Boolean bnw = true, dots = false;
Minim minim;
AudioPlayer song;


/*
 .M"""bgd `7MM"""YMM MMP""MM""YMM `7MMF'   `7MF'`7MM"""Mq. 
,MI    "Y   MM    `7 P'   MM   `7   MM       M    MM   `MM.
`MMb.       MM   d        MM        MM       M    MM   ,M9 
  `YMMNq.   MMmmMM        MM        MM       M    MMmmdM9  
.     `MM   MM   Y  ,     MM        MM       M    MM       
Mb     dM   MM     ,M     MM        YM.     ,M    MM       
P"Ybmmd"  .JMMmmmmMMM   .JMML.       `bmmmmd"'  .JMML.     
*/                                                        
                                                        
  void setup()
  {
    fullScreen(P3D);
  
    minim = new Minim(this);
   
    // importation de la musique à partir du dossier data
    song = minim.loadFile("rone.mp3");
    song.play();
  
    // 1ere phase
    // attribution d'une position et d'une vitesse random aux particules
      for(int i = 0; i < p.length; i++)
      {
        p[i] = new Particle(random(width), random(height), 0);
        p[i].vx = random(-10, 10);
        p[i].vy = random(-10, 10);
      } // for()
      
    // 2nde phase   
    noFill();
    strokeWeight(2);
    colorMode(HSB);
    
      for (int i = 0; i < nb; i++) {
        circles[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax, zmin));
        colors[i] = color(random(110, 255), 0, random(60, 150));
        colors[i] = color(random(220, 255), 255, 255);
      } // for()
      
  } // setup()
  
  
  
  /*                                                        
`7MM"""Yb. `7MM"""Mq.        db `7MMF'     A     `7MF'
  MM    `Yb. MM   `MM.      ;MM:  `MA     ,MA     ,V  
  MM     `Mb MM   ,M9      ,V^MM.  VM:   ,VVM:   ,V   
  MM      MM MMmmdM9      ,M  `MM   MM.  M' MM.  M'   
  MM     ,MP MM  YM.      AbmmmqMA  `MM A'  `MM A'    
  MM    ,dP' MM   `Mb.   A'     VML  :MM;    :MM;     
.JMMmmmdP' .JMML. .JMM..AMA.   .AMMA. VF      VF   
  */
  
    
  void draw()
  {
    int m = millis();
    background(0);
    println(m);
    
    // création d'un thread calculant en permanence les valeurs de level de la musique jouée
    threshold = song.mix.level() * 200;
    
    //println(threshold);
      
    if(m<35550) 
    {
      for(int i = 0; i < p.length; i++)
      {
        p[i].x += p[i].vx;
        p[i].y += p[i].vy;
       
        // si la position x et y d'une particules > width ou height alors elle est égale à 0 et inversement
        // >>> elle apparaît de l'autre côté de l'écran
          if(p[i].x < 0)
          {
            p[i].x = width;
          } // if()
            else if(p[i].x > width)
            {
              p[i].x = 0;
            } // else()
          
          if(p[i].y < 0)
          {
            p[i].y = height;
          } // if()
            else if(p[i].y > height)
            {
              p[i].y = 0;
            } // else()
          
          for(int j = i + 1; j < p.length; j++)
          {
             springTo(p[i], p[j]);
          } // for()
         
        
        //p[i].display();
      } // for()
    }// if()
      else  if (m<52000) {
        
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
            } // if()
          } // for()
        
        
      } // else()
    
    
           else  
           {
             if((threshold >= 85 && (m<75000))
              {  
                noFill();
                stroke(0,0,200);     
                ellipse(random(width), random(height), threshold, threshold);
              }
              for(int i = 0; i < p.length; i++)
                {
                  p[i].x += p[i].vx;
                  p[i].y += p[i].vy;
                 
                  // si la position x et y d'une particules > width ou height alors elle est égale à 0 et inversement
                  // >>> elle apparaît de l'autre côté de l'écran
                    if(p[i].x < 0)
                    {
                      p[i].x = width;
                    } // if()
                      else if(p[i].x > width)
                      {
                        p[i].x = 0;
                      } // else()
                    
                    if(p[i].y < 0)
                    {
                      p[i].y = height;
                    } // if()
                      else if(p[i].y > height)
                      {
                        p[i].y = 0;
                      } // else()
                    
                    for(int j = i + 1; j < p.length; j++)
                    {
                       springTo(p[i], p[j]);
                    } // for()
                   
                  
                  //p[i].display();
                } // for()
            
            
            
           } // else()
           
        
      
  
    
  } // draw()
  
  
  // La variable spring est liée au son
  void setThreshold() {
      while(song.isPlaying())
      {
          for(int i = 0; i < song.bufferSize(); i++)
          {
            spring = song.mix.get(i) * 30;
          } // for()
      } // while()
  } // setThreshold()
  
  // Calcul des distances entre les particules
  void springTo(Particle p1, Particle p2)
  {
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    float dist = sqrt(dx * dx + dy * dy);
  
      // la distance maximale requise pour relier les particules varie en fonction du level de son calculé 
      // en permanence dans le thread 'threshold'
      if(dist < threshold)
      {
        float ax = dx * spring;
        float ay = dy * spring;
        float alpha = 10 + (dist/100) * 200;   
        
        p1.vx += ax;
        p1.vy += ay;
        p2.vx -= ax;
        p2.vy -= ay;
        
        // tracé d'une ligne reliant deux particules quand la distance les séparant le permet
        stroke(255);
        line(p1.x, p1.y, p2.x, p2.y);
      } // if()
  } // springTo()
  
  class Particle
  {
      float x;
      float y;
      float vx;
      float vy;
      float r;
      color c = color(255);
      
        Particle(float _x, float _y, float _r)
        {
            x = _x;
            y = _y;
            r = _r;    
        } // particle()
      
        void display()
        {
            fill(c);
            noStroke();
            ellipse(x, y, r, r);
        } // display()
      
        void move()
        {
          x += vx;
          y += vy;
        } //move()
  } // class Particle()






// méthode permettant d'avancer dans la musique en fonction de où on clique sur x
// facilite la visualisation des différente étape de processing 
void mousePressed()
{
  int position = int(map(mouseX, 0, width, 0, song.length()));
  song.cue(position);
} // mousePressed()



void stop()
{
  minim.stop();
  super.stop();
}