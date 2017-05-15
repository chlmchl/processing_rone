import ddf.minim.*;


float threshold = 0;

Minim minim;
AudioPlayer song;

void setup()
{
  fullScreen();

  minim = new Minim(this);
 
  // importation de la musique à partir du dossier data
  song = minim.loadFile("rone.mp3");
  song.play();

  background(0);
  
}

void draw()
{
  background(0);
  
  // création d'un thread calculant en permanence les valeurs de level de la musique jouée
  threshold = song.mix.level() * 200;
  
  println(threshold);
    
  if(threshold >= 80)
  {  
    noFill();
    stroke(255);
    strokeWeight(0.5);
    ellipse(random(width), random(height), threshold*1.4, threshold*1.4);
  } 
  
  
  
}






// méthode permettant d'avancer dans la musique en fonction de où on clique sur x
// facilite la visualisation des différente étape de processing 
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