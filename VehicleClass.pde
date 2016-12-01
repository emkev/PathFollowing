
/* 2016.12.01 */

class Vehicle {
  
  PVector location ; 
  PVector velocity ; 
  PVector acceleration ; 

  float r ; 
  float maxSpeed ; 
  float maxForce ; 

  Vehicle(PVector l)
  {
    location = l.get() ; 
    velocity = new PVector(maxSpeed , 0) ; 
    acceleration = new PVector(0 , 0) ; 

    r = 3.0 ; 
    maxSpeed = 2.0 ; 
    maxForce = 0.1 ; 
  }

  void run() {
    update() ;
    display() ;
  }
  
  void update()
  {
    velocity.add(acceleration) ; 
    velocity.limit(maxSpeed) ; 
    location.add(velocity) ; 
    acceleration.mult(0) ; 
  }

  void applyForce(PVector force)
  {
    acceleration.add(force) ; 
  }

  void display()
  {
    float theta = velocity.heading2D() + PI / 2 ; 
    fill(175) ; 
    stroke(0) ; 
    pushMatrix() ; 
    translate(location.x , location.y) ; 
    rotate(theta) ; 
    beginShape() ; 
    vertex(0 , -r * 2) ; 
    vertex(-r , r * 2) ; 
    vertex(r , r * 2) ; 
    endShape(CLOSE) ; 
    popMatrix() ; 
  }

  void follow(Path path) {
    
    PVector predict = velocity.get() ;
    predict.normalize();
    predict.mult(25);
    PVector predictLoc = PVector.add( location , predict ) ;
    
    PVector a = PVector.sub( predictLoc , path.start ) ;
    PVector b = PVector.sub( path.end , path.start ) ;
    
    float theta = PVector.angleBetween( a , b ) ;
    b.normalize();
    b.mult( a.mag() * cos(theta) ) ;
    PVector normalPoint = PVector.add( path.start , b ) ;
    
    PVector dir = PVector.sub( path.end , path.start ) ;
    dir.normalize();
    dir.mult(10);
    PVector target = PVector.add( normalPoint , dir ) ;
    
    float distance = PVector.dist( predictLoc , normalPoint ) ;
    if( distance > path.radius ) {
      seek( target ) ;
    }
  }
  
  void seek(PVector target) {
    
    PVector desired = PVector.sub( target , location ) ;

    if( desired.mag() == 0 ) return ;
    
    desired.normalize() ;
    desired.mult( maxSpeed ) ;
    
    PVector steer = PVector.sub( desired , velocity ) ;
    steer.limit( maxForce ) ;
    
    applyForce( steer ) ;
    
  }

  
  void borders(Path path) {
    
    if( location.x > path.end.x + r ) {
      location.x = path.start.x - r ;
      location.y = path.start.y + (location.y - path.end.y) ;
    }
    
  }
  
}
