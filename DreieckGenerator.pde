int numTriangles = 12000;       // mehr = dichter
float scaleFactor = 380;        // Größe des gesamten Musters

// Dein Polynom – einfach hier ändern!
float polynom(float r, float theta, int mode){
  float poly = 0;
  switch(mode){
    case 1:
      poly =  r*r*r; break;                          // 3-blättrig
    case 2:
      poly = r*r*r*r*r; break;                    // 5-blättrig
    case 3:
      poly =  r*r * sin(7*theta); break;           // klassische 7-blättrige Rose
    case 4:
      poly =  r*r*r * cos(6*theta); break;         // Stern
    case 5:
      poly = pow(r, 8) * (1 + 0.3*sin(13*theta)); break;// wild & schön
    case 0:
      poly = r*r*r*(random(0.1, 6)) + r*r*(random(0.1, 6))+r*(random(0.1, 6)); break;
  };
  return poly;
}

void setup(){
   size(1000, 1000);
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  noStroke();
  blendMode(ADD);              // für leuchtende Farben (oder entfernen für klare Farben)
  zeichne();
}

void draw(){}

void zeichne(){
  translate(width/2, height/2);
  int mode = int(random(6));

  for (int i = 0; i < numTriangles; i++) {
    float theta = random(TWO_PI);               // Winkel
    float rBase = random(0.01, 1.0);             // Radius-Basis (0..1)
    
    // Hier kommt dein Polynom ins Spiel
    float r = polynom(rBase, theta, mode) * scaleFactor;
    
    // Jetzt werden x und y wirklich benutzt!
    float x = r * cos(theta);
    float y = r * sin(theta);
    
    // Farbe je nach Winkel und Position
    float hue = (theta/TWO_PI * 360 + frameCount*0.5 + i*0.01) % 360;
    fill(hue, 80, 95, 60);                      // halbtransparent → Überlagerungseffekt
    
    pushMatrix();
    translate(x, y);                  // Dreieck wird an die berechnete Stelle verschoben
    rotate(theta);                    // Dreieck zeigt radial nach außen
    triangle(0, -10, -8, 10, 8, 10); // Spitze nach außen
    popMatrix();
  }
}

// Mausklick = komplett neues Muster
void mousePressed() {
  background(0);
  setup();
}

// s = speichern
void keyPressed(){
  char k = key;
  if (k == 's' || key == 'S') {
    saveFrame("dreiecke-polynom-####.png");
    println("Gespeichert!");
  }
  if (k == 'n' || key == 'N') {
    background(0);
    zeichne();
  }
}
