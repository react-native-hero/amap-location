# @react-native-hero/amap-location

封装高德地图 - 定位 SDK

## Getting started

Install the library using either Yarn:

```
yarn add @react-native-hero/amap-location
```

or npm:

```
npm install --save @react-native-hero/amap-location
```

## Link

- React Native v0.60+

For iOS, use `cocoapods` to link the package.

run the following command:

```
$ cd ios && pod install
```

For android, the package will be linked automatically on build.

- React Native <= 0.59

run the following command to link the package:

```
$ react-native link @react-native-hero/amap-location
```

## Setup

### iOS

`AppDelegate.m`

```objective-c
#import <RNTAMapLocation.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [RNTAMapLocation init:@"appKey"];
    return YES;
}
```

`Info.plist`

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>AMapLocation需要定位权限才可以正常使用，如果您需要使用后台定位功能请选择“始终允许”。</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>AMapLocation需要定位权限才可以使用</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>AMapLocation需要定位权限才可以正常使用</string>
```

### Android

`android/app/build.gradle`

```
buildTypes {
    debug {
        ...

        manifestPlaceholders = [
            AMAP_APP_KEY: 'appKey',
        ]
    }
    release {
        ...

        manifestPlaceholders = [
            AMAP_APP_KEY: 'appKey',
        ]
    }
}
```

Then, make sure you have these permissions before call methods.

* ACCESS_COARSE_LOCATION
* ACCESS_FINE_LOCATION
* WRITE_EXTERNAL_STORAGE
* READ_PHONE_STATE

## Example

获取经纬度信息

```js
import {
  location,
} from '@react-native-hero/amap-location'

location()
.then(data => {
  data.coords
  data.timestamp
})
.catch(err => {
  // err.code 参考官方文档
  // ios https://lbs.amap.com/api/ios-location-sdk/guide/utilities/errorcode
  // android https://lbs.amap.com/api/android-location-sdk/guide/utilities/errorcode
})
```

逆地理定位（获取省市县信息）

```js
import {
  reGeocode,
} from '@react-native-hero/amap-location'

reGeocode()
.then(data => {
  data.address
  data.country
  data.province
  data.city
  data.district
  data.street
  data.number
})
.catch(err => {
  // err.code 参考官方文档
  // ios https://lbs.amap.com/api/ios-location-sdk/guide/utilities/errorcode
  // android https://lbs.amap.com/api/android-location-sdk/guide/utilities/errorcode
})
```

修改 ios 配置

```js
import {
  LANGUAGE,
  ACCURACY,
  setOptions,
} from '@react-native-hero/amap-location'

// 下面这些是默认值，按需修改即可
// 具体作用参考官方文档 https://lbs.amap.com/api/ios-location-sdk/guide/get-location/singlelocation/
setOptions({
  language: LANGUAGE.AUTO,
  accuracy: ACCURACY.BEST,
  // 超时时间单位为秒
  locationTimeout: 10,
  reGeocodeTimeout: 5,
})
```

修改 android 配置

```js
import {
  PURPOSE,
  MODE,
  setOptions,
} from '@react-native-hero/amap-location'

// 下面这些是默认值，按需修改即可
// 具体作用参考官方文档 https://lbs.amap.com/api/android-location-sdk/guide/android-location/getlocation/
setOptions({
  purpose: PURPOSE.NONE,
  mode: MODE.HIGH_ACCURACY,
  enableWifiScan: false,
  enableMock: true,
  enableCache: true,
  // 超时时间单位为秒
  timeout: 30,
})
```