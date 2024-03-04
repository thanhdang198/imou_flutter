import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'imou_plugin_platform_interface.dart';

/// An implementation of [ImouPluginPlatform] that uses method channels.
class MethodChannelImouPlugin extends ImouPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('imou_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
