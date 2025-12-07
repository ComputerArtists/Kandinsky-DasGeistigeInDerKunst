void setup() {
  size(1000, 1000);
  background(240, 235, 220); // leicht cremefarbener Hintergrund wie altes Papier
  smooth();
  noLoop();
  
  // Zufallssamen festlegen, wenn du später reproduzierbare Bilder willst:
  // randomSeed(1234);
  // noiseSeed(1234);
}

void draw() {
  // Ein paar große, halbtransparente Farbflächen als Grundstimmung
  drawColorFields();
  
  // Geometrische Formen (Kreise und Rechtecke mit kräftigen Farben
  drawGeometricShapes(80);
  
  // Freie, schwungvolle Linien und Kritzeleien
  drawFreeLines(60);
  
  // Kleine Akzente und Punkte
  drawAccents();
  
  // Optional: einen leichten "Papier-Textur"-Overlay
  drawPaperTexture();
}

void drawColorFields() {
  noStroke();
  for (int i = 0; i < 8; i++) {
    fill(random(30, 255), random(30, 255), random(30, 255), random(30, 80));
    float x = random(width);
    float y = random(height);
    float w = random(200, 700);
    float h = random(200, 700);
    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI));
    rect(-w/2, -h/2, w, h, random(80));
    popMatrix();
  }
}

void drawGeometricShapes(int amount) {
  for (int i = 0; i < amount; i++) {
    float x = random(width);
    float y = random(height);
    float size = random(20, 300);
    
    // Zufällige Kandinsky-ähnliche Farben (kräftig, oft Primär + Schwarz/Weiß)
    color[] palette = {
      color(255, 0, 0),      // Rot
      color(0, 70, 255),    // Blau
      color(255, 220, 0),    // Gelb
      color(0, 0, 0),       // Schwarz
      color(255, 255, 255), // Weiß
      color(255, 100, 0),   // Orange
      color(0, 160, 100),   // Grün
      color(180, 0, 180)    // Violett
    };
    fill(palette[int(random(palette.length))]);
    
    
    
    float choice = random(1);
    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI));
    
    if (choice < 0.4) {
      // Kreis
      ellipse(0, 0, size, size);
      // manchmal konzentrische Kreise wie bei "Several Circles"
      if (random(1) < 0.3) {
        fill(palette[int(random(palette.length))]);
        ellipse(0, 0, size*0.6, size*0.6);
      }
    } else if (choice < 0.7) {
      // Dreieck
      triangle(-size/2, size/3, size/2, size/3, 0, -size/2);
    } else {
      // Rechteck oder Quadrat
      rectMode(CENTER);
      rect(0, 0, size, size*random(0.3, 2.5), random(30));
    }
    popMatrix();
    
    // Manchmal schwarze oder weiße Kontur
    if (random(1) < 0.35) {
      pushMatrix();
      translate(x, y);
      rotate(random(TWO_PI));
      noFill();
      strokeWeight(random(2, 12));
      stroke(0); // oder 255 für weiße Linie
      if (choice < 0.4) ellipse(0, 0, size, size);
      else rectMode(CENTER); rect(0, 0, size, size*random(0.3, 2.5));
      popMatrix();
    }
  }
}

void drawFreeLines(int amount) {
  for (int i = 0; i < amount; i++) {
    strokeWeight(random(1, 14));
    stroke(random(255), random(255), random(255), random(100, 255));
    
    float x = random(-200, width+200);
    float y = random(-200, height+200);
    
    noFill();
    beginShape();
    for (int j = 0; j < random(8, 25); j++) {
      x += random(-80, 80);
      y += random(-80, 80);
      curveVertex(x, y);
    }
    endShape();
  }
}

void drawAccents() {
  // Kleine bunte Punkte und Striche als Akzente
  for (int i = 0; i < 300; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(3, 25);
    
    fill(random(255), random(255), random(255), random(150, 255));
    noStroke();
    if (random(1) < 0.6) {
      ellipse(x, y, s, s);
    } else {
      strokeWeight(random(2,8));
      line(x-s, y, x+s, y);
    }
  }
}

void drawPaperTexture() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float n = noise(i%width*0.03, i/width*0.03)*50;
    color c = pixels[i];
    pixels[i] = color(red(c)+n-25, green(c)+n-25, blue(c)+n-25);
  }
  updatePixels();
}

// Klick → neues Bild
void mousePressed() {
  redraw();
}

// Taste s → Bild speichern
void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("kandinsky-####.png");
    println("Bild gespeichert!");
  }
}
