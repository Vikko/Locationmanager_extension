/* accelerometer.i */
%module Accelerometer
%{
#include "ruby/ext/rho/rhoruby.h"

extern void accelerometer_get_readings(double *x, double *y, double *z);
extern void accelerometer_start(void);

#define get_readings accelerometer_get_readings
#define start accelerometer_start

%}

extern void get_readings(double *OUTPUT, double *OUTPUT, double *OUTPUT);
extern void start(void);
