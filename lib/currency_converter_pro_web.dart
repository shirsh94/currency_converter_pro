// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'currency_converter_pro_platform_interface.dart';

/// A web implementation of the CurrencyConverterProPlatform of the CurrencyConverterPro plugin.
class CurrencyConverterProWeb extends CurrencyConverterProPlatform {
  /// Constructs a CurrencyConverterProWeb
  CurrencyConverterProWeb();

  static void registerWith(Registrar registrar) {
    CurrencyConverterProPlatform.instance = CurrencyConverterProWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    return "0";
  }
}
