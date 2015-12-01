int num = 500;
float mx[] = new float[num];
float my[] = new float[num];

int Width = 1400;
int Height = 900;

int cpt = 0;

void setup() {
  size(Width,Height);
  noStroke();
  fill(0); 
}

void draw() {
  
  background(255); 
  
  drawShape();
  
  for (int i = 0; i < cpt; i++) {
    // which+1 is the smallest (the oldest in the array)
    ellipse(mx[i], my[i], 5, 5);
  }
  
}

void mouseDragged() {
   mx[cpt] = mouseX;
   my[cpt] = mouseY;
   ellipse(mx[cpt], my[cpt], 5, 5);
   cpt++;
}

void mouseReleased() {
  analyse();
  cpt = 0;
}

void drawShape() {
  fill(255,0,0);
  ellipse(Width/4, Height/4, 55, 55);
  
  fill(0,255,0);
  ellipse(3*Width/4, Height/4, 55, 55);
  
  fill(0,0,255);
  ellipse(Width/2, 3*Height/4, 55, 55);
  
  fill(0);
}

void analyse() {
  if(cpt < 1)
    return;
    
  int sumX = 0;
  int sumY = 0;
  
  for(int i = 0; i<cpt; i++) {
    sumX += mx[i];
    sumY += my[i]; 
  }   
  
  int moyenneX = sumX / cpt;
  int moyenneY = sumY / cpt;
}
