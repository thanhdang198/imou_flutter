import 'dart:async';
import 'package:imou_plugin/controller/platform_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:imou_plugin/model/camera_view_options.dart';

import 'camera_event.dart';

enum DrivingProfile { drivingTraffic, cycling, walking, motorcycle }

/// Controller for a single Camera instance running on the host platform.
class CameraViewController {
  late MethodChannel _methodChannel;
  late EventChannel _eventChannel;

  ValueSetter<CameraEvent>? _cameraEventNotifier;

  Stream<CameraEvent>? _onCameraEvent;
  late StreamSubscription<CameraEvent> _cameraEventSubscription;

  CameraViewController(int id, ValueSetter<CameraEvent>? eventNotifier) {
    _methodChannel = MethodChannel('imou_plugin/$id');
    _methodChannel.setMethodCallHandler(_handleMethod);

    _eventChannel = EventChannel('imou_plugin/$id/events');
    _cameraEventNotifier = eventNotifier;
  }
  void initSDK(CameraViewOptions options) {
    _methodChannel
        .invokeMethod(PlatformEvent.initSDK.name, options.toJson())
        .then<String>((dynamic result) => result);
  }

  ///Current Device OS Version
  Future<String> get platformVersion => _methodChannel
      .invokeMethod(PlatformEvent.initSDK.name)
      .then<String>((dynamic result) => result);

  /// Generic Handler for Messages sent from the Platform
  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'sendFromNative':
        String? text = call.arguments as String?;
        return Future.value("Text from native: $text");
    }
  }
}
