// constants won't change. They're used here to 
// set pin numbers:
const int blueButtonPin = 2;     // the number of the pushbutton pin
const int yellowButtonPin = 4;
const int greenButtonPin = 7;
int Buzzer1 = 9;

// variables will change:
int blueButtonState = 0;         // variable for reading the pushbutton status
int yellowButtonState = 0;
int greenButtonState = 0;

void setup() {
  // initialize the piezo as output:
  pinMode(Buzzer1, OUTPUT);  
  // initialize the pushbutton pin as an input:
  pinMode(blueButtonPin, INPUT);     
  pinMode(yellowButtonPin, INPUT);     
  pinMode(greenButtonPin, INPUT);     
  tone(Buzzer1,400,200);
  delay(500);
  noTone(Buzzer1);
}

void loop(){
  // read the state of the pushbutton value:
  blueButtonState = digitalRead(blueButtonPin);
  yellowButtonState = digitalRead(yellowButtonPin);
  greenButtonState = digitalRead(greenButtonPin);

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (blueButtonState == HIGH) {     
    // play the Music
      tone(Buzzer1,400,200);
      delay(500);
      noTone(Buzzer1);

  }
  if (yellowButtonState == HIGH) {     
    // play the Music
      tone(Buzzer1,800,200);
      delay(500);
      noTone(Buzzer1);

  }
  if (greenButtonState == HIGH) {     
    // play the Music
      tone(Buzzer1,1200,200);
      delay(500);
      noTone(Buzzer1);

  }
}
