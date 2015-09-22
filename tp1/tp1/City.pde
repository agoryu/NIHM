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
     //fill(255,0,);
     float air = PI/4*population/1000;
     ellipse((int) mapX(x), (int) mapY(y), air, air);
   }
   
   public String toString() {
     return "x:"+x+" y:"+y;
   }
}
