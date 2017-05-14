import ddf.minim.*;

Particle[] p = new Particle[100];
float spring = 0.0000001;
float threshold = 0;

Minim minim;
AudioPlayer song;

void setup()
{
  size(1500, 800);

  minim = new Minim(this);
 
  song = minim.loadFile("rone.mp3");
  song.play();

  for(int i = 0; i < p.length; i++)
  {
    p[i] = new Particle(random(width), random(height), 5);
    p[i].vx = random(-10, 10);
    p[i].vy = random(-10, 10);
  }
}

void draw()
{
  background(0);
  
  threshold = song.mix.level() * 200;
  
  println(threshold);
    
  for(int i = 0; i < p.length; i++)
  {
    p[i].x += p[i].vx;
    p[i].y += p[i].vy;
    
    if(p[i].x < 0)
    {
      p[i].x = width;
    }
    else if(p[i].x > width)
    {
      p[i].x = 0;
    }
    
    if(p[i].y < 0)
    {
      p[i].y = height;
    }
    else if(p[i].y > height)
    {
      p[i].y = 0;
    }
    
    for(int j = i + 1; j < p.length; j++)
    {
       springTo(p[i], p[j]);
    }
    
    //p[i].display();
  }
}

void setThreshold() {
  while(song.isPlaying())
  {
    for(int i = 0; i < song.bufferSize(); i++)
    {
      spring = song.mix.get(i) * 0.01;
    }
  }
}

void springTo(Particle p1, Particle p2)
{
  float dx = p2.x - p1.x;
  float dy = p2.y - p1.y;
  float dist = sqrt(dx * dx + dy * dy);

  if(dist < threshold)
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

void mousePressed()
{
  int position = int(map(mouseX, 0, width, 0, song.length()));
  song.cue(position);
}

void stop()
{
  minim.stop();
  super.stop();
}