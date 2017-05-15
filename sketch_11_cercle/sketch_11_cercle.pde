import ddf.minim.*;


float threshold = 0;

Minim minim;
AudioPlayer song;
Circles c;

void setup(){
 size(1000,700);
  minim = new Minim(this);
 
  // importation de la musique à partir du dossier data
  song = minim.loadFile("rone.mp3");
  song.play();

  c=new Circles();
   
}

void draw(){
   
  // création d'un thread calculant en permanence les valeurs de level de la musique jouée
  threshold = song.mix.level() * 200;
  
  println(threshold);
  background(0);
  
  translate(width/2,height/2);
  smooth();
  c.display();
 
}
ArrayList <PVector> circle;
ArrayList <PVector> b;

class Circles{

  Circles(){
    
      circle = new ArrayList <PVector>();
      b = new ArrayList <PVector>();

      
      for(int i=0; i<150;i++){

      circle.add(new PVector(random(-20,30), random(-20,30)));
      b.add(new PVector(random(10,20),10));
                             }
           }
           
           
  void display(){
  
      for(int i=1; i<50;i++){
          
          PVector a= circle.get(i-1);
          PVector c= b.get(i);
  
             noFill();
             stroke(255); 
   
             strokeWeight(i/5);
          rotate(frameCount/(10*i*i*1.0));
          ellipse(0,0,5+threshold*map(random(width),0,600,0,10)/i,5+threshold*map(random(height),0,600,0,10)/i);
    
         
       
  }
  }
}