import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class France extends PApplet {

//globally 
//declare the min and max variables that you need in parseInfo 
float minX, maxX; 
float minY, maxY; 
int totalCount; // total number of places 
float minPopulation, maxPopulation; 
float minSurface, maxSurface; 
float minAltitude, maxAltitude; //in your readData method 
int minPopulationToDisplay = 10000;
City citySelected;

//declare the variables corresponding to the column ids for x and y 
int X = 1; 
int Y = 2; 
City country[];

Scrollbar sc;
int posScrollX = 900;
int posScrollY = 60;
int SizeScrollX;
int SizeScrollY = 20;

public void setup() { 
  size(1400,800);
  readData();
  SizeScrollX = (int)(2*maxPopulation/10000);
  sc = new Scrollbar(posScrollX, posScrollY, SizeScrollX, SizeScrollY, 1);
} 

public void mousePressed() {
  City c = pick(mouseX, mouseY);
  if(c != null) {
    c.isClic(true);
  }
}

public void mouseMoved() {
  City c = pick(mouseX, mouseY);

  if(c != citySelected) {
    if(citySelected != null)
      citySelected.setIsSelected(false);
    if(c != null){
      c.setIsSelected(true);
      citySelected = c;
    }
    
  }
   
}

public void  keyPressed() {
  if(key==CODED) {
    if(keyCode == UP) {
      minPopulationToDisplay += 100;
    } else if(keyCode == DOWN) {
      minPopulationToDisplay -= 100;
    }    
  }
  redraw();
}

public void draw(){ 
  
  int limite = (int)(10000 * ((sc.getPos() - posScrollX) / SizeScrollX));
  
  background(255);
  fill(color(0));
  
  //affichage du slider
  text("Afficher les populations sup\u00e9rieures \u00e0", posScrollX+100, posScrollY-30);
  text("0", posScrollX-15, posScrollY);
  text("10000", posScrollX+SizeScrollX+20, posScrollY);
  text(limite, sc.getPos(), posScrollY-15);
  sc.update();
  sc.display();
  
  //affichage de la legende de couleur
  int red = color(255,0,0);
  int yellow = color(255,255,0);
  fill(color(0));
  text("Densit\u00e9 de population", posScrollX, posScrollY+80);
  setGradient(posScrollX, posScrollY+100, 450, 40, yellow, red, 2);
  
  //affichage de la legende de la taille des cercles
  fill(color(0));
  noStroke();
  text("Nombre d'habitant", posScrollX, posScrollY+180);
  ellipse(posScrollX+50, (int) posScrollY+200, 20, 20);
  
  for (int i = 0 ; i < totalCount - 2; i++) {
    if(country[i].population >= limite)
      country[i].drawCity(); 
  }
}

public void readData() { 
  String[] lines = loadStrings("../villes.tsv"); 
  parseInfo(lines[0]); 
  country = new City[totalCount];
 
 int maxDensity = 0;
  
  for (int i = 2 ; i < totalCount ; ++i) { 
    String[] columns = split(lines[i], TAB); 
    country[i-2] = new City(PApplet.parseFloat(columns[1]), PApplet.parseFloat(columns[2]), 
    PApplet.parseFloat(columns[5]), PApplet.parseFloat(columns[6]), columns[4], maxPopulation);
   
    if(country[i-2].getDensity() > maxDensity) {
      maxDensity = PApplet.parseInt(country[i-2].getDensity());
    } 
  }
  
  for(int i=0; i<totalCount-2; i++) {
    country[i].setMaxDensity(maxDensity);
  }
}

public void parseInfo(String line) { 
  String infoString = line.substring(2); // remove the # 
  String[] infoPieces = split(infoString, ','); 
  totalCount = PApplet.parseInt(infoPieces[0]); 
  minX = PApplet.parseFloat(infoPieces[1]); 
  maxX = PApplet.parseFloat(infoPieces[2]); 
  minY = PApplet.parseFloat(infoPieces[3]); 
  maxY = PApplet.parseFloat(infoPieces[4]); 
  minPopulation = PApplet.parseFloat(infoPieces[5]); 
  maxPopulation = PApplet.parseFloat(infoPieces[6]); 
  minSurface = PApplet.parseFloat(infoPieces[7]); 
  maxSurface = PApplet.parseFloat(infoPieces[8]); 
  minAltitude = PApplet.parseFloat(infoPieces[9]); 
  maxAltitude = PApplet.parseFloat(infoPieces[10]); 
}

public float mapX(float x) {
  return map(x, minX, maxX, 0, 800);
}

public float mapY(float y) {
  return map(y, minY, maxY, 800, 0);
}

public City pick(int px, int py) {
  for (int i = totalCount-3; i >= 0; i--) {
    if(country[i].contains(px, py)){
      return country[i]; 
    }
  }
  return null;
}

public void setGradient(int x, int y, float w, float h, int c1, int c2, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      int c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == 2) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      int c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
class City { 
  //info ville
  int postalcode; 
  String name; 
  float population; 
  float density;
  
  //info position affichage
  float x; 
  float y;
  float yGap = 20;
  float popEchelle;
  
  //couleur
  int black = color(0);
  int red = color(255,0,0);
  int yellow = color(255,255,0);
  int blue = color(0,0,255);
  
  //info interaction
  boolean isSelected;
  boolean isClic;
  
  float maxDensity;
  float maxPopulation;

  public City(float x, float y, float population, float surface, String name, float maxPopulation) {
    this.x = x;
    this.y=y;
    this.population = population;
    
    //calcul de la densite
    if(surface < 1.0f) {
      this.density = surface;
    } else {
      this.density = population/surface;
    }
    this.name = name;
    this.isSelected = false;
    this.isClic = false;
    
    popEchelle = log(population)*2;
   
  }
  
   public void drawCity() {

     noStroke();
     noFill();
     
     if(this.isSelected == true) {
       
       //creation du rectangle contenant le nom de la ville
       strokeWeight(5);
       stroke(black); 
       rect((int)(mapX(x)+popEchelle/2+5), (int)(mapY(y)+5), 
       textWidth(name+"   "), 20);
       
       //gestion du changement de couleur du nom de la ville
       if(isClic)
         fill(blue);
       else
         fill(black);
       
       //affichage du nom de la ville  
       text(name, (int)(mapX(x)+popEchelle/2+9), (int)(mapY(y)+20));
     }
     
     //affichage du cercle
     fill(lerpColor(yellow, red, (density/maxDensity) * 255));
     ellipse((int) mapX(x), (int) mapY(y)+yGap, popEchelle, popEchelle);
   }
   
   public boolean contains(int px, int py) {
     float radius = popEchelle/2;
     return dist((int)mapX(x), (int)mapY(y)+yGap, px, py) <= radius + 1;  
   }
   
   public String toString() {
     //return "x:"+x+" y:"+y;
     return name;
   }
   
   public void setIsSelected(boolean b) {
     this.isSelected = b;
   }
   
   public void isClic(boolean b) {
     this.isClic = b;
   }
   
   public float getDensity() {
     return this.density;
   }
   
   public void setMaxDensity(float maxDensity) {
     this.maxDensity = maxDensity;
   }
}
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
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  public void update() {
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
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  public float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  public boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  public void display() {
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

  public float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    //return spos * ratio;
    return spos;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "France" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
