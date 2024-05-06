
package com.example.flutter_application_1
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.net.Uri

class MainActivity: FlutterActivity() {
  private val CHANNEL = "splitty-app"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      
        if (call.method == "initializeTransaction") {
            val GOOGLE_PAY_PACKAGE_NAME = "com.google.android.apps.nbu.paisa.user"
            val GOOGLE_PAY_REQUEST_CODE = 123
            
            val uri = Uri.Builder()
                .scheme("upi")
                .authority("pay")
                .appendQueryParameter("pa", "7011107463@ibl")
                .appendQueryParameter("pn", "Gaurav Mehra")
                .appendQueryParameter("mc", "")
                .appendQueryParameter("tr", "your-transaction-ref-id")
                .appendQueryParameter("tn", "your-transaction-note")
                .appendQueryParameter("am", "234")
                .appendQueryParameter("cu", "INR")
                .appendQueryParameter("url", "your-transaction-url")
                .build()
            
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = uri
            activity.startActivityForResult(intent, GOOGLE_PAY_REQUEST_CODE)
           
            result.success(10)
        } else {
            result.notImplemented()
        }
    }
  }
}