PImage img;
int numStrokes = int(random(10000, 100000));  // Mehr = detaillierter, aber langsamer (20000–100000)

void setup() {
  size(1000, 1000);  // Passe an dein Bild an
  
  // ← Dein Bild hier laden (im Sketch-Ordner ablegen!)
  img = loadImage("mona.jpg");  // z.B. "landschaft.png"
  
  if (img == null) {
    println("Bild nicht gefunden!");
    noLoop();
    return;
  }
  
  img.resize(width, height);
  background(255);  // Weißer Hintergrund als Basis (kann zu img-Farbe geändert werden)
  noStroke();
  noLoop();
}

void draw() {
  for (int i = 0; i < numStrokes; i++) {
    // Zufälliger Punkt im Bild
    int x = (int)random(width);
    int y = (int)random(height);
    
    // Farbe aus Originalbild (mit leichter Perturbation für malerischen Effekt)
    color c = img.get(x, y);
    float r = red(c) + random(-20, 20);
    float g = green(c) + random(-20, 20);
    float b = blue(c) + random(-20, 20);
    fill(r, g, b, random(150, 255));  // Halbtransparent für Überlagerung
    
    // Kleiner "Pinselstrich": Ellipse mit Random-Größe und -Form
    float strokeSize = random(4, 12);  // Passe für gröbere/feinere Striche
    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI));  // Zufällige Richtung für Dynamik
    ellipse(0, 0, strokeSize * random(1, 3), strokeSize);  // Länglich für Strich-Effekt
    popMatrix();
  }
  
  // Optional: Leichter Blur für noch weicheren Impressionismus
  filter(BLUR, 1);
}

// Mausklick = neues impressionistisches Bild
void mousePressed() {
  numStrokes = int(random(10000, 100000));
  background(255);
  redraw();
}

// Taste 's' = speichern
void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("impressionismus-####.png");
    println("Gespeichert!");
  }
}
