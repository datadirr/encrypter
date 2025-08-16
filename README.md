[<img src="https://datadirr.com/datadirr.png" width="200" />](https://datadirr.com)


# encrypter

This package helps to encryption and decryption and hash with verification.

## Using

For help getting started with Flutter, view our
[online documentation](https://pub.dev/documentation/encrypter/latest), which offers tutorials,
samples, guidance on mobile and web development, and a full API reference.

## Installation

First, add `encrypter` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

In your flutter project add the dependency:

```yml
dependencies:
  ...
  encrypter:
```

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).

## Example

Please follow this [example](https://github.com/datadirr/encrypter/tree/master/example) here.


### AES Encryption and Decryption

* AES-256-CBC
```dart
import 'package:encrypter/encrypter/aes.dart';

String encryptTxt = Encrypter.encryptAES256CBC("Hello datadirr", key: "datadirr");
String decryptTxt = Encrypter.decryptAES256CBC(encryptTxt, key: "datadirr");
```


### XOR Encryption and Decryption

1. With Secret Key

* Method 1
```dart
XOR xor = XOR(secretKey: "datadirr");
String encryptTxt = xor.xorEncode("Hello datadirr");
String decryptTxt = xor.xorDecode(encryptTxt);
```

* Method 2
```dart
XOR xor = XOR();
String encryptTxt = xor.xorEncode("Hello datadirr", secretKey: "datadirr");
String decryptTxt = xor.xorDecode(encryptTxt, secretKey: "datadirr");
```

* Method 3
```dart
String encryptTxt = XOR().xorEncode("Hello datadirr", secretKey: "datadirr");
String decryptTxt = XOR().xorDecode(encryptTxt, secretKey: "datadirr");
```

* Method 4
```dart
String encryptTxt = XOR(secretKey: "datadirr").xorEncode("Hello datadirr");
String decryptTxt = XOR(secretKey: "datadirr").xorDecode(encryptTxt);
```


1. Without Secret Key

* Method 1
```dart
XOR xor = XOR();
String encryptTxt = xor.xorEncode("Hello datadirr");
String decryptTxt = xor.xorDecode(encryptTxt);
```

* Method 2
```dart
String encryptTxt = XOR().xorEncode("Hello datadirr");
String decryptTxt = XOR().xorDecode(encryptTxt);
```