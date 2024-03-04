import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imou_plugin/imou_plugin_method_channel.dart';

void main() {
  MethodChannelImouPlugin platform = MethodChannelImouPlugin();
  const MethodChannel channel = MethodChannel('imou_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
