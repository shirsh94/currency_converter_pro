#include "include/currency_converter_pro/currency_converter_pro_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "currency_converter_pro_plugin.h"

void CurrencyConverterProPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  currency_converter_pro::CurrencyConverterProPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
