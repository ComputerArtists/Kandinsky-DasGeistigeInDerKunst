void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100, 100);
  background(220, 20, 98);        // sehr helles, warmes Weiß/Gelbweiß
  noStroke();
  smooth();
  blendMode(MULTIPLY);            // oder ADD für leuchtendere Variante
}

void draw() {
  // leichter Fade für sanfte Überlagerung bei jedem Klick
  fill(220, 15, 98, 8);
  rect(0, 0, width, height);
  
  translate(width/2, height/2);

  int numCircles = 60;            // mehr = dichter

  for (int i = 0; i < numCircles; i++) {
    // Zufälliges Zentrum (exzentrisch)
    float centerX = random(-220, 220);
    float centerY = random(-220, 220);
    
    // Radius zwischen 20 und 600
    float r = random(20, 600);
    
    // Nur Gelb- und Blautöne
    float hue = random(1) < 0.5 ? 
                random(45, 65) :      // Gelb bis Goldgelb (45–65)
                random(190, 240);     // Blau bis Cyanblau (190–240)
                
    float saturation = random(30, 95);
    float brightness = random(70, 100);
    float alpha      = random(15, 55);    // transparent → schöne Schichtung
    
    fill(hue, saturation, brightness, alpha);
    
    // 70% konzentrisch (Zentrum genau Mitte), 30% exzentrisch
    if (random(1) < 0.7) {
      circle(0, 0, r*2);                  // perfekt konzentrisch
    } else {
      circle(centerX, centerY, r*2);      // leicht versetzt = exzentrisch
    }
  }
  
  noLoop();    // einmal zeichnen und fertig (klick für neu)
}

void mousePressed() {
  redraw();    // neues Bild bei jedem Klick
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("gelb-blau-kreise-####.png");
    println("Gespeichert!");
  }
  if (key == 'b') blendMode(ADD);       // Bonus: mit Taste b auf ADD umschalten
  if (key == 'm') blendMode(MULTIPLY);  // mit m zurück zu MULTIPLY
}
