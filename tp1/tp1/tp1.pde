//globally 
//declare the min and max variables that you need in parseInfo 
float minX, maxX; 
float minY, maxY; 
int totalCount; // total number of places 
float minPopulation, maxPopulation; 
float minSurface, maxSurface; 
float minAltitude, maxAltitude; //in your readData method 

//declare the variables corresponding to the column ids for x and y 
int X = 1; 
int Y = 2; 
// and the tables in which the city coordinates will be stored 
float x[]; 
float y[];

void setup() { 
  size(800,800); 
  //readData();
} 

void draw(){ 
  background(255); 
}

void readData() { 
  String[] lines = loadStrings("../villes.tsv"); 
  parseInfo(lines[0]); // read the header line
  x = new float[totalCount]; 
  y = new float[totalCount];
  
  for (int i = 2 ; i < totalCount ; ++i) { 
    String[] columns = split(lines[i], TAB); 
    x[i-2] = float (columns[1]); 
    y[i-2] = float (columns[2]); 
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
