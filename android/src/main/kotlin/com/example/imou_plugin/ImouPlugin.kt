package com.example.imou_plugin

import android.app.Activity
import android.content.Context
import android.widget.FrameLayout
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformViewRegistry

/** ImouPlugin */
class ImouPlugin: FlutterPlugin, ActivityAware, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  private lateinit var progressEventChannel: EventChannel
  private var currentActivity: Activity? = null
  private lateinit var currentContext: Context
//  private lateinit var channel : MethodChannel
//  private lateinit var frameLayout: FrameLayout;
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "imou_plugin")
//    channel.setMethodCallHandler(this)
//    frameLayout = FrameLayout(flutterPluginBinding.applicationContext)
  }


  companion object {

    var eventSink: EventChannel.EventSink? = null

    var platformViewRegistry: PlatformViewRegistry? = null
    var binaryMessenger: BinaryMessenger? = null

    var viewId = "imou_plugin"
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    currentActivity = null
    progressEventChannel.setStreamHandler(null)
  }

  override fun onListen(args: Any?, events: EventChannel.EventSink?) {
    eventSink = events
  }

  override fun onCancel(args: Any?) {
    eventSink = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    currentActivity = binding.activity
  }

  override fun onDetachedFromActivity() {
    currentActivity!!.finish()
    currentActivity = null
  }
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    currentActivity = binding.activity

    currentContext = binding.activity.applicationContext
    if (platformViewRegistry != null && binaryMessenger != null && currentActivity != null) {
      platformViewRegistry?.registerViewFactory(
        viewId,
        CameraViewFactory(binaryMessenger!!, currentActivity!!,binding)
      )
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {}

}
