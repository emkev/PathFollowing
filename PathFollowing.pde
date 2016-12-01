
/* 2016.12.01 
   2016.12.02
*/

Path path ;
MulPointsPath mpath ;

Vehicle car1 ;
Vehicle car2 ;

void setup() {
  size(640 , 360);
  
  path = new Path() ;
  mpath = new MulPointsPath() ;

  newPath() ;
  
  car1 = new Vehicle( new PVector(0 , height/2) ) ;
  car2 = new Vehicle( new PVector(0 , height/3) ) ;  
}

void draw() {

  background(255);
  
  // simple path , start
  //path.display();
  //car1.follow(path);
  //car2.follow(path);
  //car1.run();
  //car2.run();  
  //car1.borders(path);
  //car2.borders(path);
  // simple path , end
  
  // multiple points path , start
  mpath.display() ;
  car1.followMulPoints(mpath);
  car2.followMulPoints(mpath);
  car1.run();
  car2.run();
  car1.bordersForMul(mpath);
  car2.bordersForMul(mpath);
  // multiple points path , end
}

void newPath() {
  mpath.addPoint( new PVector(-20 , height/2) ) ;
  mpath.addPoint( new PVector(random(0,width/2) , random(0,height)) ) ;
  mpath.addPoint( new PVector(random(width/2,width) , random(0,height)) ) ;
  mpath.addPoint( new PVector(width+20 , height/2) ) ;

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
