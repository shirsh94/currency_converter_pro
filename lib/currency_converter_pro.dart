import 'currency_converter_pro_platform_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverterPro {
  final String _currencyUrl = "https://currency-api.pages.dev/v1/currencies/";
  final String _cryptoUrl = 'https://api.coingecko.com/api/v3';

  Future<String?> getPlatformVersion() {
    return CurrencyConverterProPlatform.instance.getPlatformVersion();
  }

  /// Fetches the exchange rate for a currency pair.
  ///
  /// [fromCurrency] - The base currency (e.g., 'usd').
  /// [toCurrency] - The target currency (e.g., 'inr').
  /// Returns the exchange rate as a double.
  Future<double> fetchExchangeRate(
      {required String fromCurrency, required String toCurrency}) async {
    final url = Uri.parse('$_currencyUrl$fromCurrency.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rate = data[fromCurrency]?[toCurrency];
      if (rate != null) {
        return rate.toDouble();
      } else {
        throw Exception(
            'Exchange rate for $fromCurrency to $toCurrency not found.');
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
  Future<double> convertCurrency(
      {required double amount,
      required String fromCurrency,
      required String toCurrency}) async {
    final rate = await fetchExchangeRate(
        fromCurrency: fromCurrency, toCurrency: toCurrency);
    return amount * rate;
  }

  Future<double> convertCrypto(
      String fromId, String toId, double amount) async {
    final prices = await _getCryptoPrices([fromId, toId]);
    final fromPrice = prices[fromId]!;
    final toPrice = prices[toId]!;

    return (amount * fromPrice) / toPrice;
  }

  Future<Map<String, double>> _getCryptoPrices(List<String> ids) async {
    final response = await http.get(
      Uri.parse(
          '$_cryptoUrl/simple/price?ids=${ids.join(',')}&vs_currencies=usd'),
    );

    if (response.statusCode == 200) {
      return Map<String, double>.from(
        json
            .decode(response.body)
            .map((key, value) => MapEntry(key, value['usd'])),
      );
    } else {
      throw Exception('Failed to load cryptocurrency prices');
    }
  }
}
