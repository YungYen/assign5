//Balls [] balls;
Ball aBall;
Bar board;
Brick [] bricks;

//Game Status
final int GAME_START   = 0;
final int GAME_RUN     = 1;
final int GAME_PLAYING = 2;
final int GAME_PAUSE   = 3;
final int GAME_WIN     = 4;
final int GAME_LOSE    = 5;
int status;
int point;
int brickNum;
int ballX;
int ballY;
int life;

String pStart = "BRICKS";
String sStart = "Press Enter to Start";
String pPause = "Pause";
String sPause = "Press Enter to Resume";
String pWin   = "WINNER";
String sWin   = "SCORE";
String pLose  = "BOOM";
String sLose  = "You are dead!";

void printText(
int pSize, int px, int py, String pMark, String sMark) {  
  textSize(pSize);
  text(pMark, px, py);
  fill(95, 194, 226);
  textSize(20);
  text(sMark, px, py+40);
  fill(95, 194, 226);
  textAlign(CENTER);
}

void setup(){
  status = GAME_START;
  size(640,480);
  background(255);
  //balls = new Balls[100];
  /*for (int i=0; i<balls.length; i++){
    balls[i] = new Balls(random(10), random(-5,5));
  }*/
  board = new Bar(100);
  bricks = new Brick[50];
  //aBall = new Ball();
  
  reset();
}

void draw(){
  background(0);
  switch(status) {
    
  case GAME_START:
    //board.move();
    //board.display();
   
    
    /*---------Print Text-------------*/
    printText(60, width/2, height/2, pStart, sStart);
    //for (int i=0; i<balls.length; i++){
    //balls[i].move();
    //balls[i].display();
    
    //}
    
    break;
  
  
  case GAME_RUN:
    ballX = mouseX;
    ballY = height-59;
    aBall = new Ball(ballX,ballY,life);
    aBall.display();
    board.move();
    board.display();
    drawBrick();
    //drawHorizon();
    //ballShot();
    //pongLife(3);
    for (int i=0; i<bricks.length; i++){
        bricks[i].display();
        pongLife(3);
    }
    
    break;
    
    case GAME_PLAYING:
    ballX = mouseX;
    ballY = height-55;
    //aBall = new Ball(ballX,ballY);
    checkBrickHit();
    checkWinLose();
    aBall.move();
    aBall.display();
    board.move();
    board.display();
    drawBrick();
    //drawHorizon();
    //ballShot();
    //pongLife(3);
    for (int i=0; i<bricks.length; i++){
        bricks[i].display();
        pongLife(3);
    }
    break;
  
    
   case GAME_PAUSE:     
    /*---------Print Text-------------*/
    printText(40, width/2, height/2, pPause, sPause);
    /*--------------------------------*/
    break;
  case GAME_WIN:
    /*---------Print Text-------------*/
    printText(40, width/2, height/2+80, pWin, sWin+":"+point);
    break;
  case GAME_LOSE:
    fill(95, 194, 226);
    printText(40, width/2, height/2, pLose, sLose);
    break;
  }
}
void checkBrickHit(){
  for (int i=0; i<bricks.length; i++) {
    Brick brick = bricks[i];
    if ( brick!= null && !brick.die && // Check Array isn't empty and brick still exist
      bricks[i].bX+brick.bWidth/2 >= aBall.x  && bricks[i].bY-brick.bWidth/2<= aBall.y+aBall.size/2
      && bricks[i].bY+brick.bWidth/2>= aBall.y && bricks[i].bX-brick.bWidth/2<=aBall.x ) {
      
      
      removeBrick(brick);
      brickNum++;
    }
  }
   
}

void removeBrick(Brick obj){
  obj.die = true;
  obj.bX = 2000;
  obj.bY = 2000;
}

void keyPressed() {
  /*if (status == GAME_PLAYING) {
  }*/
  statusCtrl();
  if(keyCode==ENTER){
    status=GAME_RUN;
  }
}
void drawHorizon() {
  stroke(153);
  line(0, 450, width, 450);
}

/*---------Draw Pong Life---------*/
/*void drawLife() {
  fill(230, 74, 96);
  text("LIFE:", 36, 470);
}*/
void pongLife(int life) {
    fill(230, 74, 96);
    textSize(16);
    text("LIFE :", 36, 455); 
    int lifeX=88;
    int lifeY=448;
    int lifeGap=25;
    for(int i=0;i<aBall.life;i++){
      fill(230, 74, 96);
      noStroke();
      ellipse(lifeX+(lifeGap*i),lifeY,15,15);
  }
}
void drawBrick() {
  for (int i=0; i<bricks.length; i++) {
    Brick brick = bricks[i];
    if (brick!=null) {
      brick.display(); //Draw Brick
      /*---------Call Check Line Hit---------*/
      //lineHit(alien.aY);
      /*--------------------------------------*/
    }
  }
}
void brickMaker(int x,int y,int spacing,int bInRow){
    noStroke();
    for (int i=0;i<bricks.length;++i){
    spacing = 50;
    float row = i / bInRow;
    float col = i % bInRow;
    int bX = x + (spacing*int(col));
    int bY = y + (spacing*int(row));
    bricks[i]= new Brick(bX,bY);
      
  }
}

/*void ballShot(){
  if(mouseButton==RIGHT){
         aBall.move();
     }
}*/
/*---------Reset Game-------------*/
void reset() {
//  for (int i=0; i<bricks.length-1; i++) {
//    bricks[i] = null;
//  }
  brickMaker(105,40,41,10);
  //aBall.life=3;
}

void mouseClicked(){
     if(mouseButton==RIGHT){
         status = GAME_PLAYING;
     }
}

void checkWinLose() {
     if(brickNum==50){
        status=GAME_WIN;
     }
     if(aBall.y>=height){
       aBall.life-=1; 
      if(aBall.life==0){
       status = GAME_LOSE;
     }
     }
     

}

/*---------Check Win Lose------------------*
void checkWinLose() {       
    if (ship.life==0) {
      status = GAME_LOSE;
    }     
      if(dieNum == 2){
        status = GAME_WIN;
        } 
      }

/*-----------finish statusCtrl--------*/
void statusCtrl() {
  if (key == ENTER) {
    switch(status) {
    case GAME_START:
      status = GAME_RUN;
      break;
      /*-----------add things here--------*/
    case GAME_RUN:
      status = GAME_PLAYING;
      break;
    case GAME_PLAYING:
      status = GAME_PAUSE;
      break;
    case GAME_PAUSE:
      status = GAME_PLAYING;
      break;
    case GAME_WIN:
      status = GAME_PLAYING;
      //reset();
      break;
    case GAME_LOSE:
      status = GAME_PLAYING;
      //reset();
      break;
    }
  }
}
