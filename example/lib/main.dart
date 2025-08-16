import 'package:encrypter/encrypter/aes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String key = "datadirr";
  final String _plainTxt = "Hello datadirr";
  String? _encryptTxt = "";
  String? _decryptTxt = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("plainTxt: $_plainTxt"),
                ElevatedButton(
                  onPressed: () {
                    _encryptAES256CBC();
                  },
                  child: const Text("Encrypt"),
                ),
                Text("encryptTxt: $_encryptTxt"),
                ElevatedButton(
                  onPressed: () {
                    _decryptAES256CBC();
                  },
                  child: const Text("Decrypt"),
                ),
                Text("decryptTxt: $_decryptTxt"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _encryptAES256CBC() async {
    _encryptTxt = await Encrypter.encryptAES256CBC(_plainTxt, key: key);
    setState(() {});
  }

  void _decryptAES256CBC() async {
    _decryptTxt = await Encrypter.decryptAES256CBC(_encryptTxt, key: key);
    setState(() {});
  }
}
