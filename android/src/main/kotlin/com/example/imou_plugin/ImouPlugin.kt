package com.example.imou_plugin

import android.app.Activity
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
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
  private lateinit var channel : MethodChannel
//  private lateinit var frameLayout: FrameLayout;
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
  val messenger = flutterPluginBinding.binaryMessenger
  channel = MethodChannel(messenger, "navigation_plugin")

  progressEventChannel = EventChannel(messenger, "navigation_plugin/events")
  progressEventChannel.setStreamHandler(this)

  platformViewRegistry = flutterPluginBinding.platformViewRegistry
  binaryMessenger = messenger
  }


  companion object {

    var eventSink: EventChannel.EventSink? = null

    var platformViewRegistry: PlatformViewRegistry? = null
    var binaryMessenger: BinaryMessenger? = null

    var viewId = "ImouCameraView"
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    currentActivity = null
    channel.setMethodCallHandler(null)
    progressEventChannel.setStreamHandler(null)
    try {
//            System.loadLibrary("c++_shared")
      System.loadLibrary("netsdk")
      System.loadLibrary("configsdk")
      System.loadLibrary("jninetsdk")
      System.loadLibrary("gnustl_shared")
      System.loadLibrary("LechangeSDK")
      System.loadLibrary("SmartConfig")
      System.loadLibrary("SoftAPConfig")
      System.loadLibrary("GMCrypto")
      System.loadLibrary("LCOpenApiClient")
    } catch (var1: Exception) {
      System.err.println("loadLibrary Exception$var1")
    } catch (var2: Error) {
      System.err.println("loadLibrary Exception$var2")
    }
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

      print("============================xxx================")
      platformViewRegistry?.registerViewFactory(
        viewId,
        CameraViewFactory(binaryMessenger!!, currentActivity!!,binding)
      )
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {}

}
