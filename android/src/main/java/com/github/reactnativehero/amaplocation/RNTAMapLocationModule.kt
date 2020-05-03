package com.github.reactnativehero.amaplocation

import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule

class RNTAMapLocationModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "RNTAMapLocation"
    }

}