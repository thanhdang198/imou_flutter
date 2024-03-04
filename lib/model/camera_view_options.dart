class CameraViewOptions {
  final String accessToken;
  final String deviceId;
  final int channelId;
  final String psk;
  final String playToken;
  final int bateMode;
  final bool isOpt;
  final bool isOpenAudio;
  final int imageSize;

  CameraViewOptions(
      {required this.accessToken,
      required this.deviceId,
      required this.channelId,
      required this.psk,
      required this.playToken,
      required this.bateMode,
      required this.isOpt,
      required this.isOpenAudio,
      required this.imageSize});
  toJson() {
    return {
      'accessToken': accessToken,
      'deviceId': deviceId,
      'channelId': channelId,
      'psk': psk,
      'playToken': playToken,
      'bateMode': bateMode,
      'isOpt': isOpt,
      'isOpenAudio': isOpenAudio,
      'imageSize': imageSize
    };
  }
}
