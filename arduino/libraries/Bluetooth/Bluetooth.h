// Bluetooth.h

#ifndef _BLUETOOTH_h
#define _BLUETOOTH_h

#if defined(ARDUINO) && ARDUINO >= 100
	#include "arduino.h"
#else
	#include "WProgram.h"
#endif

#include <SoftwareSerial.h>

class Bluetooth : public SoftwareSerial
{
 public:
	 Bluetooth(int rx, int tx, long boardrate = 9600);
	 String readLine();
};

#endif

