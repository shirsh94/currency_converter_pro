# currency_converter_pro

A simple and user-friendly **Currency** and **Crypto Currency** Converter Flutter application that allows users to convert currencies and crypto currencies, input an amount, and convert it to their desired target currency or crypto currency. The app leverages the CurrencyConverterPro plugin to fetch real-time exchange rates and perform accurate conversions.

![logo Screen](https://raw.githubusercontent.com/shirsh94/currency_converter_pro/refs/heads/main/example/assets/logo.png)
---

## Features
✅ **Multi-Currency and Crypto Support**: Convert seamlessly between fiat currencies and cryptocurrencies within a single API call.

✅ **Multi-Currency Support**: Convert between multiple currencies including USD, INR, EUR, GBP, JPY, AUD, CAD and more.

✅ **Easy Integration**: Simple API to integrate currency conversion functionality into your Flutter applications.

✅ **Asynchronous Operations**: Perform currency conversion in a non-blocking manner.

✅ **Cryptocurrency Conversion**: Easily convert between popular cryptocurrencies such as Bitcoin (BTC), Ethereum (ETH), Ripple (XRP), and more.

✅ **Real-Time Exchange Rates**: Access real-time data for accurate cryptocurrency conversions, ensuring your app always provides up-to-date information.

✅ **User-Friendly API**: A simple and intuitive API designed for easy integration of cryptocurrency conversion functionality into your Flutter applications.

✅ **Example Application**: Comes with a complete example application demonstrating how to implement cryptocurrency conversion features effectively.

---

## Screenshots
| ![Screenshot 1](https://raw.githubusercontent.com/shirsh94/currency_converter_pro/refs/heads/main/example/assets/screenshot.png) | ![Screenshot 2](https://raw.githubusercontent.com/shirsh94/currency_converter_pro/refs/heads/main/example/assets/screenshot_crypto.png) |
---

## Getting Started

To integrate this package into your Flutter project, follow these steps:

1. **Add Dependency**
   Add the following to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     currency_converter_pro: ^0.0.7
   ```

2. **Install Dependencies**
   Run the following command in your terminal:

   ```bash
   flutter pub get
   ```
   ```dart
   import 'package:currency_converter_pro/currency_converter_pro.dart';
   ```

3. **Currency Conversion Usage**
   Here's how to use the `CurrencyConverterPro` plugin in your app for currency:

   ```dart
     final _currencyConverterProPlugin = CurrencyConverterPro();
         final result = await _currencyConverterProPlugin.convertCurrency(
           amount: 1.0,
           fromCurrency: 'usd',
           toCurrency: 'inr',
         );
   ```

4. **Currency Conversion Usage**
   Here's how to use the `CurrencyConverterPro` plugin in your app for Crypto currency:

   ```dart
     final _currencyConverterProPlugin = CurrencyConverterPro();
         final result = await _currencyConverterProPlugin.convertCrypto(
           amount: 1.0,
           fromCurrency: 'bitcoin',
           toCurrency: 'ethereum',
         );
   ```

## Full Code Example
   ```dart
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

   ```

---

## How Example Works

1. **Currency and Crypto Currency Dropdown**: Users can select the source and target currencies using dropdown menus.
2. **Amount Input**: Users can enter the amount to be converted.
3. **Convert Button**: Upon clicking "Convert Currency," the app fetches the exchange rate and displays the converted amount.

---

## Supported Currencies and crypto Currencies

**The app supports popular currencies including**:

- **USD** (US Dollar)
- **INR** (Indian Rupee)
- **EUR** (Euro)
- **GBP** (British Pound)
- **JPY** (Japanese Yen)
- **AUD** (Australian Dollar)
- **CAD** (Canadian Dollar)
- **CHF** (Swiss Franc)
- **CNY** (Chinese Yuan)
- **NZD** (New Zealand Dollar)
- **SGD** (Singapore Dollar)
- **HKD** (Hong Kong Dollar)
- **NOK** (Norwegian Krone)
- **SEK** (Swedish Krona)
- **MXN** (Mexican Peso)
- **RUB** (Russian Ruble)
- **ZAR** (South African Rand)
- **BRL** (Brazilian Real)
- **DKK** (Danish Krone)
- **PLN** (Polish Zloty)
- **THB** (Thai Baht)
  And more...


**The app also supports popular cryptocurrencies including**:
- **BTC** (Bitcoin)
- **ETH** (Ethereum)
- **XRP** (Ripple)
- **LTC** (Litecoin)
- **BCH** (Bitcoin Cash)
- **ADA** (Cardano)
- **DOT** (Polkadot)
- **SOL** (Solana)
- **DOGE** (Dogecoin)
- **USDT** (Tether)
- **LINK** (Chainlink)
- **BNB** (Binance Coin)
- **XLM** (Stellar)
And more...

---

## Contributions

Contributions to **Currency Converter Pro** are welcome! Feel free to submit issues or pull requests to enhance the package.

---

## License

The MIT License (MIT) Copyright (c) 2024 Shirsh Shukla

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---
