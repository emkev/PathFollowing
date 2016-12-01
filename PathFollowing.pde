
/* 2016.12.01 */

Path path ;

Vehicle car1 ;
Vehicle car2 ;

void setup() {
  size(640 , 360);
  path = new Path() ;

  car1 = new Vehicle( new PVector(0 , height/2) ) ;
  car2 = new Vehicle( new PVector(0 , height/3) ) ;  
}

void draw() {

  background(255);
  
  path.display();
  
  car1.follow(path);
  car2.follow(path);
  
  car1.run();
  car2.run();
  
  car1.borders(path);
  car2.borders(path);
}

void mousePressed() {

  PVector mouse = new PVector( mouseX , mouseY ) ;
  PVector dir = PVector.sub( mouse , car1.location ) ;
  dir.normalize();
  dir.mult( 3.0 ) ;

  PVector steer = PVector.sub( dir , car1.velocity ) ;
  //steer.limit( 0.5 ) ;
    
  car1.applyForce( steer ) ;

}
