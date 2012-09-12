
#import "Locationmanager.h"

#include "ruby/ext/rho/rhoruby.h"

//store the values
double gx, gy, gz, gth;

//init location
locationController *lc;
@implementation locationController

@synthesize locationManager;

- (id)init {
	if (self = [super init]) {
		self.locationManager = [[CLLocationManager alloc] init];
	
		NSLog(@"%@", [CLLocationManager headingAvailable]? @"\n\nHeading available!\n" : @"\n\nNo heading..\n");
		NSLog(@"%@", [CLLocationManager locationServicesEnabled]? @"\n\nLocation available!\n" : @"\n\nNo location..\n");
	
		// check if the hardware has a compass
	  	if ([CLLocationManager headingAvailable] == NO) {
		    // No compass is available. This application cannot function without a compass, 
		    // so a dialog will be displayed and no magnetic data will be measured.
		    locationManager = nil;
		    UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!" message:@"This device does not have the ability to measure magnetic fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		    [noCompassAlert show];
		    [noCompassAlert release];
			NSLog(@"\n***** ERROR *****\n No compass found !!!");
		} else {
		    // setup delegate callbacks
		    locationManager.delegate = self;

		    // heading service configuration
		    locationManager.headingFilter = kCLHeadingFilterNone;
      
			// location service configuration
			locationManager.distanceFilter = kCLDistanceFilterNone;
		 	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;

			//start location services
		 	[locationManager startUpdatingLocation];
	
	    	// start the compass
	    	[locationManager startUpdatingHeading];

	    }
	return self;
	}
}

- (void)dealloc {    
	[super dealloc];
    // Stop the compass
    [locationManager stopUpdatingHeading];
    [locationManager release];
}
 
// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
	NSLog(@"\n\n***** New magnetic heading *****\n %f\n", heading.magneticHeading);
	NSLog(@"\n\n***** New true heading *****\n %f\n", heading.trueHeading);
	gx = heading.x;
	gy = heading.y;
	gz = heading.z;
	gth = heading.trueHeading;
}
 
// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
		NSLog(@"\n ***** ERROR *****\n Location not allowed!");
        [locationManager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
		NSLog(@"\n ***** ERROR *****\n Magnetic interference or something!");
    }
}

@end

void locationmanager_init(void) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
   	// make sure we can only start this method once
   	static bool started = false;
   	if(!started) {
       	// Initialize the Objective C accelerometer class.
       	lc = [[locationController alloc] init];
      	started = true;
   	}
	[pool release];
}

void locationmanager_get_heading(double *x, double *y, double *z, double *th) {
	NSLog(@"\n ***** DEBUGGER *****\n Getting heading  x: %f, y: %f, z: %f, heading: %f", gx, gy, gz, gth);
	*x = gx;
	*y = gy;
	*z = gz;
	*th = gth;
}