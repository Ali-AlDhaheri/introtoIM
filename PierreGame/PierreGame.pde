import processing.sound.*;
SoundFile file;
SoundFile file1;
SoundFile file2;

//Main
ArrayList bullets;
ArrayList enemies;

int numCol = 10;
Player player1;
Enemy testEnemy;
boolean keyAPressed = false, keyDPressed = false;
PImage pierreImage1;
PImage gsImage1;
void setup() {
  size(800, 800);
  file = new SoundFile(this, "gameSong.mp3");
  file1 = new SoundFile(this, "win.mp3");
  file2 = new SoundFile(this, "lose.mp3");
  file.loop();
  imageMode(CENTER);
  pierreImage1 = loadImage("data/pierre.jpg");
  gsImage1 = loadImage("data/gs.jpg");
  startGame();
}

void startGame() {
  player1 = new Player();
  bullets = new ArrayList();
  enemies = new ArrayList();
  generateEnemies();
}

void draw() {
  background(0);
  lose();
  showLives();
  player1.display();
  movePlayer1();
  player1.hitCheck();
  handleEnemies();
  handleBullets();
  win();
}
void lose() {
  if (player1.lives <= 0) {
    file.stop();
    file2.play();
    background(0);
    fill(250);
    textSize(28);
    text("YOU HAVE FAILED!!! Press R to try again", 0+30, 100);
    noLoop();
  }
}
void win() {
  if (enemies.size() == 0) {   
    file.stop();
    file1.play();
    background(0);
    fill(250);
    textSize(28);
    text("YOU HAVE DEFEATED GOLDBERG SAM!!! \n\n\n\n\n              Press R to play again", 0 + 120, height/2);
    noLoop();
  }
}
void showLives() {
  for (int i = 0; i <= player1.lives; i++) {
    rect(width-40*i, 10, 30, 30);
  }
}

void generateEnemies() {
  for (int i = 0; i < 1; i++) {
    float x = width*.1 + i%numCol*50;
    float y = 60 + int(i/numCol)*60 ;
    enemies.add(new Enemy(x, y));
  }
}

void handleEnemies() {
  for (int i = 0; i < enemies.size(); i++) {
    Enemy enemy = (Enemy) enemies.get(i);
    enemy.move();
    enemy.display();
    enemy.hitCheck();
    if (random(1) > .995) {
      enemy.shoot();
    }
  }
}


void handleBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Bullet b = (Bullet) bullets.get(i);
    b.move();
    b.display();
  }
}

void movePlayer1() {
  if (keyAPressed) {
    player1.x -=10;
  }
  if (keyDPressed) {
    player1.x +=10;
  }
}

void keyPressed() {
  if ((key == 'r' || key == 'R') && (enemies.size() == 0)) {
    file1.stop();
    setup();
    loop();
  }
  if ((key == 'r' || key == 'R') && (player1.lives <= 0)) {
    file.stop();
    setup();
    loop();
  }
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    keyAPressed = true;
  } else {
    if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      keyDPressed = true;
    } else {
      if (key == ' ') {
        player1.shoot();
      }
    }
  }
}

void keyReleased() {
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    keyAPressed = false;
  } else {
    if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      keyDPressed = false;
    }
  }
}  

//Geometry 

boolean rectIntersect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {

  float[] r1 = new float[8];
  float[] r2 = new float[8];

  r1[0] = x1;
  r1[1] = y1;
  r1[2] = x1+w1;
  r1[3] = y1+h1;
  r1[4] = r1[0];
  r1[5] = r1[3];
  r1[6] = r1[2];
  r1[7] = r1[1];

  r2[0] = x2;
  r2[1] = y2;
  r2[2] = x2+w2;
  r2[3] = y2+h2;
  r2[4] = r2[0];
  r2[5] = r2[3];
  r2[6] = r2[2];
  r2[7] = r2[1];

  boolean intersect = false;

  for (int i = 0; i < 8; i=i+2) {
    if (pointInRectangle(r2[0], r2[2], r2[1], r2[3], r1[i], r1[i+1])) {
      intersect = true;
    }
  }

  for (int i = 0; i < 8; i=i+2) {
    if (pointInRectangle(r1[0], r1[2], r1[1], r1[3], r2[i], r2[i+1])) {
      intersect = true;
    }
  }
  return intersect;
}

boolean isBetween(float v1, float v2, float test) {
  if (test < v1 && test > v2) {
    return true;
  } else {
    if (test > v1 && test < v2) {
      return true;
    } else {
      return false;
    }
  }
}

boolean pointInRectangle(float x1, float x2, float y1, float y2, float xT, float yT) {
  if (((xT < x1 && xT > x2) || (xT > x1 && xT < x2)) && 
    ((yT < y1 && yT > y2) || (yT > y1 && yT < y2))) {
    return true;
  } else {
    return false;
  }
}
