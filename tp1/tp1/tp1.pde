void setup() { 
  size(800,800); 
  readData();
} 

void draw(){ 
  background(255); 
}

void readData() { 
  String[] lines = loadStrings("../villes.tsv"); 
}
