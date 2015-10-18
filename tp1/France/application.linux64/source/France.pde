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

void setup() { 
  size(1400,800);
  readData();
  SizeScrollX = (int)(2*maxPopulation/10000);
  sc = new Scrollbar(posScrollX, posScrollY, SizeScrollX, SizeScrollY, 1);
} 

void mousePressed() {
  City c = pick(mouseX, mouseY);
  if(c != null) {
    c.isClic(true);
  }
}

void mouseMoved() {
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

void  keyPressed() {
  if(key==CODED) {
    if(keyCode == UP) {
      minPopulationToDisplay += 100;
    } else if(keyCode == DOWN) {
      minPopulationToDisplay -= 100;
    }    
  }
  redraw();
}

void draw(){ 
  
  int limite = (int)(10000 * ((sc.getPos() - posScrollX) / SizeScrollX));
  
  background(255);
  fill(color(0));
  
  //affichage du slider
  text("Afficher les populations supérieures à", posScrollX+100, posScrollY-30);
  text("0", posScrollX-15, posScrollY);
  text("10000", posScrollX+SizeScrollX+20, posScrollY);
  text(limite, sc.getPos(), posScrollY-15);
  sc.update();
  sc.display();
  
  //affichage de la legende de couleur
  color red = color(255,0,0);
  color yellow = color(255,255,0);
  fill(color(0));
  text("Densité de population", posScrollX, posScrollY+80);
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

void readData() { 
  String[] lines = loadStrings("../villes.tsv"); 
  parseInfo(lines[0]); 
  country = new City[totalCount];
 
 int maxDensity = 0;
  
  for (int i = 2 ; i < totalCount ; ++i) { 
    String[] columns = split(lines[i], TAB); 
    country[i-2] = new City(float(columns[1]), float(columns[2]), 
    float(columns[5]), float(columns[6]), columns[4], maxPopulation);
   
    if(country[i-2].getDensity() > maxDensity) {
      maxDensity = int(country[i-2].getDensity());
    } 
  }
  
  for(int i=0; i<totalCount-2; i++) {
    country[i].setMaxDensity(maxDensity);
  }
}

void parseInfo(String line) { 
  String infoString = line.substring(2); // remove the # 
  String[] infoPieces = split(infoString, ','); 
  totalCount = int(infoPieces[0]); 
  minX = float(infoPieces[1]); 
  maxX = float(infoPieces[2]); 
  minY = float(infoPieces[3]); 
  maxY = float(infoPieces[4]); 
  minPopulation = float(infoPieces[5]); 
  maxPopulation = float(infoPieces[6]); 
  minSurface = float(infoPieces[7]); 
  maxSurface = float(infoPieces[8]); 
  minAltitude = float(infoPieces[9]); 
  maxAltitude = float(infoPieces[10]); 
}

float mapX(float x) {
  return map(x, minX, maxX, 0, 800);
}

float mapY(float y) {
  return map(y, minY, maxY, 800, 0);
}

City pick(int px, int py) {
  for (int i = totalCount-3; i >= 0; i--) {
    if(country[i].contains(px, py)){
      return country[i]; 
    }
  }
  return null;
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == 2) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
