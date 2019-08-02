// Motor.h

#ifndef _MOTOR_h
#define _MOTOR_h

#if defined(ARDUINO) && ARDUINO >= 100
	#include "arduino.h"
#else
	#include "WProgram.h"
#endif

class Motor
{
 protected:
	 const int m_ena;
	 const int m_in1;
	 const int m_in2;

	 const int m_in3;
	 const int m_in4;
	 const int m_enb;
 public:
	 Motor(const int ena,
		 const int in1,
		 const int in2,
		 const int in3,
		 const int in4,
		 const int enb);
	 void forward(int speed = 100);
	 void back(int speed = 100);
	 void Motor::backLeft(int speed = 100);
	 void Motor::backRight(int speed = 100);
	 void turnLeft(int speed = 100);
	 void turnRight(int speed = 100);
	 void Motor::turnWeakLeft(int speed = 100);
	 void Motor::turnWeakRight(int speed = 100);
	 void stop();
};


#endif

