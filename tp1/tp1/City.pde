class City { 
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  color black = color(0);
  color red = color(255,0,0);
  color blue = color(0,0,255);
  boolean isSelected;
  boolean isClic;
  // put a drawing function in here and call from main drawing loop } 

  public City(float x, float y, float population, float density, String name) {
    this.x = x;
    this.y=y;
    this.population = population;
    this.density = density;
    this.name = name;
    this.isSelected = false;
    this.isClic = false;
  }
  
   public void drawCity() {
     //float popEchelle = population/100/PI;
     float popEchelle = population/10000;
     noStroke();
     noFill();
     if(this.isSelected == true) {
       strokeWeight(5);
       stroke(black); 
       rect((int)(mapX(x)+popEchelle/2+5), (int)(mapY(y)+5), 
       textWidth(name+"   "), 20);
       if(isClic)
         fill(blue);
       else
         fill(black);
       text(name, (int)(mapX(x)+popEchelle/2+9), (int)(mapY(y)+20));
     }
     fill(lerpColor(black, red, density/maxSurface*10));
     ellipse((int) mapX(x), (int) mapY(y)+50, popEchelle, popEchelle);
   }
   
   public boolean contains(int px, int py) {
     float radius = population/10000/2;
     return dist((int)mapX(x), (int)mapY(y)+50, px, py) <= radius + 1;  
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
}
