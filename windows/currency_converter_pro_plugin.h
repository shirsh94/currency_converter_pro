#ifndef FLUTTER_PLUGIN_CURRENCY_CONVERTER_PRO_PLUGIN_H_
#define FLUTTER_PLUGIN_CURRENCY_CONVERTER_PRO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace currency_converter_pro {

class CurrencyConverterProPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CurrencyConverterProPlugin();

  virtual ~CurrencyConverterProPlugin();

  // Disallow copy and assign.
  CurrencyConverterProPlugin(const CurrencyConverterProPlugin&) = delete;
  CurrencyConverterProPlugin& operator=(const CurrencyConverterProPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace currency_converter_pro

#endif  // FLUTTER_PLUGIN_CURRENCY_CONVERTER_PRO_PLUGIN_H_
