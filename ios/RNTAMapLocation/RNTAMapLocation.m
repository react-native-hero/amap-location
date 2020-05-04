#import "RNTAMapLocation.h"
#import <React/RCTConvert.h>

@implementation RNTAMapLocation

+ (void)init:(NSString *)appKey {
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = appKey;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (instancetype)init {
    if (self = [super init]) {
        self.locationManager = [[AMapLocationManager alloc] init];
        [self.locationManager setDelegate:self];
    }
    return self;
}

- (void)dealloc {
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
}

- (NSDictionary *)constantsToExport {
    return @{
        @"LANGUAGE_AUTO": @(AMapLocationReGeocodeLanguageDefault),
        @"LANGUAGE_CHINESE": @(AMapLocationReGeocodeLanguageChinse),
        @"LANGUAGE_ENGLISH": @(AMapLocationReGeocodeLanguageEnglish),
        
        @"ACCURACY_BEST": @(kCLLocationAccuracyBest),
        @"ACCURACY_BEST_FOR_NAVIGATION": @(kCLLocationAccuracyBestForNavigation),
        @"ACCURACY_TEN_METER": @(kCLLocationAccuracyNearestTenMeters),
        @"ACCURACY_HUNDRED_METER": @(kCLLocationAccuracyHundredMeters),
        @"ACCURACY_KILOMETER": @(kCLLocationAccuracyKilometer),
        @"ACCURACY_THREE_KILOMETER": @(kCLLocationAccuracyThreeKilometers),
    };
}

RCT_EXPORT_MODULE(RNTAMapLocation);

RCT_EXPORT_METHOD(setOptions:(NSDictionary*)options) {
    
    if ([options objectForKey:@"language"]) {
        int language = [RCTConvert int:options[@"language"]];
        [self.locationManager setReGeocodeLanguage:language];
    }
    
    if ([options objectForKey:@"accuracy"]) {
        double accuracy = [RCTConvert double:options[@"accuracy"]];
        [self.locationManager setDesiredAccuracy:accuracy];
    }
    
    if ([options objectForKey:@"locationTimeout"]) {
        int locationTimeout = [RCTConvert int:options[@"locationTimeout"]];
        [self.locationManager setLocationTimeout:locationTimeout];
    }
    
    if ([options objectForKey:@"reGeocodeTimeout"]) {
        int reGeocodeTimeout = [RCTConvert int:options[@"reGeocodeTimeout"]];
        [self.locationManager setReGeocodeTimeout:reGeocodeTimeout];
    }
    
    // 暂不开放连续定位
//    // 是否允许系统暂停定位，默认为 false
//    if ([options objectForKey:@"enablePauseLocation"]) {
//        BOOL enablePauseLocation = [RCTConvert BOOL:options[@"enablePauseLocation"]];
//        [self.locationManager setPausesLocationUpdatesAutomatically:enablePauseLocation];
//    }
//
//    // 是否允许在后台定位，默认为 false
//    if ([options objectForKey:@"enableBackgroundLocation"]) {
//        BOOL enableBackgroundLocation = [RCTConvert BOOL:options[@"enableBackgroundLocation"]];
//        [self.locationManager setAllowsBackgroundLocationUpdates:enableBackgroundLocation];
//    }
//
//    // 是否允许连续逆地理定位，默认为 false
//    if ([options objectForKey:@"enableRegeocodeLocation"]) {
//        BOOL enableRegeocodeLocation = [RCTConvert BOOL:options[@"enableRegeocodeLocation"]];
//        [self.locationManager setLocatingWithReGeocode:enableRegeocodeLocation];
//    }
    
}

// 单次定位请求
RCT_EXPORT_METHOD(location:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [self.locationManager
        requestLocationWithReGeocode:NO
        completionBlock:^(CLLocation *location, AMapLocationReGeocode *reGeocode, NSError *error) {
        
            if (error != nil) {
                NSString *code = [NSString stringWithFormat: @"%ld", (long)error.code];
                reject(code, error.localizedDescription, error);
                return;
            }
            
            // 模拟 Web Geolocation 接口
            double timestamp = floor(location.timestamp.timeIntervalSince1970 * 1000);
        
            resolve(@{
                @"coords": @{
                    // 纬度
                    @"latitude":  @(location.coordinate.latitude),
                    // 经度
                    @"longitude":  @(location.coordinate.longitude),
                    // 位置精度
                    @"accuracy": @(location.horizontalAccuracy),
                    // 海拔
                    @"altitude": @(location.altitude),
                },
                @"timestamp": [NSString stringWithFormat:@"%.0f", timestamp],
            });
        
        }
    ];
}

// 单次带逆地理定位请求
RCT_EXPORT_METHOD(reGeocode:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [self.locationManager
        requestLocationWithReGeocode:YES
        completionBlock:^(CLLocation *location, AMapLocationReGeocode *reGeocode, NSError *error) {
        
            if (error != nil) {
                NSString *code = [NSString stringWithFormat: @"%ld", (long)error.code];
                reject(code, error.localizedDescription, error);
                return;
            }

            resolve(@{
                @"address": reGeocode.formattedAddress ?: @"",
                @"country": reGeocode.country ?: @"",
                @"province": reGeocode.province ?: @"",
                @"city": reGeocode.city ?: @"",
                @"district": reGeocode.district ?: @"",
                @"street": reGeocode.street ?: @"",
                @"number": reGeocode.number ? : @"",
            });
        
        }
    ];
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager {
    [locationManager requestAlwaysAuthorization];
}

@end
