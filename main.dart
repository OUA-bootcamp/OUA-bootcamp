import 'package:flutter/material.dart';

void main() {
  runApp(const HesapMakinApp());
}

class HesapMakinApp extends StatelessWidget {
  const HesapMakinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HesapMakin',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double num1 = 0.0;
  double num2 = 0.0;
  double sonuc = 0.0;
  String operation = '';

  void calculateResult() {
    setState(() {
      switch (operation) {
        case '+':
          sonuc = num1 + num2;
          break;
        case '-':
          sonuc = num1 - num2;
          break;
        case '*':
          sonuc = num1 * num2;
          break;
        case '/':
          if (num2 != 0) {
            sonuc = num1 / num2;
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Cannot divide by zero.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesap Makinem - AMANE'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sonuç: $sonuc',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'İLK SAYIYI YAZ'),
              onChanged: (value) {
                num1 = double.parse(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'İKİNCİ SAYIYI YAZ'),
              onChanged: (value) {
                num2 = double.parse(value);
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    operation = '+';
                    calculateResult();
                  },
                  child: const Text('+'),
                ),
                ElevatedButton(
                  child: const Text('-'),
                  onPressed: () {
                    operation = '-';
                    calculateResult();
                  },
                ),
                ElevatedButton(
                  child: const Text('*'),
                  onPressed: () {
                    operation = '*';
                    calculateResult();
                  },
                ),
                ElevatedButton(
                  child: const Text('/'),
                  onPressed: () {
                    operation = '/';
                    calculateResult();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}