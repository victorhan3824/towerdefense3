//A Tower is the player's main defense against the mobs.
//Towers are placed on the maps and then automatically
//act. There are 3 kinds of towers (but you can make more!)

//Gun Tower: These towers shoot bullets that fly across
//           the screen and do damage to mobs.

//AoE Tower: These towers place AoE_Rings that deal damage
//           to all mobs in the ring.

//Sniper Tower: These towers automatically target the first
//              mob no matter where they are on the scren.

class Tower {
  final int PLACING = 0; //this mode is when we are selcting locations, 
                         //tower follows the mouse
  final int PLACED = 1; //this mode means tower is in place
  
  float x, y;
  int charge, threshold;
  int status; //sets the placing status
  int type; //determine the type of tower
  int price;
  
  Tower(int T) {
    x = mouseX;
    y = mouseY;
    status = PLACING;
    type = T;
    charge = 0;
    
    if (this.type == GUN) {
      threshold = 100;
      price = 10;
    }  
    
    if (this.type == SNP) {
      threshold = 60;
      price = 20;
    }
    
    if (this.type == GAL) {
      threshold = 80;
      price = 40;
    }
  }
//=================================================== 
  void show() {
    stroke(black);
    strokeWeight(4);
    fill(nBlue);
    animatingTower();
  }
  
  void act() {
    if (type == GUN) actGUN();
    if (type == SNP) actSNP();
    if (type == GAL) actGAL();
  }
  
//===================================================
  void animatingTower() {
    if (status == PLACED) {
      showTowers(x,y);
    } else if (status == PLACING) {
      clickable = false;
      stroke(red);
      noFill();
      rect(325,217.5+75,650,435);
      showTowers(mouseX, mouseY); //towers follow mouse
      if (mousePressed && allowPlace()) { //when user have click on desired location
        status = PLACED;
        clickable = true;
        x = mouseX;
        y = mouseY;
        money = money - this.price;
      }
    }
  }
  
  boolean allowPlace() {
    return(mouseX > 0 && mouseX < 650 && mouseY > 75 && mouseY < 510);  //restrict top right
  }
  
  void showTowers(float X, float Y) {
    image(towerImages[type], X, Y);
  }
  
  void actGUN() { //fire bullets and calculate cooldown
    charge++; 
    if (charge >= threshold) { //when charge reach the threshold
      charge = 0;
      shells.add(new Bullet(this.x, this.y, 0, -20,200)); //upward shell
      shells.add(new Bullet(this.x, this.y, 0, 20,200)); //down
      shells.add(new Bullet(this.x, this.y, 20, 0,200)); //right
      shells.add(new Bullet(this.x, this.y, -20, 0,200)); //left
    }      
  }
  
  void actSNP() { //sniper tower act
  
    if (parsas.size() > 0) {
      color filled = black;
      
      if (charge < threshold) {
        filled = black;
      }
      else if (charge == threshold) {
        parsas.get(0).hp --;
      }
      else if (charge > threshold) {
        filled = white;
        if (charge >= threshold + 10) charge = 0;
      }
      charge++;
      
      strokeWeight(1);
      stroke(filled);
      line(x,y,parsas.get(0).x,parsas.get(0).y);      
    }
  }
  
  void actGAL() {
    charge++; 
    if (charge >= threshold) { //when charge reach the threshold
      charge = 0;
      rings.add(new AoE_Ring(x, y));
    }
  }  
  
}  
