 /*
 Name:      Project.ino
 Created:   2019-02-19 오후 2:43:50
 Author:   student
*/
#include <Bluetooth.h>
#include <Motor.h>
#include <Wire.h>

Motor motor(10,9,8,7,6,5);
Bluetooth bt(2, 3, 9600);

int pTurn = -1;

void motorControl(int command) {
    //Forward
    if(command == 1) {
      motor.forward(90);
    }
    //Back
    else if(command == 2){
      motor.back(80);
    }
    //Auto_Left
    else if(command == 3){
      //motor.turnWeakLeft(170);
      motor.turnLeft(160);
      pTurn = 1;
    }
    //Auto_Right
    else if(command == 4){
      //motor.turnWeakRight(170);
      motor.turnRight(160);
      pTurn = 2;
    }
    //Stop
    else if(command == 5){
      motor.stop();
    }
    //OverLane Check
    else if(command == 6){
      //Prev_Left
      if(pTurn == 1){
        motor.turnLeft(160);
      } 
      //Prev_Right
      else if(pTurn == 2){
        motor.turnRight(160);
      }
    }
    //No_Auto_Left
    else if(command == 7){
      motor.turnLeft(160);
    }
    //No_Auto_Right
    else if(command == 8){
      motor.turnRight(160);
    }
}

void remoteControl() {
   String message = bt.readLine();
   
   if (message != "") {
      int command = message.toInt();
      motorControl(command);
   }
}

void setup() {
   Serial.begin(9600);
   Wire.begin();
}

void loop() {
   remoteControl();
}
