//Enemy

class Enemy {
  float x, y;
  float velocity;
  PImage img;
  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
    this.velocity = 5;
    this.img = gsImage1;
  }

  void display() {
    ellipse(this.x, this.y, 60, 51);
    image(img, this.x, this.y);
  }

  void move() {
    this.x+=this.velocity;
    if (this.x > width*.9) {
      this.x = width*.9;
      this.velocity *= -1;
      this.y+=30;
    }

    if (this.x < width*.1) {
      this.velocity*=-1;
      this.x = width*.1;
      this.y+=30;
    }
  }  

  void shoot() {
    Bullet b = new Bullet(this.x, this.y, 5);
    bullets.add(b);
  }

  void hitCheck() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet b = (Bullet) bullets.get(i);      
      float distBetween = dist(b.x, b.y, this.x, this.y);
      if (distBetween < 15 && b.velocity < 0) {
        enemies.remove(this);
        bullets.remove(b);
      }
    }
  }
}
