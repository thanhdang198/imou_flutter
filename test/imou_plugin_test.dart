import 'package:flutter_test/flutter_test.dart';
import 'package:imou_plugin/imou_plugin.dart';
import 'package:imou_plugin/imou_plugin_platform_interface.dart';
import 'package:imou_plugin/imou_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockImouPluginPlatform
    with MockPlatformInterfaceMixin
    implements ImouPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ImouPluginPlatform initialPlatform = ImouPluginPlatform.instance;

  test('$MethodChannelImouPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelImouPlugin>());
  });

  test('getPlatformVersion', () async {
    ImouPlugin imouPlugin = ImouPlugin();
    MockImouPluginPlatform fakePlatform = MockImouPluginPlatform();
    ImouPluginPlatform.instance = fakePlatform;

    expect(await imouPlugin.getPlatformVersion(), '42');
  });
}
