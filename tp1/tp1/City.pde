class City { 
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  color black = color(0);
  color red = color(255,0,0);
  boolean isSelected;
  // put a drawing function in here and call from main drawing loop } 

  public City(float x, float y, float population, float density, String name) {
    this.x = x;
    this.y=y;
    this.population = population;
    this.density = density;
    this.name = name;
    this.isSelected = false;
  }
  
   public void drawCity() {
     //float air = PI/4*population/10000;
     float popEchelle = population/10000;
     if(this.isSelected == true) {
       strokeWeight(5);
       stroke(0,0,255);
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
}
