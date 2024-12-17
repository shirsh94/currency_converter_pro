import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'currency_converter_pro_platform_interface.dart';

/// An implementation of [CurrencyConverterProPlatform] that uses method channels.
class MethodChannelCurrencyConverterPro extends CurrencyConverterProPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('currency_converter_pro');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
