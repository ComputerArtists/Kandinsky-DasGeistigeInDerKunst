import processing.sound.*;

SoundFile music;
FFT fft;
int bands = 512;
float[] spectrum = new float[bands];

float melodyAngle = 0;
float counterpointAngle = PI;

void setup() {
  size(1200, 800, P2D);           // Canvas bleibt 1200×800
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  // blendMode(ADD);
  smooth();
  noStroke();

  // ←←← DEINE MUSIKDATEI HIER ←←←
  music = new SoundFile(this, "01-1715452-CreCo-VollOrganTeil1.mp3");
  
  if (music == null) {
    println("Musik nicht gefunden!");
    noLoop();
    return;
  }
  
  fft = new FFT(this, bands);
  fft.input(music);
  music.loop();
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);        // weicher Fade
  
  fft.analyze(spectrum);

  // Alles wird um 75% verkleinert und zentriert
  pushMatrix();
  translate(width/2, height/2);
  scale(0.75);                       // ←←← hier die gewünschte Verkleinerung
  translate(-width/2, -height/2);    // wieder zurückzentrieren

  float bass = 0, mid = 0, high = 0;
  for (int i = 0; i < bands; i++) {
    if (i < 20)      bass  += spectrum[i];
    else if (i < 100) mid   += spectrum[i];
    else             high  += spectrum[i];
  }

  float melodySpeed = map(mid + high, 0, 1, 0.005, 0.08);
  float counterSpeed = map(bass, 0, 0.8, 0.003, 0.04);
  
  melodyAngle += melodySpeed;
  counterpointAngle += counterSpeed;

  float volume = bass*2 + mid*0.8 + high*0.5;
  float radius = map(volume, 0, 1.5, 80, 450);

  // Melodie
  drawVoice(melodyAngle, radius * 0.8, 
            color((frameCount*0.5) % 360, 80, 90, 60),
            20, 40);

  // Kontrapunkt (gegenläufig)
  drawVoice(counterpointAngle + PI, radius * 0.7,
            color((frameCount*0.5 + 180) % 360, 70, 80, 50),
            15, 35);

  popMatrix();
}

void drawVoice(float angleBase, float r, color col, float minSize, float maxSize) {
  for (int i = 0; i < 12; i++) {
    float a = angleBase + i * TWO_PI/12;
    float x = cos(a) * r + width/2;
    float y = sin(a) * r + height/2;

    float band = spectrum[int(map(i, 0, 11, 10, 200)) % bands] * 800;
    float size = map(band, 0, 1, minSize, maxSize);

    fill(col);
    pushMatrix();
    translate(x, y);
    rotate(a + HALF_PI);
    ellipse(0, 0, size*2, size);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("musik-kunst-####.png");
    println("Gespeichert!");
  }
}
