class Unit {
  int x, y;
  PVector g = new PVector(NEGATIVE, NEGATIVE),
  u  = new PVector(NEGATIVE, NEGATIVE);
  int rx, ry;
  int f = 0;
  int rt = 0;
  float a = 0;
  float au = 45;
  int aCount = 0;
  int aOffset = 0;
  int rChange = 90;
  int rDir = 1;
  int strength = UNIT_STRENGTH;
  
  
  
  Unit() {
    this.au = round(random(0, 180));
    this.x = round(random(0, width));
    this.y = round(random(0, height));
    this.aOffset  = round(random(0, 90));
    this.a = 90;//round(random(0, 360));
    this.aCount  = 90;//round(random(0, rChange));
    
    println("Unit created: x = ", x, ", y = ", y);
  }
  
  boolean shoot(int shootX, int shootY){
    boolean isKilled = false;
    println("shootX = ", shootX, "shootY = ", shootY);
    println("u.x = ", u.x, "u.y = ", u.y);
    println("strength = ", strength);
    
    if(sqrt(pow((u.x - shootX), 2) + pow((u.y - shootY), 2)) <= UNIT_SIZE/2) {
      println("SHOOT!!!");
      strength--;
      if(strength == 0) {
         isKilled = true;
      }
      //shot++;
    }
    return isKilled;
  }
  
  
  void refresh() {
    if(strength > 0){
    rt = round(random(20, 40));
    if(f>rt)
    {
        rx=round(random(-UNIT_STEP/2, UNIT_STEP/2));
        ry=round(random(-UNIT_STEP, UNIT_STEP));
        f=0;
    }
    f++;
    x+=rx;
    y+=ry;
    a+=UNIT_ANGLE*rDir;
    //println(a);
    g = rotation(x, y, 0, UNIT_RADIUS, a);
    if(aCount>=rChange){
    aCount = 0;
    switch(rDir){
      case 1:
      rDir = -1;
      break;
      case -1:
      rDir = 1;
      break;
    }
    }
    float uAngle = (a-(rDir*a*a)/45);
    u = rotation(g.x, g.y, 0, 120, uAngle);
    
    if(u.x > width - UNIT_PADDING) x -= UNIT_STEP;
    if(u.y > height - UNIT_PADDING) y -= UNIT_STEP;
    if(u.x < UNIT_PADDING) x += UNIT_STEP;
    if(u.y < UNIT_PADDING) y += UNIT_STEP;
    
    fill(80*strength);
    fill(90, 250, 140);
    
    float colorCorrection = strength*(254/(UNIT_STRENGTH));
    fill(255 - colorCorrection, colorCorrection, 0);
    noStroke();
    /*ellipse(u.x, u.y, UNIT_SIZE, UNIT_SIZE);
    ellipse(g.x, g.y, 10, 10);
    ellipse(x, y, 10, 10);*/
    rect(u.x-60, u.y-80, strength*40, 10);
    imageMode(CENTER);
    //rotate(radians(uAngle));
    translate(u.x, u.y);
    //scale(0.5);
    rotate(radians(uAngle));
    int absA = abs(round(a));
    if(absA==0||absA==10||absA==15){
      image(UNIT_SHOOT_IMG, 0, 0);
    }
    else{
      image(UNIT_IMG, 0, 0);
    }
    rotate(radians(-uAngle));
    //scale(2);
    translate(-u.x, -u.y);
      aCount++;
    
    
    }
    else {
      u.x = NEGATIVE;
      u.y = NEGATIVE;
    }
  }
  
  PVector rotation(float a, float b, float x, float y, float alpha)
  {
     
     float alpradian = ((alpha * PI) / 180);
     int rad=round(sqrt((x*x)+(y*y)));
     float betta = asin(x/ (sqrt((x*x)+(y*y))) );
     return new PVector(round((rad*sin(alpradian+betta))+a), round((rad*cos(alpradian+betta))+b));
  }
 
}