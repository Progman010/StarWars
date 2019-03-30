//import processing.video.*;
//import processing.serial.*;

//Capture video;
Game g;
CV cv;
Unit[] u;
//Serial port;

int NEGATIVE = -1000;
int SCALE = 4;

int 
xShoot = NEGATIVE, 
yShoot = NEGATIVE;
int shootOffsetIndex = 0;

int LASER_LEVEL = 254;
//float LASER_RADIUS = 5;

int[] SHOOT_OFFSET = { 0, 0, 0, 0, 0, 25, 50, 75, 100, 125, 150, 175, 200, 250, 200, 150, 100, 50};
int SHOOT_STEP = 4;
int SHOOT_QTY = 8;
float SHOOT_OPACITY = 0.3;

int UNIT_QTY = 5;
int UNIT_STEP = 3;
int UNIT_ANGLE = 2;
int UNIT_SIZE = 200;
int UNIT_RADIUS = 200;
int UNIT_PADDING = 100;
int UNIT_STRENGTH = 3;
PImage UNIT_IMG;
PImage UNIT_SHOOT_IMG;
PImage start;//new
PImage win;//new
PImage lose;//new

int progress;
int unitsToKill = 18;
int unitDamage = 50;
int userDamage = 100;
int userKilled = 0;
int userFactor = 50;
int unitFactor = 5;


int unitAppearlimit = 1;
int enemyShootLimit = 1;

int INFO_DELAY = 300;
int DELAY = 10;
int FRAME = 0;
int STATE = 1;

int infoDelay = INFO_DELAY;

void setup() {
  //size(640, 480);//1280, 480);
  fullScreen();
  start = loadImage("start.png");//new
  win = loadImage("win.png");//new
  lose = loadImage("lose.png");//new
  UNIT_IMG = loadImage("unit.png");
  UNIT_SHOOT_IMG = loadImage("unit_shoot.png");
  g = new Game();
  enemyShootLimit = 100;
  progress = width;
}

void draw() {
  if(enemyShootLimit <= 0 ){
    fill(255, 0, 0);
    enemyShootLimit = round((random(10, 500))/(g.getUnitQty()+0.0000001));
    progress-=unitDamage;
  }
  else{
    fill(0);
  }
  if(unitAppearlimit <= 0 ){
    g.initUnit();
    enemyShootLimit = 0;
    unitAppearlimit = round((random(100, 700)/unitFactor));
    if(unitFactor>1)
      unitFactor--;
  }
  noStroke();
  rect(0, 0, width, height);
  stroke(0, 250, 0);
  strokeWeight(1);
  noFill();
  
  if((mousePressed && (mouseButton == LEFT)) && shootOffsetIndex > SHOOT_OFFSET.length) {
    shootOffsetIndex = 0;
    xShoot = mouseX;
    yShoot = mouseY;
    //progress+=g.shootUnits(xShoot, yShoot) * userDamage;
    unitsToKill -= g.shootUnits(xShoot, yShoot);
    if(STATE == 0) STATE = 1;
  }
  if(progress > width){
    STATE = 3;
  }
  if(progress < 0){
    STATE = 2;
  }
  
  if(shootOffsetIndex < SHOOT_OFFSET.length){
    g.shiftShootOffset();
    g.shoot(xShoot, yShoot);
  }
  
  
  shootOffsetIndex++;
  float colorCorrection = g.getSummStrength()*(255/((g.getUnitQty()*UNIT_STRENGTH)+0.0000001));
  fill(255 - colorCorrection, colorCorrection, 0);
  noStroke();
  //rect(0, 0, g.getSummStrength()*((width+0.0)/(g.getUnitQty()*UNIT_STRENGTH)), 10);
  colorCorrection = 255*progress/width;
  fill(255 - colorCorrection, colorCorrection, 0);
  rect(0, 0, progress, 20);
  
  for(int i = 0; i < unitsToKill; i++) {
    ellipse(100+100*i, 100, 70, 70);
  }
  
  
  //new start
  g.refreshUnits();
  switch(STATE){
   case -1://black screen
   fill(0, 0, 0);
   noStroke();
   rect(0, 0, width, height);
   break;
   case 0://begin 
     fill(0);
     image(start, 0, 0, width, height);//new
     noStroke();
     //rect(0, 0, width, height);
     break;
   case 1://game
     unitAppearlimit--;
     enemyShootLimit--;
     //port.write(50);
     break;
   case 2://loose
     if(infoDelay>0){
       fill(100, 0, 0);
       noStroke();
       rect(0, 0, width, height);
       image(lose, 0, 0, width, height);//new
       infoDelay--;
     }
     else {
       infoDelay = INFO_DELAY;
       progress = width;//(width/2)+userFactor;
       unitFactor = 5;
       STATE = 0;
       enemyShootLimit = 999999;
       g.reloadUnits();
     }
     break;
   case 3://win
     fill(0, 100, 0);
     noStroke();
     rect(0, 0, width, height);
     image(win, 0, 0, width, height);//new
     g.reloadUnits();
     break;
  }
  //new end
  
     unitAppearlimit--;//new delete
     enemyShootLimit--;//new delete
  
  imageMode(CORNER);
  fill(0, 255, 0);
  
  delay(DELAY);
}