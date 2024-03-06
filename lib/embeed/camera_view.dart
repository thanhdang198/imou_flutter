import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:imou_plugin/controller/camera_controller.dart';
import 'package:imou_plugin/controller/camera_event.dart';

import '../model/camera_view_options.dart';

typedef OnCameraViewCreatedCallBack = void Function(
    CameraViewController controller);

///Embeddable CameraView.
class CameraView extends StatelessWidget {
  static const StandardMessageCodec _decoder = StandardMessageCodec();

  final OnCameraViewCreatedCallBack? onCreated;
  final CameraViewOptions cameraViewOptions;
  final ValueSetter<CameraEvent>? onCameraEvent;
  static const String viewType = 'ImouCameraView';

  const CameraView(
      {super.key,
      this.onCreated,
      required this.cameraViewOptions,
      this.onCameraEvent});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // using Hybrid Composition
      return PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          return PlatformViewsService.initAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: cameraViewOptions.toJson(),
            creationParamsCodec: _decoder,
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..addOnPlatformViewCreatedListener(_onPlatformViewCreated)
            ..create();
        },
      );
    } else if (Platform.isIOS) {
      return UiKitView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: cameraViewOptions.toJson(),
          creationParamsCodec: _decoder);
    } else {
      return Container();
    }
  }

  void _onPlatformViewCreated(int id) {
    if (onCreated == null) {
      return;
    }
    onCreated!(CameraViewController(id, onCameraEvent));
  }
}
