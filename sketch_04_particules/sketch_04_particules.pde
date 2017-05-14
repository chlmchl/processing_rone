import ddf.minim.*;

// créer un objet de classe Minim
Minim son;

// déclarer une entrée audio
AudioInput entree;

// On créer un objet particules
Particle[] p = new Particle[100];


void setup(){
  frameRate(30);
  size(1200, 800);
  
   // on instancie l'objet "son"
  son = new Minim(this);
  // on initialise l'entrée audio déclarée plus haut
  entree = son.getLineIn(Minim.MONO, 1);
  
  for(int i = 0; i < p.length; i++)
  {
    p[i] = new Particle(random(width), random(height), random(10));
    p[i].vx = random(-2,2) ;
    p[i].vy = random(-2,2) ;
  }
}

void draw()
{
  background(255);
  
  float son = entree.left.get(0)*6000; 
  
  for(int i = 0; i < p.length; i++)
  {
    p[i].x += p[i].vx*son ;
    p[i].y += p[i].vy*son ;
    
    // si position x de particule est < 0 alors elle apparait de l'autre côté et inversement
    if(p[i].x < 0)
    {
      p[i].x = width;
    }
    else if(p[i].x > width)
    {
      p[i].x = 0;
    }
    
    // si position de particule > hauteur, alors elle réapparait à 0 et inversement
    if(p[i].y < 0)
    {
      p[i].y = height;
    }
    else if(p[i].y > height)
    {
      p[i].y = 0;
    }
    
     
    p[i].display();
  }
  
  //filter(BLUR, 0.5);
  
} //fermer draw



class Particle
{

    float x;
    float y;
    float vx;
    float vy;
    float r;
    color c = color(0); // couleur des particules
    
    Particle(float _x, float _y, float _r)
    {
        x = _x;
        y = _y;
        r = _r;    
    }
    
    void display()
    {
        fill(c);
        noStroke();
        ellipse(x, y, r, r);
    }
    
    void move()
    {
      x += vx;
      y += vy;
    }
}