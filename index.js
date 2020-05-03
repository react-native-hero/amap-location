
import { NativeModules, NativeEventEmitter } from 'react-native'

const { RNTAMapLocation } = NativeModules

const eventEmitter = new NativeEventEmitter(RNTAMapLocation)

export function location(options) {
  
}
