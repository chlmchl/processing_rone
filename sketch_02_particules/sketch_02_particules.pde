import ddf.minim.*;

// créer un objet de classe Minim
Minim son;

// déclarer une entrée audio
AudioInput entree;

// On créer un objet particules
Particle[] p = new Particle[150];
float spring = 0.00001;

void setup(){
  size(1200, 800);
  
   // on instancie l'objet "son"
  son = new Minim(this);
  // on initialise l'entrée audio déclarée plus haut
  entree = son.getLineIn(Minim.MONO, 64);
  

  
  for(int i = 0; i < p.length; i++)
  {
    p[i] = new Particle(random(width), random(height), 6 );
    p[i].vx = random(-2,2) ;
    p[i].vy = random(-2,2) ;
  }
}

void draw()
{
  background(255);
  
  // float son = entree.left.get(0)*3; 

  for(int i = 0; i < p.length; i++)
  {
    p[i].x += p[i].vx ;
    p[i].y += p[i].vy ;
    
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
    
    // ?????
    for(int j = i + 1; j < p.length; j++)
    {
       springTo(p[i], p[j]);     
    }
    p[i].display();
  }
  
  //filter(BLUR, 0.5);
  
} //fermer draw

void springTo(Particle p1, Particle p2)
{
  float dx = p2.x - p1.x;
  float dy = p2.y - p1.y;
  float dist = sqrt(dx * dx + dy * dy);
  
  if(dist < 100)
  {
    float ax = dx * spring;
    float ay = dy * spring;
    float alpha = 10 + (dist/100) * 200;   
    
    p1.vx += ax;
    p1.vy += ay;
    p2.vx -= ax;
    p2.vy -= ay;
    
    stroke(alpha);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

class Particle
{
    float son = entree.left.get(0)*10; 

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