package com.example.imou_plugin

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.RequiresApi
import com.lechange.opensdk.api.InitParams
import com.lechange.opensdk.api.LCOpenSDK_Api
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

import com.lechange.opensdk.media.LCOpenSDK_ParamReal
import com.lechange.opensdk.media.LCOpenSDK_PlayWindow
import java.text.MessageFormat
import java.time.Instant
import java.util.UUID

class FlutterCameraViewFactory(
    ctx: Context,
    messenger: BinaryMessenger,
    viewId: Int,
    act: Activity,
    args: Any?,
    binding: ActivityPluginBinding
) : PlatformView, MethodChannel.MethodCallHandler,
    Application.ActivityLifecycleCallbacks, EventChannel.StreamHandler {

    private val activity: Activity = act
    private val context: Context = ctx
    private val methodChannel: MethodChannel
    private val eventChannel: EventChannel
    private var frameLayout: FrameLayout
    private var accessToken: String = ""
    private var deviceId: String = ""
    private var channelId: String = ""
    private var psk: Int = 0
    private var playToken = ""

    // accessToken, deviceId, channelId, psk, playToken, bateMode, isOpt, isOpenAudio, imageSize
    init {
        activity.application.registerActivityLifecycleCallbacks(this)
        methodChannel = MethodChannel(messenger, "imou_plugin/${viewId}")
        eventChannel = EventChannel(messenger, "imou_plugin/${viewId}/events")
        eventChannel.setStreamHandler(this)
        methodChannel.setMethodCallHandler(this)
        frameLayout = FrameLayout(context)
    }

    override fun getView(): View {
        return frameLayout
    }

    private fun stop() {
        val playWindow: LCOpenSDK_PlayWindow = LCOpenSDK_PlayWindow();
        playWindow.initPlayWindow(context, frameLayout, 0, false);
        playWindow.stopRtspReal(true);
        playWindow.uninitPlayWindow();
    }

    private fun initSDK(call: MethodCall, result: MethodChannel.Result) {
        val accessToken: String = call.argument("accessToken")!!

        LCOpenSDK_Api.initOpenApi(InitParams(context,"openapi-sg.easy4ip.com:443",accessToken))
        val deviceId: String = call.argument("deviceId")!!
        val channelId: Int = call.argument("channelId")!!
        val psk: String = call.argument("psk")!!
        val playToken: String = call.argument("playToken")!!
//        val bateMode: Int = call.argument("bateMode")!!
//        val isOpt: Boolean = call.argument("isOpt")!!
//        val isOpenAudio: Boolean = call.argument("isOpenAudio")!!
//        val imageSize: Int = call.argument("imageSize")!!

        val playWindow: LCOpenSDK_PlayWindow = LCOpenSDK_PlayWindow();
        playWindow.initPlayWindow(context, frameLayout, 0, false);
        playWindow.openTouchListener();
        /**
         * Start preview
         * 1. Prepare to preview the parameters
         * 2. Open preview
         * 3. Process the preview result in the LCOpenSDK_EventListener callback
         * 4. Stop preview
         * 5. Release resources
         */
        // accessToken, deviceId, channelId, psk, playToken, bateMode, isOpt, isOpenAudio, imageSize
        val paramReal: LCOpenSDK_ParamReal = LCOpenSDK_ParamReal(
            accessToken,
            deviceId,
            0,
            "",
            "",
            0,
            true,
            true,
            500
        )
        playWindow.playRtspReal(paramReal);
    }


    override fun dispose() {
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initSDK" -> initSDK(call, result)
        }
    }

    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
    }

    override fun onActivityStarted(activity: Activity) {
    }

    override fun onActivityResumed(activity: Activity) {
    }

    override fun onActivityPaused(activity: Activity) {
    }

    override fun onActivityStopped(activity: Activity) {
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
    }

    override fun onActivityDestroyed(activity: Activity) {
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    }

    override fun onCancel(arguments: Any?) {
    }
}