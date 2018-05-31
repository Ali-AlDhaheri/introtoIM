#include <Servo.h>
#include <Wire.h>
#include <Adafruit_MotorShield.h>

// Create the motor shield object with the default I2C address
Adafruit_MotorShield AFMS = Adafruit_MotorShield(); 
// Or, create it with a different I2C address (say for stacking)
// Adafruit_MotorShield AFMS = Adafruit_MotorShield(0x61); 

// Select which 'port' M1, M2, M3 or M4. In this case, M1
Adafruit_DCMotor *myMotor = AFMS.getMotor(2);
// You can also make another motor on port M2
//Adafruit_DCMotor *myOtherMotor = AFMS.getMotor(2);

int servoPin = 9;

Servo limboServo; 

void setup() {
  limboServo.attach(servoPin); 
  limboServo.write(0); 
  
  Serial.begin(9600);           // set up Serial library at 9600 bps
  Serial.println("Adafruit Motorshield v2 - DC Motor test!");

  AFMS.begin();  // create with the default frequency 1.6KHz
  //AFMS.begin(1000);  // OR with a different frequency, say 1KHz
  
  // Set the speed to start, from 0 (off) to 255 (max speed)
  myMotor->setSpeed(150);
  myMotor->run(FORWARD);
  // turn on motor
  myMotor->run(RELEASE);
}

void loop() {
  uint8_t i;
  
  Serial.print("tick");
//go forward
  myMotor->run(FORWARD);
  for (i=0; i<60; i++) {
    myMotor->setSpeed(i);  
    delay(20);
  }
  for (i=60; i!=0; i--) {
    myMotor->setSpeed(i);  
    delay(20);
  }

  
   // Make servo go to 90 degrees 
   // do limbo position
   limboServo.write(90); 
   delay(50);

  Serial.print("tech");
  myMotor->run(RELEASE);
  delay(1000);
// do the limbo
  myMotor->run(FORWARD);
  for (i=0; i<70; i++) {
    myMotor->setSpeed(i);  
    delay(20);
  }
  for (i=70; i!=0; i--) {
    myMotor->setSpeed(i);  
    delay(20);
  }
   //go back to straight position
  limboServo.write(0); 
  delay(50);
  //pause
  Serial.print("tech");
  myMotor->run(RELEASE);
  delay(1000);
  
//limbo position
  limboServo.write(90); 
  delay(50);
  
  Serial.print("tock");

//go back to do the limbo
  myMotor->run(BACKWARD);
  for (i=0; i<90; i++) {
    myMotor->setSpeed(i);  
    delay(20);
  }
  for (i=70; i!=0; i--) {
    myMotor->setSpeed(i);  
    delay(20);
  }

//go back to straight position
  limboServo.write(0); 
  delay(50);

  Serial.print("tech");
  myMotor->run(RELEASE);
  delay(1000);
  
  ////////////////////////////////////


   
}
