import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'currency_converter_pro_method_channel.dart';

abstract class CurrencyConverterProPlatform extends PlatformInterface {
  /// Constructs a CurrencyConverterProPlatform.
  CurrencyConverterProPlatform() : super(token: _token);

  static final Object _token = Object();

  static CurrencyConverterProPlatform _instance = MethodChannelCurrencyConverterPro();

  /// The default instance of [CurrencyConverterProPlatform] to use.
  ///
  /// Defaults to [MethodChannelCurrencyConverterPro].
  static CurrencyConverterProPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CurrencyConverterProPlatform] when
  /// they register themselves.
  static set instance(CurrencyConverterProPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
