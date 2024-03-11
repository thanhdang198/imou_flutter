class CameraViewOptions {
  final String accessToken;
  final String deviceId;
  final int channelId;
  final String psk;
  final String playToken;
  final int bateMode;
  final bool isOpt;
  final bool isOpenAudio;

  /// use for android
  final int imageSize;

  /// use only for ios
  final int width;

  /// use only for ios
  final int height;

  CameraViewOptions(
      {required this.accessToken,
      required this.deviceId,
      required this.channelId,
      required this.psk,
      required this.playToken,
      required this.bateMode,
      this.width = 400,
      this.height = 300,
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
      'imageSize': imageSize,
      'width': width,
      'height': height
    };
  }
}
