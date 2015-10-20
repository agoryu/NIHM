class City { 
  //info ville
  int postalcode; 
  String name; 
  float population; 
  float density;
  
  //info position affichage
  float x; 
  float y;
  float yGap = 20;
  float popEchelle;
  
  //couleur
  color black = color(0);
  color red = color(255,0,0);
  color yellow = color(255,255,0);
  color blue = color(0,0,255);
  
  //info interaction
  boolean isSelected;
  boolean isClic;
  
  float maxDensity;
  float maxPopulation;

  public City(float x, float y, float population, float surface, String name, float maxPopulation) {
    this.x = x;
    this.y=y;
    this.population = population;
    
    //calcul de la densite
    if(surface < 1.0) {
      this.density = surface;
    } else {
      this.density = population/surface;
    }
    this.name = name;
    this.isSelected = false;
    this.isClic = false;
    
    //popEchelle = log(population)*2;
    popEchelle = sqrt(this.population * 100 / maxPopulation) * 10;
   
  }
  
   public void drawCity(int echelle) {

     float sizeCity = popEchelle * echelle;
     noStroke();
     noFill();
     
     if(this.isSelected == true) {
       
       //creation du rectangle contenant le nom de la ville
       strokeWeight(5);
       stroke(black); 
       rect((int)(mapX(x)+sizeCity/2+5), (int)(mapY(y)+5), 
       textWidth(name+"   "), 20);
       
       //gestion du changement de couleur du nom de la ville
       if(isClic)
         fill(blue);
       else
         fill(black);
       
       //affichage du nom de la ville  
       text(name, (int)(mapX(x)+sizeCity/2+9), (int)(mapY(y)+20));
     }
     
     //affichage du cercle
     fill(lerpColor(yellow, red, (density/maxDensity) * 255));
     ellipse((int) mapX(x), (int) mapY(y)+yGap, sizeCity, sizeCity);
   }
   
   public boolean contains(int px, int py) {
     float radius = popEchelle/2;
     return dist((int)mapX(x), (int)mapY(y)+yGap, px, py) <= radius + 1;  
   }
   
   public String toString() {
     return name;
   }
   
   public void setIsSelected(boolean b) {
     this.isSelected = b;
   }
   
   public void isClic(boolean b) {
     this.isClic = b;
   }
   
   public float getDensity() {
     return this.density;
   }
   
   public void setMaxDensity(float maxDensity) {
     this.maxDensity = maxDensity;
   }
}
