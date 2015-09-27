class City { 
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  color black = color(0);
  color red = color(255,0,0);
  // put a drawing function in here and call from main drawing loop } 

  public City(float x, float y, float population, float density) {
    this.x = x;
    this.y=y;
    this.population = population;
    this.density = density;
  }
   void drawCity() {
     //float air = PI/4*population/10000;
     float popEchelle = population/10000;
     fill(lerpColor(black, red, density/maxSurface*10));
     ellipse((int) mapX(x), (int) mapY(y), popEchelle, popEchelle);
   }
   
   public String toString() {
     return "x:"+x+" y:"+y;
   }
}
