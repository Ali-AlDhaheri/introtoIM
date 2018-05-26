const int ledPin = 9;   //pin 3 has PWM function
const int flexPin = A5; //pin A0 to read analog input
//Variables:
int value; //save analog value
///////////////////////////////////////////////////////////////
#include "pitches.h"

int melody[] = {
  NOTE_C4, NOTE_C4, NOTE_C4, NOTE_C4, NOTE_C4, NOTE_C4, NOTE_C4,
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  12, 12, 12, 12, 12, 12, 12,
};
//////////////////////////////////////////////////////////
void setup(){
  
  pinMode(ledPin, OUTPUT);  //Set pin 3 as 'output'
  Serial.begin(9600);       //Begin serial communication
  digitalWrite(ledPin, LOW);
}

void loop(){
  value = analogRead(flexPin);         //Read and save analog value from potentiometer
  Serial.println(value);               //Print value
  delay(100);                          //Small delay

  if(analogRead(flexPin) >= 970){
    for (int thisNote = 0; thisNote < 8; thisNote++) {

    // to calculate the note duration, take one second divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1000 / noteDurations[thisNote];
    tone(8, melody[thisNote], noteDuration);
    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    digitalWrite(ledPin, HIGH);
    delay(200);
    digitalWrite(ledPin, LOW);
    noTone(8);

  }
  }
}


