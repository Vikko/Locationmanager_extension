
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface locationController : NSObject <CLLocationManagerDelegate> 
{
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (id)init;
- (void)dealloc;

@end

