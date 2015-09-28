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

void setup() { 
  size(800,800); 
  readData();
} 

void mouseMoved() {
  City c = pick(mouseX, mouseY);
  /*if(c!=null) {
    c.setIsSelected(true);
  }*/
  if(c != citySelected) {
    if(citySelected != null)
      citySelected.setIsSelected(false);
    if(c != null){
      c.setIsSelected(true);
      citySelected = c;
    }
    println("mouseX = "+mouseX+" | mouseY = "+mouseY+" | city = "+c);   
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
  background(255);
  fill(color(0));
  text("Afficher les populations supérieures à "+minPopulationToDisplay, 300, 30);
  for (int i = 0 ; i < totalCount - 2; i++) {
    if(country[i].population >= minPopulationToDisplay)
      country[i].drawCity(); 
  }
}

void readData() { 
  String[] lines = loadStrings("../villes.tsv"); 
  parseInfo(lines[0]); // read the header line
  country = new City[totalCount]; 
  
  for (int i = 2 ; i < totalCount ; ++i) { 
    String[] columns = split(lines[i], TAB); 
    country[i-2] = new City(float(columns[1]), float(columns[2]), 
    float(columns[5]), float(columns[6]), columns[4]); 
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
