
import 'imou_plugin_platform_interface.dart';

class ImouPlugin {
  Future<String?> getPlatformVersion() {
    return ImouPluginPlatform.instance.getPlatformVersion();
  }
}
