
final int GAME_START = 1;
final int GAME_RUN = 2;
final int GAME_LOSE = 3;

int gameState;

PImage bg1Img,bg2Img,enemyImg,fighterImg,hpBarImg,treasureImg,start1Img,start2Img,end1Img,end2Img;

float backgroundX,backgroundY; //background
float treasureX,treasureY; //treasure
float enemyX,enemyY; //enemy
float hpBar; //hpBar
float fighterX,fighterY; //fighter
float speed = 5;

boolean playStart1 = true, playStart2 = false;
boolean playEnd1 = false, playEnd2 = false;



boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


void setup () {
  
  size(640,480) ; 
  bg1Img = loadImage("img/bg1.png");
  bg2Img = loadImage("img/bg2.png");
  enemyImg = loadImage("img/enemy.png");
  fighterImg = loadImage("img/fighter.png");
  hpBarImg = loadImage("img/hp.png");
  treasureImg = loadImage("img/treasure.png");
  
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png");
  end1Img = loadImage("img/end1.png");
  end2Img = loadImage("img/end2.png");
  
  backgroundX=640;
  backgroundY=0;
  treasureX=random(0,600);
  treasureY=random(0,440);
  enemyX=0;
  enemyY=random(0,419);
  hpBar=40;
  fighterX=589;
  fighterY=214.5;

  
  gameState = GAME_START;
}

void draw() {
  if(playStart2){
   image(start2Img,0,0);
  }   
  if(playStart1){
    image(start1Img,0,0); 
  }
  if(playEnd2){
   image(end2Img,0,0);
  }   
  if(playEnd1){
    image(end1Img,0,0); 
  }

  
  if(upPressed){
    fighterY-=speed;
  }
  if(downPressed){
    fighterY+=speed;
  }
  if(leftPressed){
    fighterX-=speed;
  }
  if(rightPressed){
    fighterX+=speed;
  }

  
switch(gameState)  {
 case GAME_START: 
  //mouseMoved
  if(mouseX>200 && mouseX<460 && mouseY>370 && mouseY<420){
    playStart2 = false;
    playStart1 = true;  
  }
  else{
    playStart2 = true;
    playStart1 = false;
  } 
  
  //mousePressed
  if(mouseX>200 && mouseX<460 && mouseY>370 && mouseY<420 && mousePressed){
       playStart1 = false;
       playStart2 = false;
       gameState = GAME_RUN;    
  }
       break;
       
 case GAME_RUN:      
       background(0);
        
       //background   
       image(bg1Img,backgroundX-640,0);
       image(bg2Img,backgroundY-640,0);
       backgroundX++;
       backgroundX %=1281;
       backgroundY++;
       backgroundY %=1281;
      
     
      
       //fighter
       image(fighterImg,fighterX,fighterY);
       fighterX %= 640;
       fighterY %= 480;
       if(fighterX <= 0){
         fighterX = 640;
       }
       if(fighterY <= 0){
         fighterY = 480;
       }

  
 
       //enemy
       image(enemyImg,enemyX,enemyY);
       enemyX+=3;
       enemyY+= (fighterY-enemyY)/30;
       enemyX %=641;
       if(enemyX>=640 || enemyX<=0){
       enemyY=random(0,419);
       }
  
       //hpBar
       fill(255,0,0);
       rect(10,7,hpBar,20);
       image(hpBarImg,5,5);
       
       //treasure
        image(treasureImg,treasureX,treasureY); 


      
      //score
       if(fighterX <= treasureX+41 && fighterX+51 >= treasureX && fighterY <= treasureY+41 && fighterY+51 >= treasureY){
         treasureX = random(0,600);
         treasureY = random(0,440);
         hpBar+=20;
         if(hpBar > 180){
         hpBar=200;
         hpBar+=0;
        }
       }
       
       if(enemyX+61 >= fighterX && enemyX <= fighterX+51 && enemyY+61 >= fighterY && enemyY <= fighterY+51 ){        
         enemyX = 0;
         enemyY = random(0,419);
         hpBar-=40;
       }
      
       if(hpBar <= 0){
         gameState = GAME_LOSE;
       }
      break;
      
case GAME_LOSE:
      playEnd2 = true;
      if(mouseX>=205 && mouseX<440 && mouseY>=310 && mouseY<=350){
       playEnd2 = false;
       playEnd1 = true;  
      }
      else{
       playEnd2 = true;
       playEnd1 = false;
      } 
      
      if(mouseX>=205 && mouseX<440 && mouseY>=310 && mouseY<=350 && mousePressed){
       playEnd1 = false;
       playEnd2 = false; 
       
       fighterX = 589;
       fighterY = 214.5;
       enemyX = 0;
       enemyY = random(0,419);
       treasureX = random(0,600);
       treasureY = random(0,440) ;
       hpBar = 40;
       
       gameState = GAME_RUN; 
      }
       break;      

} 

}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
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
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
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
