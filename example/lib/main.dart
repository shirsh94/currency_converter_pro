import 'package:flutter/material.dart';
import 'dart:async';
import 'package:currency_converter_pro/currency_converter_pro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ConverterTabs(),
    );
  }
}

class ConverterTabs extends StatelessWidget {
  const ConverterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Currency and Crypto Converter'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Currency'),
              Tab(text: 'Crypto'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CurrencyConverterScreen(),
            CryptoConverterScreen(),
          ],
        ),
      ),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _convertedAmount = '';
  String _fromCurrency = 'usd';
  String _toCurrency = 'inr';
  final List<String> _currencies = [
    'usd',
    'inr',
    'eur',
    'gbp',
    'jpy',
    'aud',
    'cad'
  ];

  Future<void> _convertCurrency() async {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    try {
      final _currencyConverterProPlugin = CurrencyConverterPro();
      final result = await _currencyConverterProPlugin.convertCurrency(
        amount: amount,
        fromCurrency: _fromCurrency,
        toCurrency: _toCurrency,
      );
      setState(() {
        _convertedAmount = result.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _convertedAmount = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Currency Converter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _fromCurrency,
                  items: _currencies.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value ?? 'usd';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'From Currency',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.swap_horiz, size: 30, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _toCurrency,
                  items: _currencies.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value ?? 'inr';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'To Currency',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Amount',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.confirmation_number, color: Colors.blue),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertCurrency,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: const Text(
              'Convert Currency',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _convertedAmount.isEmpty
                ? 'Converted Amount will appear here'
                : 'Converted Amount: $_convertedAmount $_toCurrency',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CryptoConverterScreen extends StatefulWidget {
  const CryptoConverterScreen({super.key});

  @override
  _CryptoConverterScreenState createState() => _CryptoConverterScreenState();
}

class _CryptoConverterScreenState extends State<CryptoConverterScreen> {
  final _currencyConverterProPlugin = CurrencyConverterPro();
  double amount = 1.0;
  double convertedAmount = 0.0;
  String fromCrypto = 'bitcoin';
  String toCrypto = 'ethereum';

  final List<String> cryptoList = [
    'bitcoin',
    'ethereum',
    'litecoin',
    'ripple',
    'cardano',
    'dogecoin',
  ];

  Future<void> convert() async {
    convertedAmount = await _currencyConverterProPlugin.convertCrypto(
        fromCrypto, toCrypto, amount);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Crypto Currency Converter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: fromCrypto,
                  items: cryptoList.map((String crypto) {
                    return DropdownMenuItem<String>(
                      value: crypto,
                      child: Text(crypto.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      fromCrypto = value ?? 'bitcoin';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'From Crypto',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.swap_horiz, size: 30, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: toCrypto,
                  items: cryptoList.map((String crypto) {
                    return DropdownMenuItem<String>(
                      value: crypto,
                      child: Text(crypto.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      toCrypto = value ?? 'ethereum';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'To Crypto',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter Amount',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.confirmation_number, color: Colors.blue),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amount = double.tryParse(value) ?? 0.0;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Cypto Convert Currency',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Equivalent: ${convertedAmount.toStringAsFixed(6)} $toCrypto'),
        ],
      ),
    );
  }
}
