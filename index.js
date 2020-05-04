
import { NativeModules } from 'react-native'

const { RNTAMapLocation } = NativeModules

export const LANGUAGE = Platform.select({
  ios: {
    AUTO: RNTAMapLocation.LANGUAGE_AUTO,
    CHINESE: RNTAMapLocation.LANGUAGE_CHINESE,
    ENGLISH: RNTAMapLocation.LANGUAGE_ENGLISH,
  },
  android: {

  }
})

export const ACCURACY = Platform.select({
  ios: {
    BEST: RNTAMapLocation.ACCURACY_BEST,
    BEST_FOR_NAVIGATION: RNTAMapLocation.ACCURACY_BEST_FOR_NAVIGATION,
    TEN_METER: RNTAMapLocation.ACCURACY_TEN_METER,
    HUNDRED_METER: RNTAMapLocation.ACCURACY_HUNDRED_METER,
    KILOMETER: RNTAMapLocation.ACCURACY_KILOMETER,
    THREE_KILOMETER: RNTAMapLocation.ACCURACY_THREE_KILOMETER,
  },
  android: {

  }
})

export const PURPOSE = Platform.select({
  ios: {

  },
  android: {
    NONE: RNTAMapLocation.PURPOSE_NONE,
    SIGN_IN: RNTAMapLocation.PURPOSE_SIGN_IN,
    TRANSPORT: RNTAMapLocation.PURPOSE_TRANSPORT,
    SPORT: RNTAMapLocation.PURPOSE_SPORT,
  }
})

export const MODE = Platform.select({
  ios: {

  },
  android: {
    HIGH_ACCURACY: RNTAMapLocation.MODE_HIGH_ACCURACY,
    BATTERY_SAVING: RNTAMapLocation.MODE_BATTERY_SAVING,
    DEVICE_SENSORS: RNTAMapLocation.MODE_DEVICE_SENSORS,
  }
})

export function setOptions(options) {
  RNTAMapLocation.setOptions(options)
}

export function location() {
  return RNTAMapLocation.location()
  .then(data => {
    // 底层为了避免损失精度，返回了时间戳字符串
    // 这里转换为 number，方便外部直接 new Date(data.mtime)
    data.timestamp = +data.timestamp
    return data
  })
}

export function reGeocode() {
  return RNTAMapLocation.reGeocode()
}
