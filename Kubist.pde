PImage img;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(1000, 1000);
  
  // ← deinen Dateinamen hier eintragen!
  img = loadImage("yourimage.jpg");         // z. B. "portrait.jpg", "foto.png" ...
  
  if (img == null) {
    println("Bild nicht gefunden – liegt es wirklich im Sketch-Ordner?");
    noLoop();
    return;
  }
  
  img.resize(width, height);
  colorMode(HSB, 360, 100, 100);
  noLoop();
  
  generatePoints(600);      // 300 = grobe Facetten, 1000 = sehr fein
}

void draw() {
  voronoiCubismClean();
}

void voronoiCubismClean() {
  loadPixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float minDist = 999999;
      int closest = 0;
      
      for (int i = 0; i < points.size(); i++) {
        PVector p = points.get(i);
        float d = dist(x, y, p.x, p.y);
        if (d < minDist) {
          minDist = d;
          closest = i;
        }
      }
      
      // Jede Facette = eine einzige flache Farbe aus dem Original
      pixels[y * width + x] = (int)points.get(closest).z;
    }
  }
  
  updatePixels();
  // → KEINE Linien, KEINE Akzente – komplett clean!
}

void generatePoints(int amount) {
  points.clear();
  for (int i = 0; i < amount; i++) {
    float x = random(width);
    float y = random(height);
    color c = img.get((int)x, (int)y);
    points.add(new PVector(x, y, c));
  }
}

// Mausklick = neue Zerlegung
void mousePressed() {
  generatePoints((int)random(400, 900));
  redraw();
}

// s = speichern
void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("kubismus-clean-####.png");
    println("Sauber gespeichert!");
  }
}
