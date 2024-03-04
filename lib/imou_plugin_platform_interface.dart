import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'imou_plugin_method_channel.dart';

abstract class ImouPluginPlatform extends PlatformInterface {
  /// Constructs a ImouPluginPlatform.
  ImouPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImouPluginPlatform _instance = MethodChannelImouPlugin();

  /// The default instance of [ImouPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelImouPlugin].
  static ImouPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImouPluginPlatform] when
  /// they register themselves.
  static set instance(ImouPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
