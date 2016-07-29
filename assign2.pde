int b, fX, fY, eX, tX, tY;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

final int TOTAL_BLOOD = 200;
int blood;

int gameState;

float x;
float y;
float speed = 5;

float eY, eYII;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


PImage startOneImg, startTwoImg;
PImage endOneImg, endTwoImg;
PImage backgroundFormerImg, backgroundLaterImg;
PImage fighterImg;
PImage treasureImg;
PImage enemyImg;
PImage hpImg;

void setup(){
  size(640, 480);
  
    b = 0;
    fX = width*2/3;
    fY = height/2;
    eX = 0;
    eY = floor(random(400));

    tX = floor(random(550));
    tY = floor(random(400));
    
    x = width*3/4;
    y = floor(random(400));
    
    blood = 40;
   
    startOneImg = loadImage("img/start1.png");
    startTwoImg = loadImage("img/start2.png");
    endOneImg = loadImage("img/end1.png");
    endTwoImg = loadImage("img/end2.png");
    hpImg = loadImage("img/hp.png");
    fighterImg = loadImage("img/fighter.png");
    treasureImg = loadImage("img/treasure.png");
    enemyImg = loadImage("img/enemy.png");
    backgroundFormerImg = loadImage("img/bg1.png");
    backgroundLaterImg = loadImage("img/bg2.png");
}

void draw(){
  background(0);
  

 switch(gameState){   
    case GAME_START:
    image(startOneImg, 0, 0);
      if(mouseX > 209 && mouseX < 453 && mouseY > 380 && mouseY < 413){        
        if(mousePressed){
          gameState = GAME_RUN;          
        }else{
          image(startTwoImg, 0, 0);
         }
      }   
 } 
  
 switch(gameState){

    case GAME_RUN:    
//background    
    b += 2;
    b %= 1280;
    image(backgroundFormerImg,b,0);
    image(backgroundLaterImg,b-640,0);
    image(backgroundFormerImg,b-1280,0);    
//blood
    fill(#ff0000);
    rect(8,4,blood,17);
    image(hpImg,0,0);
    
    image(treasureImg,tX,tY);  
    if(x >= tX && x <= tX+41){
      if(y >= tY && y <= tY+41){
         blood += 20;
         tX = floor(random(550));
         tY = floor(random(400));
      }
    }
//enemy    
    eX +=3;
    eX %=640;
    image(enemyImg,eX,eY);
    if(eX < x - 65){
      eY = y;
    }else{
      eY += 0;
    }
    
  if(x >= eX && x <= eX+61){
    if(y >= eY && y <= eY+61){
      blood -= 40;
      eX = 0;
    }else{
      blood += 0;
    }
  }
  
  if(blood >= TOTAL_BLOOD){
    blood = TOTAL_BLOOD;
  }
  
  if(blood <= 0){
    gameState = GAME_OVER;
  }

//fighter
  if (upPressed) {
    y -= speed;
  }
  if (downPressed) {
    y += speed;
  }
  if (leftPressed) {
    x -= speed;
  }
  if (rightPressed) {
    x += speed;
  }
    
//boundary detection
  if (x < 0 || x > width-61){
    speed *= -1;
  }
  if (y < 0 || y > height-61){
    speed *= -1;
  }

  image(fighterImg, x, y);
 }  

switch(gameState){
  
    case GAME_OVER:
      image(endOneImg, 0, 0);
      if(mouseX > 216 && mouseX < 425 && mouseY > 316 && mouseY < 341){        
        if(mousePressed){
          gameState = GAME_START;
        }else{
          image(endTwoImg, 0, 0);
         }
      }          
   }  
}
   
void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
