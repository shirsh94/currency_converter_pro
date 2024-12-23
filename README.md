# currency_converter_pro

A simple and user-friendly **Currency Converter** Flutter application that allows users to select currencies, input an amount, and convert it to their desired target currency. The app leverages the **CurrencyConverterPro** plugin to fetch real-time exchange rates and perform accurate currency conversion.

(https://raw.githubusercontent.com/shirsh94/currency_converter_pro/refs/heads/main/example/assets/img.png)
---

## Features
✅ **Multi-Currency Support**: Convert between multiple currencies including USD, INR, EUR, GBP, JPY, AUD, CAD and more.

✅ **Easy Integration**: Simple API to integrate currency conversion functionality into your Flutter applications.

✅ **Asynchronous Operations**: Perform currency conversion in a non-blocking manner.

---

## Screenshots

![Home Screen](https://raw.githubusercontent.com/shirsh94/currency_converter_pro/refs/heads/main/example/assets/img.png)

---

## Getting Started

To integrate this package into your Flutter project, follow these steps:

1. **Add Dependency**
   Add the following to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     currency_converter_pro: ^0.0.5
   ```

2. **Install Dependencies**
   Run the following command in your terminal:

   ```bash
   flutter pub get
   ```
   ```dart
   import 'package:currency_converter_pro/currency_converter_pro.dart';
   ```

3. **Usage**
   Here's how to use the `CurrencyConverterPro` plugin in your app:

   ```dart
     final _currencyConverterProPlugin = CurrencyConverterPro();
         final result = await _currencyConverterProPlugin.convertCurrency(
           amount: 1.0,
           fromCurrency: 'usd',
           toCurrency: 'inr',
         );
   ```

## Full Code Example
   ```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:currency_converter_pro/currency_converter_pro.dart';

void main() {
   runApp(const MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({super.key});

   @override
   State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   final TextEditingController _amountController = TextEditingController();

   String _convertedAmount = '';
   String _fromCurrency = 'usd';
   String _toCurrency = 'inr';
   final List<String> _currencies = ['usd', 'inr', 'eur', 'gbp', 'jpy', 'aud', 'cad'];

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
            print("Converted Amount $_convertedAmount");
         });
      } catch (e) {
         setState(() {
            _convertedAmount = 'Error: \$e';
         });
      }
   }

   @override
   Widget build(BuildContext context) {
      return MaterialApp(
         home: Scaffold(
            appBar: AppBar(
               title: const Text('Currency Converter'),
               backgroundColor: Colors.blue,
            ),
            body: Container(
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
            ),
         ),
      );
   }
}
   ```

---

## How Example Works

1. **Currency Dropdown**: Users can select the source and target currencies using dropdown menus.
2. **Amount Input**: Users can enter the amount to be converted.
3. **Convert Button**: Upon clicking "Convert Currency," the app fetches the exchange rate and displays the converted amount.

---

## Supported Currencies

The app supports popular currencies including:
- **USD** (US Dollar)
- **INR** (Indian Rupee)
- **EUR** (Euro)
- **GBP** (British Pound)
- **JPY** (Japanese Yen)
- **AUD** (Australian Dollar)
- **CAD** (Canadian Dollar) and more...

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
