import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter_pro/currency_converter_pro_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCurrencyConverterPro platform = MethodChannelCurrencyConverterPro();
  const MethodChannel channel = MethodChannel('currency_converter_pro');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
