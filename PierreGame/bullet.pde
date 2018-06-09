//Bullets that both the player and enemy will use

class Bullet {
  float x, y;
  float velocity;

  Bullet(float x, float y, float velocity) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
  }

  void display() {
    fill(250);
    rect(this.x, this.y, 5, 20);
  }

  void move() {
    this.y+=this.velocity;
    if (this.y > height || this.y < 0) {
      bullets.remove(this);
    }
  }
}
