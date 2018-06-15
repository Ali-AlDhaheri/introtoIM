import com.hamoid.*;
import processing.video.*;

Capture video;
VideoExport videoExport;
int locX, locY;
PImage backgroundImg, subImage, beach;
float threshold=20;
boolean rec = false;
boolean play = false;
boolean yay = false;
Movie myMovie;

//Nik's
color trackedCol = color(255, 0, 0);
color trackedCol1 = color(0, 0, 255); 
int colX;
int colY; 
int col1X;
int col1Y; 
ArrayList<PVector> vertices;
ArrayList<PVector> vertices2; 

void setup() {
  //size(640, 480);
  fullScreen();
  frameRate(30);
  video = new Capture(this, width, height, 30);
  video.start();
  subImage=createImage(width, height, RGB);
  myMovie = new Movie(this, "draft.mp4");

  videoExport = new VideoExport(this, "./data/draft.mp4");
  videoExport.setFrameRate(frameRate);
  videoExport.startMovie();
  //Nik's
  vertices = new ArrayList<PVector>(); 
  vertices2 = new ArrayList<PVector>();
}

void draw() {
  if (video.available()) {
    video.read();
  }
  //video.read();
  //image(video, 0, 0);

  record();
  playing();

  video.loadPixels();
  subImage.loadPixels();
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int loc = (video.width-x-1)+(y*width);
      color pix=video.pixels[loc];

      float r1=red(pix);
      float g1=green(pix);
      float b1=blue(pix);

      if (r1<100 && b1 < 100 && g1 > 50) {
        subImage.pixels[loc]=color(255, 255, 255);
      } else {
        subImage.pixels[loc]=color(0, 0, 0);
      }
    }
  }
  video.updatePixels();
  subImage.updatePixels();
  pushMatrix();
  image(subImage, 0, 0);
  popMatrix();

  //Nik's
  fill(0, 0);

  for (int y=0; y<height; y++) {
    for (int x=0; x < width; x++) {
      int loc = (video.width-x-1)+(y*width);
      color c = video.pixels[loc];
      if (dist(red(trackedCol), green(trackedCol), blue(trackedCol), red(c), green(c), blue(c)) < 125) {
        colX = x;
        colY = y;
        //println("Hi, im printing red");
      }
    }
  }
  fill(0, 0);
  for (int y=0; y<height; y++) {
    for (int x=0; x < width; x++) {
      int loc = (video.width-x-1)+(y*width);
      color c = video.pixels[loc];
      if (dist(red(trackedCol1), green(trackedCol1), blue(trackedCol1), red(c), green(c), blue(c)) < 125) {
        col1X = x;
        col1Y = y;
        //println("Hi, im printing blue");
      }
    }
  }

  if (frameCount % 1 == 0 && colX !=0 && colY !=0) {
    vertices.add(new PVector(colX, colY));
  }
  beginShape(); 
  for (int i = 0; i < vertices.size(); i++) {
    vertex(vertices.get(i).x, vertices.get(i).y);
    stroke(random(190, 255), random(0, 50), random(220, 250));
    strokeWeight(5);
    if (vertices.size() > 15) {
      vertices.remove(i);
    }
  }
  endShape();


  if (frameCount % 1 == 0 && col1X !=0 && col1Y !=0) {
    vertices2.add(new PVector(col1X, col1Y));
  }
  beginShape(); 
  for (int i = 0; i < vertices2.size(); i++) {
    vertex(vertices2.get(i).x, vertices2.get(i).y);
    stroke(0, 0, random(190, 255));
    strokeWeight(5);
    if (vertices2.size() > 15) {
      vertices2.remove(i);
    }
  }
  endShape();
}
void record() {
  if (rec) {
    //video.read();
    //image(video, 0, 0);
    videoExport.saveFrame();
    videoExport.setMovieFileName("./data/draft.mp4");
  }
}
void keyPressed() {
  if (key == 'r' || key == 'R') {
    rec = !rec;
    println("Recording is " + (rec ? "ON" : "OFF"));
  }
  //if (key == 'r' || key == 'R') {
  //  rec = true;
  //  println("recording");
  //}
  //if (key == 'x' || key == 'X') {
  //  rec = false;
  //  println("stopped recording");
  //}
  //if (key == 's' || key == 'S') {
  //  videoExport.endMovie();
  //}
}
void playing() {
  if (!rec) {
    myMovie.read();
    myMovie.loop();
    tint(255, 127);
    image(myMovie, 0, 0);
  }
}
