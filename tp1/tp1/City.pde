class City { 
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  // put a drawing function in here and call from main drawing loop } 

  public City(float x, float y, float population, float density) {
    this.x = x;
    this.y=y;
    this.population = population;
    this.density = density;
  }
   void drawCity() {
     color black = color(0);
     //set((int) mapX(x), (int) mapY(y), black);
     ellipse((int) mapX(x), (int) mapY(y), density/2, density/2);
   }
   
   public String toString() {
     return "x:"+x+" y:"+y;
   }
}
