class Game {
  Unit[] units = new Unit[100];
  int[] shootOffset = SHOOT_OFFSET;
  float r = 0;
  int unitId = 0;
  int unitKilled = 0;
  
  Game() {
    /*units = new Unit[qty];
    for(int i = 0; i < qty; i++) {
      units[i] = new Unit();
    }*/
    
  }
  
  void reloadUnits(){
     unitId = 0;
     units = new Unit[100];
  }
  
  void initUnit(){
    units[unitId++] = new Unit();
  }
  
  int getUnitQty() {
    int qty = 0;
    for(int i = 0; i < unitId; i++) {
      if(units[i].strength > 0) {
        qty++;
      }
    }
    return qty;
  }
  
  int getKilledUnitQty() {
    return unitId - getUnitQty();
  }
  
  void shoot(int x, int y){
    for(int i = 1; i < SHOOT_QTY; i++) {
      stroke(0, 255, 100, shootOffset[i-1]*((i*SHOOT_OPACITY)));
      noFill();
      r = SHOOT_STEP*i;
      ellipse(x, y, r, r);
    }
  }
  
  void shiftShootOffset() {
    int first = shootOffset[0];
    for(int i = 0; i < shootOffset.length - 1; i++){
      shootOffset[i] = shootOffset[i + 1];
    }
    shootOffset[shootOffset.length - 1] = first;
  }
  
  void printShootOffset() {
    for(int i = 0; i < shootOffset.length; i++){
      print(shootOffset[i], " ");
    }
    println();
  }
  
  void refreshUnits() {
    for(int i = 0; i < unitId; i++) {
      if(STATE==1) {
         units[i].refresh();
      }
    }
  }
  
  int shootUnits(int shootX, int shootY) {
    int shots = 0;
    for(int i = 0; i < unitId; i++) {
      if(units[i].shoot(shootX, shootY)){
        shots++;
      }
    }
    return shots;
  }
  
  int getSummStrength(){
    int summ = 0;
    for(int i = 0; i < unitId; i++) {
      summ += units[i].strength;
    }
    return summ;
  }
}