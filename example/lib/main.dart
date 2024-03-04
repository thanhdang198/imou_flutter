import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:imou_plugin/embeed/camera_view.dart';
import 'package:imou_plugin/imou_plugin.dart';
import 'package:imou_plugin/model/camera_view_options.dart';
import 'package:imou_plugin/repository/get_access_token.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _imouPlugin = ImouPlugin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var res = await ImouConnect.getAccessToken(
          appId: 'lc673b804bdb5849cd',
          appSecret: '084b036c517c4f4d94e0583e0f770a',
          id: '121223');
      setState(() {
        cameraViewOptions = CameraViewOptions(
            accessToken: res?.result?.data?.accessToken ?? '',
            deviceId: 'deviceId',
            channelId: 0,
            psk: 'psk',
            playToken: 'playToken',
            bateMode: 0,
            isOpt: true,
            isOpenAudio: true,
            imageSize: 500);
      });
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {} on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  CameraViewOptions? cameraViewOptions;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: cameraViewOptions != null
              ? CameraView(
                  onCreated: (controller) {
                    controller.initSDK(cameraViewOptions!);
                    print('called init ');
                  },
                  cameraViewOptions: cameraViewOptions!,
                )
              : Text("Vietmapppp"),
        ),
      ),
    );
  }
}
