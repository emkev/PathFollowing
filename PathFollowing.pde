
/* base on Daniel Shiffman 's code 
   2016.12.01 
   2016.12.02
   2017.03.20 , add debug-mode
   2017.03.21 , add keyPressed to new paths , 
                and removing previous path points 
*/

Path path ;
MulPointsPath mpath ;

Vehicle car1 ;
Vehicle car2 ;

/* 2017.03.20 , add debug-mode */
boolean debug ;

void setup() {

  size(640 , 360);
  
  path = new Path() ;
  mpath = new MulPointsPath() ;

  newPath() ;
  
  car1 = new Vehicle( new PVector(50 , height/2) ) ;
  car2 = new Vehicle( new PVector(75 , height/3) ) ;  
  
  debug = false ;
  
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
  /* 2017.03.20 , add debug-mode */
  car1.run( debug );
  car2.run( debug );
  
  car1.bordersForMul(mpath);
  car2.bordersForMul(mpath);
  // multiple points path , end
}

void newPath() {

  /* 2017.03.21 , remove previous path-points */
  mpath.removePoints() ;

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

/* 2017.03.20 , add debug-mode
   2017.03.21 , add keyPressed to new paths
*/
void keyPressed() {
  if( key == 'd' || key == 'D' ) {
    debug = !debug ;
  }
  else if( key == 'p' || key == 'P' ) {
    newPath() ;
  }
  
}
