import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../model/access_token_response.dart';

class ImouConnect {
  // id is random string, will return in response
  static Future<AccessTokenResponse?> getAccessToken(
      {required String appId,
      required String id,
      required String appSecret}) async {
    String serverUrl = 'https://openapi-sg.easy4ip.com:443/openapi/accessToken';
    //      "appId": "lc673b804bdb5849cd",
    String nonce = Uuid().v4();
    int time = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    var initialBody = {
      "system": {
        "ver": "1.0",
        "appId": appId,
        "sign": _generateMd5(
            _getSign(time: time, nonce: nonce, appSecret: appSecret)),
        "time": time,
        "nonce": nonce
      },
      "id": id,
      "params": {}
    };

    try {
      var req = await Dio().post(serverUrl, data: initialBody);
      print(req.data);
      return AccessTokenResponse.fromJson(json.decode(req.data));
    } catch (e) {
      print("Failure");
      return null;
    }
  }

  static String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String _getSign(
      {required int time, required String nonce, required String appSecret}) {
    // ignore: prefer_interpolation_to_compose_strings
    return 'time:' +
        time.toString() +
        ",nonce:" +
        nonce +
        ",appSecret:" +
        appSecret;
  }
}
