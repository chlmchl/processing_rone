import ddf.minim.*;

// créer un objet de classe Minim
Minim son;

// déclarer une entrée audio
AudioInput entree;
float r = random(1);


void setup(){
 size(640,480) ;
 
 // on instancie l'objet "son"
 son = new Minim(this);
 // on initialise l'entrée audio déclarée plus haut
 entree = son.getLineIn(Minim.MONO, 64);
}

void draw() {
 
  // 1. effet de fade out
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
  
  // 2. crayon pour dessiner les ellipses
  stroke(255);
  noFill();
  
  //3. Dessin de 64 ellipses
  // une boucle parcourt l'échantillonnage sonore de 64 valeurs de bout en bout
  float son = entree.left.get(0)*3; 
  float son2 = entree.right.get(0)*3;
  
  for (float i=r; i<entree.bufferSize(); i++) {
   ellipse (width/2,height/2,son*6000,son2*6000);
  } // fermeture de for
  
  println(son);
  
} // fermeture de draw

void stop() {
 entree.close();
 son.stop();
 super.stop();
}