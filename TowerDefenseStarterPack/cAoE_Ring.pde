//Some classes place AoE rings on the map. The AoE ring
//hurts all mobs in the ring. The ring only lasts for a
//short period of time.

class AoE_Ring {
  float x, y, r;
  int time;

  AoE_Ring(float X, float Y) {
    x = X;
    y = Y;
    r = 75;
    time = 0;
  }

  void show() {
    strokeWeight(1);
    stroke(white);
    fill(255,255,255,25);
    circle(x, y, r*2);
  }

  void act() {

    //deduct hp
    for (int i=0; i < parsas.size(); i++) {
      Mob pNow = parsas.get(i);
      if (dist(pNow.x, pNow.y, x, y) < r) {
        if (frameCount % 10 == 0) pNow.hp --; 
      }
    }
    //increase counter
    time++;
    if (time > 20) {
      rings.remove(this);
    }
  }
}
