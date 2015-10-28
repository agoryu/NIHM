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
  
  float echelle;

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
    
    this.echelle = 0;
   
  }
  
   public void drawCity(int echelle, float posZoomX, float posZoomY) {

     float sizeCity = popEchelle * echelle;
     int posX = (int)(mapX(this.x)*echelle + posZoomX * echelle);// + (posZoomX - mapX(this.x)*echelle));
     int posY = (int)((mapY(this.y)+yGap)*echelle + posZoomY * echelle);// + (posZoomY - mapY(this.y)*echelle));
     noStroke();
     noFill();
     
     if(this.isSelected == true) {
       
       //creation du rectangle contenant le nom de la ville
       strokeWeight(5);
       stroke(black); 
       rect((int)((mapX(x)+sizeCity/2)*echelle)+5, (int)(mapY(y)*echelle)+5, 
       textWidth(name+"   "), 20);
       
       //gestion du changement de couleur du nom de la ville
       if(isClic)
         fill(blue);
       else
         fill(black);
       
       //affichage du nom de la ville  
       text(name, (int)((mapX(x)+sizeCity/2)*echelle)+9 + posZoomX*echelle, (int)(mapY(y)*echelle)+20+posZoomY*echelle);
     }
     
     //affichage du cercle
     fill(lerpColor(yellow, red, (density/maxDensity) * 255));
     ellipse((int) posX, (int) posY, sizeCity, sizeCity);
   }
   
   public boolean contains(int px, int py, int echelle, int posZoomX, int posZoomY) {
     float radius = popEchelle/2;
     return dist((int)mapX(x)*echelle + posZoomX*echelle, (int)(mapY(y)+yGap)*echelle + posZoomY * echelle, px, py) <= radius + 1;  
   }
   
   public String toString() {
     return name;
   }
   
   public float getX() {
     return mapX(this.x);
   }
   
   public float getY() {
     return mapY(this.y);
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