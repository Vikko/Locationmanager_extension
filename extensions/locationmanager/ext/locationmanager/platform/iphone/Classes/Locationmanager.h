
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface locationController : NSObject <CLLocationManagerDelegate> 
{
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (void)start;
- (void)dealloc;

@end

