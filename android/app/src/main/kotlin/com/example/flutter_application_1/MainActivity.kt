
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
            val app: String? = call.argument("app")
            // TODO: Use App
            val pa: String? = call.argument("pa")
            val pn: String? = call.argument("pn")
            val mc: String? = call.argument("mc")
            val tr: String? = call.argument("tr")
            val tn: String? = call.argument("tn")
            val am: String? = call.argument("am")
            val cu: String? = call.argument("cu")
            val url: String? = call.argument("url")

            val GOOGLE_PAY_PACKAGE_NAME = "com.google.android.apps.nbu.paisa.user"
            val GOOGLE_PAY_REQUEST_CODE = 123
            
            val uri = Uri.Builder()
                .scheme("upi")
                .authority("pay")
                .appendQueryParameter("pa", pa)
                .appendQueryParameter("pn", pn)
                .appendQueryParameter("mc", mc)
                .appendQueryParameter("tr", tr)
                .appendQueryParameter("tn", tn)
                .appendQueryParameter("am", am)
                .appendQueryParameter("cu", cu)
                .appendQueryParameter("url", url)
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