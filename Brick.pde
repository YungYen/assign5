class Brick{
  int bX;
  int bY;
  float bGap;
  color bColor;
  int bWidth=40;
  int bHeight=10;
  boolean die = false; 
  
  void display(){
    fill(95, 194, 226);
    rectMode(CENTER);
    rect(bX,bY,40,40);
  }
  Brick(int x,int y){
        bX=x;
        bY=y;
        
      }
}
