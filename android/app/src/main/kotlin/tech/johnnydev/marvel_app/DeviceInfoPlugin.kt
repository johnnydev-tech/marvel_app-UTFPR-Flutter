package tech.johnnydev.marvel_app

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class DeviceInfoPlugin {

    companion object {
        const val CHANNEL = "tech.johnnydev.marvelapp.deviceinfo"
    }

  
    fun setupMethodChannel(activity: FlutterActivity) {
        MethodChannel(activity.flutterEngine?.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDeviceInfo") {
                val deviceInfo = getDeviceInfo()
                result.success(deviceInfo)
            } else {
                result.notImplemented()
            }
        }
    }


    private fun getDeviceInfo(): String {
        return "Modelo: ${Build.MODEL}, Versão: ${Build.VERSION.RELEASE}"
    }
}