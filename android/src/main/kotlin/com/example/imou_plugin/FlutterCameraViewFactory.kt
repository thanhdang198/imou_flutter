package com.example.imou_plugin

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Bundle
import android.view.View
import android.widget.FrameLayout
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

import com.lechange.opensdk.api.InitParams
import com.lechange.opensdk.api.LCOpenSDK_Api
import com.lechange.opensdk.device.LCOpenSDK_DeviceInit
import com.lechange.opensdk.listener.LCOpenSDK_EventListener
import com.lechange.opensdk.media.DeviceInitInfo
import com.lechange.opensdk.media.LCOpenSDK_ParamReal
import com.lechange.opensdk.media.LCOpenSDK_PlayWindow
import com.lechange.opensdk.searchwifi.LCOpenSDK_SearchWiFi
import com.lechange.opensdk.softap.LCOpenSDK_SoftAPConfig
import com.lechange.opensdk.utils.LCOpenSDK_Utils
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
    Application.ActivityLifecycleCallbacks, EventChannel.StreamHandler{

    private val activity: Activity = act
    private val context: Context = ctx
    private val methodChannel: MethodChannel
    private val eventChannel: EventChannel
    private var frameLayout: FrameLayout
    private var accessToken: String=""
    private var deviceId: String=""
    private var channelId: String =""
    private  var psk: Int=0
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
    private  fun initSDK(){

    }
    fun playRealtime(){

            val playWindow :LCOpenSDK_PlayWindow=  LCOpenSDK_PlayWindow();
            playWindow.initPlayWindow(context,  frameLayout, 0, false);
//The developer implements event monitoring and sets the monitoring to playWindow
//        val listener :LCOpenSDK_EventListener=   LCOpenSDK_EventListener(){
//            println("Playing")
//        }//Developer implements event listener callback
//        playWindow.setWindowListener(listener);
//Turn on tidy up monitoring
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
            val  paramReal : LCOpenSDK_ParamReal =  LCOpenSDK_ParamReal("At_0000sgb4fdba168efa407cadce2a3224",deviceId,0,"","",0,true,true,0)
            playWindow.playRtspReal(paramReal);
//        playWindow.stopRtspReal(true);
//        playWindow.uninitPlayWindow();

    }

    override fun dispose() {
        TODO("Not yet implemented")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call.method) {
            "initSDK"-> initSDK()
        }
        }

    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
        TODO("Not yet implemented")
    }

    override fun onActivityStarted(activity: Activity) {
        TODO("Not yet implemented")
    }

    override fun onActivityResumed(activity: Activity) {
        TODO("Not yet implemented")
    }

    override fun onActivityPaused(activity: Activity) {
        TODO("Not yet implemented")
    }

    override fun onActivityStopped(activity: Activity) {
        TODO("Not yet implemented")
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
        TODO("Not yet implemented")
    }

    override fun onActivityDestroyed(activity: Activity) {
        TODO("Not yet implemented")
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        TODO("Not yet implemented")
    }

    override fun onCancel(arguments: Any?) {
        TODO("Not yet implemented")
    }
}