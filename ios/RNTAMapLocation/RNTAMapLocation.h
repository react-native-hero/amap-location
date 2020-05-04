#import <React/RCTBridgeModule.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface RNTAMapLocation : NSObject <RCTBridgeModule, AMapLocationManagerDelegate>

+ (void)init:(NSString *)appKey;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end
