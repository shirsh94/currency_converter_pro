import 'currency_converter_pro_platform_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverterPro {
  Future<String?> getPlatformVersion() {
    return CurrencyConverterProPlatform.instance.getPlatformVersion();
  }
  final String baseUrl;

  CurrencyConverterPro({this.baseUrl = 'https://currency-api.pages.dev/v1/currencies/'});

  /// Fetches the exchange rate for a currency pair.
  ///
  /// [fromCurrency] - The base currency (e.g., 'usd').
  /// [toCurrency] - The target currency (e.g., 'inr').
  /// Returns the exchange rate as a double.
  Future<double> fetchExchangeRate({required String fromCurrency, required String toCurrency}) async {
    final url = Uri.parse('$baseUrl$fromCurrency.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rate = data[fromCurrency]?[toCurrency];
      if (rate != null) {
        return rate.toDouble();
      } else {
        throw Exception('Exchange rate for $fromCurrency to $toCurrency not found.');
      }
    } else {
      throw Exception('Failed to fetch exchange rate: ${response.statusCode}');
    }
  }

  /// Converts an amount from the base currency to the target currency.
  ///
  /// [amount] - The amount to be converted.
  /// [fromCurrency] - The base currency (e.g., 'usd').
  /// [toCurrency] - The target currency (e.g., 'inr').
  /// Returns the converted amount as a double.
  Future<double> convertCurrency({required double amount, required String fromCurrency, required String toCurrency}) async {
    final rate = await fetchExchangeRate(fromCurrency: fromCurrency, toCurrency: toCurrency);
    return amount * rate;
  }
}
