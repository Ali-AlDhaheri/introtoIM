PImage bg;
String[] myPoem1; //an array of strings that will store our loaded file
float rot; 
float val;
void setup() {
  size(800, 800);
  textSize(20);
  myPoem1 = loadStrings("poem1.txt"); //we load the strings (located in our data/ folder)  
  bg = loadImage("clock.png");
  rot = 0;
  val = 0;
}
void draw() {
  background(bg);
  fill(0);
  for (int i = 0; i < myPoem1.length; i++) {//for loop for each line
    pushMatrix();
    fill(0);
    translate(width/2, height/2-100+i*20);//we translate on the Y axis to a new line
    rotate(radians(rot));
    text(myPoem1[i], 0, 0);
    popMatrix();//we don't forget to finish our matrix transformations
    if (rot == val) {
      val += 360;
      myPoem1 = shorten(myPoem1);
    }
    println(rot);
  }
}
void keyPressed() {
  if (keyCode == LEFT) { //arrows are coded so you can't call "key"
    rot--; //left arrow rotates one way
  } else if (keyCode == RIGHT) { 
    rot++; //right arrow rotates the other way
  }else if (key == 'r' || key == 'R'){
  setup();
  }
}
