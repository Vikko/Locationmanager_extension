#import "Accelerometer.h"

// store the acceleration values
double gx,gy,gz;

// Reference this Objective C class.
Accel *accel;
@implementation Accel

-(void)start
{
    // Initialize the accelerometer variables.
    gx = gy = gz = 0;
    // Set the update interval.
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.025];
    // Set the delegate to this class, so the iPhone accelerometer will 
    // call you back on the delegate method.
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
// Get the accelerometer values from the iPhone.
{
    gx = acceleration.x;
    gy = acceleration.y;
    gz = acceleration.z;
}

@end

// This C function interfaces with the Objective C start function.
void accelerometer_start(void) {
    // make sure we can only start this method once
    static bool started = false;
    if(!started) {
        // Initialize the Objective C accelerometer class.
        accel = [[Accel alloc] init];
        // Start the accelerometer readings.
        [accel start];
        started = true;
    }
}

// This C function allows us to get the readings from the accelerometer so
// they can be returned to the Ruby code.
void accelerometer_get_readings(double *x, double *y, double *z) {
    *x = gx;
    *y = gy;
    *z = gz;
}
