int val = 0;

void setup(){
 size(800,800);
 background(250);
}

void draw(){
  stroke(random(0,250), random(0,250), random(0,250),20);
  strokeWeight(5);
  for(int i = 0; i < 6 + val; i++){
  pushMatrix();
  translate(width/2,height/2);
  rotate(i);
  line(mouseX,mouseY,75,75); 
  popMatrix();
  }
  if (mousePressed){ 
    background(random(0,250),random(0,250),random(0,250));
  }
  if (keyPressed){
    if (key == 's' || key == 'S'){
      val = 5;
    }
  }
  if (keyPressed){
    if (key == 'a' || key == 'A'){
      val += 1;
    }
  }
  if (keyPressed){
    if (key == 'f' || key == 'F'){
      val -= 5;
    }
  }
  if (keyPressed){
    if (key == 'd' || key == 'D'){
      val -= 1;
    }
  }
  if (keyPressed){
    if (key == 'r' || key == 'R'){
      clear();
      background(250);
    }
  }
}
