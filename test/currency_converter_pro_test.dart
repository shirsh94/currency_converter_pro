import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter_pro/currency_converter_pro.dart';
import 'package:currency_converter_pro/currency_converter_pro_platform_interface.dart';
import 'package:currency_converter_pro/currency_converter_pro_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCurrencyConverterProPlatform
    with MockPlatformInterfaceMixin
    implements CurrencyConverterProPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CurrencyConverterProPlatform initialPlatform = CurrencyConverterProPlatform.instance;

  test('$MethodChannelCurrencyConverterPro is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCurrencyConverterPro>());
  });

  test('getPlatformVersion', () async {
    CurrencyConverterPro currencyConverterProPlugin = CurrencyConverterPro();
    MockCurrencyConverterProPlatform fakePlatform = MockCurrencyConverterProPlatform();
    CurrencyConverterProPlatform.instance = fakePlatform;

    expect(await currencyConverterProPlugin.getPlatformVersion(), '42');
  });
}
