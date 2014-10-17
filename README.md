RCLogin
=======

Painless login system without password for mobile

	RCLog(fmt, ... ); // A replacement for NSLog

	RCLogO(obj); // Logs an object directly, no need for the hard to write NSLog(@"%@", obj)
	RCLogS(str); // Logs a string
	RCLogI(integer); // Integer
	RCLogF(float); // Float
	RCLogRect(rect); // Ever wanted to log a CGRect. Boring, use this shortcut
	RCLogPoint(point); // CGPoint
	RCLogSize(size); // Size
	RCLogThread(); //  This logs the thread you are into
	
The possibilities are endless, please contribute if you have an idea. For the near future is planned to add a blank line between logs from different classes, this will make the reading even easier.


Usage
=====

Add the RCLog classes to your project then import it once in the .pch file

	#import "RCLog.h"
	

Sample output
=============

	RCLog(@"this is a string");
	
	MyClass.m:1: this is a string
