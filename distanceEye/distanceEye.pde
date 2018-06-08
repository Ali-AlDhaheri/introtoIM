import processing.serial.*;
Serial myPort;  
String data = "";
int click = 0;
int red = 250;
int green = 50;
int blue = 50;

void setup() {
  size(800, 800);
  background(250);
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  float f = float(data);  
  float cx = constrain(f, 1.0, 30.0);
  float x = map(cx, 1.0, 30.0, 0, width);
  float y = map(cx, 1.0, 30.0, 0, height);
  stroke(random(0, red), random(0, green), random(0, blue), 20);
  strokeWeight(5);
  for (int i = 0; i < 500 + 0 / TWO_PI; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(i);
    line(x, y, 75, 75); 
    popMatrix();
  }
  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      background(random(0, 50), random(0, 250), random(0, 250));
      red = 250;
      green = 50;
      blue = 50;
    }
  }
  if (keyPressed) {
    if (key == 'g' || key == 'G') {
      background(random(0, 250), random(0, 50), random(0, 250));
      red = 50;
      green = 250;
      blue = 50;
    }
  }
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
      background(random(0, 250), random(0, 250), random(0, 50));
      red = 50;
      green = 50;
      blue = 250;
    }
  }
}

//distance function
void serialEvent(Serial myPort) {
  data=myPort.readStringUntil('\n');
  if (data != null) {
    println(data);
  }
}
