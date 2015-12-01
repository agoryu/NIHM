class Scrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  
  float spos2, newspos2;    // x position of slider 2

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
    spos2 = xpos + swidth - sheight;
    newspos2 = spos2;
    
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (mousePressed) {
      if(overEvent() == 1) {
        newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
      } else if(overEvent() == 2) {
        newspos2 = constrain(mouseX-sheight/2, sposMin, sposMax);
      }
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
    if (abs(newspos2 - spos2) > 1) {
      spos2 = spos2 + (newspos2-spos2)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  int overEvent() {
    if(mouseX > 0 && mouseX <= spos+sheight &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return 1;
    } else if(mouseX > spos+sheight && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return 2;
    }
    
    return 0;
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
    rect(spos2, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    //return spos * ratio;
    return spos;
  }
  
  float getPos2() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    //return spos * ratio;
    return spos2;
  }
}