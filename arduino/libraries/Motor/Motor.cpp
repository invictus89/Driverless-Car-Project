// 
// 
// 

#include "Motor.h"


Motor::Motor(const int ena,
			const int in1,
			const int in2,
			const int in3,
			const int in4,
			const int enb) : m_ena(ena), m_in1(in1), m_in2(in2), m_in3(in3), m_in4(in4), m_enb(enb)
{
	pinMode(m_ena, OUTPUT);
	pinMode(m_in1, OUTPUT);
	pinMode(m_in2, OUTPUT);
	pinMode(m_in3, OUTPUT);
	pinMode(m_in4, OUTPUT);
	pinMode(m_enb, OUTPUT);
}

void Motor::forward(int speed = 100) {
	digitalWrite(m_in1, LOW);
	digitalWrite(m_in2, HIGH);
	analogWrite(m_ena, speed);
	digitalWrite(m_in3, LOW);
	digitalWrite(m_in4, HIGH);
	analogWrite(m_enb, speed);
}

void Motor::back(int speed = 100) {
	digitalWrite(m_in1, HIGH);
	digitalWrite(m_in2, LOW);
	analogWrite(m_ena, speed);
	digitalWrite(m_in3, HIGH);
	digitalWrite(m_in4, LOW);
	analogWrite(m_enb, speed);
}

void Motor::backLeft(int speed = 100) {
	digitalWrite(m_in1, 0);
	digitalWrite(m_in2, 0);
	analogWrite(m_ena, 0);
	digitalWrite(m_in3, HIGH);
	digitalWrite(m_in4, LOW);
	analogWrite(m_enb, speed);
}

void Motor::backRight(int speed = 100) {
	digitalWrite(m_in1, HIGH);
	digitalWrite(m_in2, LOW);
	analogWrite(m_ena, speed);
	digitalWrite(m_in3, 0);
	digitalWrite(m_in4, 0);
	analogWrite(m_enb, 0);
}

void Motor::turnLeft(int speed = 100) {
	digitalWrite(m_in1, HIGH);
	digitalWrite(m_in2, LOW);
	analogWrite(m_ena, speed);
	digitalWrite(m_in3, LOW);
	digitalWrite(m_in4, HIGH);
	analogWrite(m_enb, speed);
}

void Motor::turnRight(int speed = 100) {
	digitalWrite(m_in1, LOW);
	digitalWrite(m_in2, HIGH);
	analogWrite(m_ena, speed);
	digitalWrite(m_in3, HIGH);
	digitalWrite(m_in4, LOW);
	analogWrite(m_enb, speed);
}

void Motor::turnWeakLeft(int speed = 100) {
	digitalWrite(m_in1, 0);
	digitalWrite(m_in2, 0);
	analogWrite(m_ena, 0);
	digitalWrite(m_in3, LOW);
	digitalWrite(m_in4, HIGH);
	analogWrite(m_enb, speed);
}

void Motor::turnWeakRight(int speed = 100) {
	digitalWrite(m_in1, LOW);
	digitalWrite(m_in2, HIGH);
	analogWrite(m_ena, speed);
	digitalWrite(m_in3, 0);
	digitalWrite(m_in4, 0);
	analogWrite(m_enb, 0);
}

void Motor::stop() {
	digitalWrite(m_in1, LOW);
	digitalWrite(m_in2, LOW);
	analogWrite(m_ena, 0);
	digitalWrite(m_in3, LOW);
	digitalWrite(m_in4, LOW);
	analogWrite(m_enb, 0);
}

