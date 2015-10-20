class Scrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  Scrollbar (float xp, float yp, int sw, int sh, int l) {
    //taille graphique
    swidth = sw;
    sheight = sh;
    
    //interval
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    
    //position graphique
    xpos = xp;
    ypos = yp-sheight/2;
    
    //position graphique du curseur
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
      float interval = sposMax - sposMin;
      float tmpPos = newspos - sposMin;
      if(tmpPos < interval) {
        if(tmpPos < 3*interval/4) {
          if(tmpPos < interval/2) {
            if(tmpPos < interval/4) {
              tmpPos = 0;
            } else {
              tmpPos = interval/4;
            }
          } else {
            tmpPos = interval/2;
          }
        } else {
          tmpPos = 3*interval/4;
        }
      } else {
        tmpPos = interval;
      }
      newspos = tmpPos + sposMin;
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    //return spos * ratio;
    return spos;
  }
}
