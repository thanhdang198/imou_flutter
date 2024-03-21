import 'package:flutter/material.dart';
import 'package:imou_plugin/embeed/camera_view.dart';
import 'package:imou_plugin/model/access_token_response.dart';
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
  AccessTokenResponse? res;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var resTmp = await ImouConnect.getAccessToken(

          /// 2 cái này lấy từ website imou
          appId: 'lc673b804bdb5849cd',
          appSecret: '084b036c517c4f4d94e0583e0f770a',
          // appId: 'lcc41c89fa2aa643f7',
          // appSecret: '4a3d2ce2b8614c4ca7082e3d8db35c',

          /// id là chuỗi string ngẫu nhiên
          id: '121223');
      print(resTmp);
      setState(() {
        res = resTmp;
      });
    });
  }

  _getData() async {
    setState(() {
      cameraViewOptions = CameraViewOptions(

          /// Access token được lấy từ api
          accessToken: res?.result?.data?.accessToken ?? '',

          /// Serial của camera
          deviceId: '9E0CA37PBVD4085',
          // deviceId: 'L28F3A2D',
          // deviceId: '2AVYF-IPC-CX2S',
          /// 5 cái này giữ nguyên
          channelId: 0,
          psk: 'psk',
          playToken: '',
          bateMode: 0,
          isOpt: true,
          // Width, height cho iOS
          width: 100,
          height: 100,
          isOpenAudio: true,
          imageSize: 500);
    });
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
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _getData();
                },
                child: Text('Show camera')),
            cameraViewOptions != null
                ? SizedBox(
                    /// Width height cho android
                    width: 100,
                    height: 100,
                    child: CameraView(
                      onCreated: (controller) {
                        controller.initSDK(cameraViewOptions!);
                        print('called init ');
                      },
                      cameraViewOptions: cameraViewOptions!,
                    ),
                  )
                : Text("Click button below to show view"),
            Text('Thanhdang98')
          ],
        )),
      ),
    );
  }
}
