package tech.johnnydev.marvel_app

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle

class MainActivity: FlutterActivity(){
     private val deviceInfoPlugin = DeviceInfoPlugin() 
      override fun configureFlutterEngine() {
        super.configureFlutterEngine()

        
        deviceInfoPlugin.setupMethodChannel(this)
    }
}
