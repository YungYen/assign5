class Bar
{
  float x;
  float y;
  float len;
  //int life;
  
  void move(){
    x = mouseX;
  }
  void display(){
    rectMode(CENTER);
    rect(x,y,len,10);
  }
  
  Bar(float len){
    this.y = height-40;
    this.len = len;
    //life = l;
  }
}
