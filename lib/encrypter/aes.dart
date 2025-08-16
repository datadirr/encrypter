import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

/// This class provides AES-256-CBC encryption and decryption methods.
class Encrypter {
  Encrypter._();

  /// A default key used for encryption if no key is provided.
  /// The key is 32 characters long to match the requirements for AES-256.
  static const String _defaultKey = "@data@dirr@data@dirr@data@dirr@@";

  /// Pads a string with '@' characters to a specific length.
  /// If the string is already longer than the specified length, it is truncated.
  static String _fixedPadString(String str, int length) {
    if (str.length >= length) return str.substring(0, length);
    return str.padRight(length, '@');
  }

  /// Encodes a Uint8List into a Base64Url string.
  static String _toBase64Url(Uint8List bytes) {
    // 1. Encode the byte array to a standard Base64 string.
    String base64String = base64.encode(bytes);

    // 2. Replace URL-unsafe characters with their URL-safe equivalents.
    //    '+' is replaced with '-' and '/' is replaced with '_'.
    String base64UrlString = base64String
        .replaceAll('+', '-')
        .replaceAll('/', '_');

    // 3. Remove any trailing padding characters ('=').
    //    The regex /=+$/ matches one or more '=' characters at the end of the string.
    return base64UrlString.replaceAll(RegExp(r'=+$'), '');
  }

  /// Decodes a Base64Url back into a Uint8List, adding back padding characters if necessary.
  static Uint8List _fromBase64Url(String base64Url) {
    // 1. Replace URL-safe characters with their standard Base64 equivalents.
    //    '-' is replaced with '+', and '_' is replaced with '/'.
    final base64 = base64Url.replaceAll('-', '+').replaceAll('_', '/');

    // 2. Add back the necessary padding characters ('=').
    //    Base64 strings must have a length divisible by 4. This calculation
    //    determines how many '=' characters are needed for padding.
    final padding = '=' * ((4 - base64.length % 4) % 4);
    final padded = base64 + padding;

    // 3. Decode the padded Base64 string into a Uint8List.
    return base64Decode(padded);
  }

  /// Asynchronously encrypts data using AES-256 in CBC mode.
  /// The method supports providing a custom key and initialization vector (IV).
  static Future<String?> encryptAES256CBC(
    dynamic data, {
    String? key,
    String? iv,
  }) async {
    try {
      if (data == null) return null;

      final secretKey = _fixedPadString(key ?? _defaultKey, 32);
      final secretIV = iv;

      final hashKey = sha256.convert(utf8.encode(secretKey)).bytes;

      final ivBytes = (secretIV == null)
          ? encrypt.IV.fromSecureRandom(16).bytes
          : Uint8List.fromList(utf8.encode(_fixedPadString(secretIV, 16)));

      final ivValue = encrypt.IV(ivBytes);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key(Uint8List.fromList(hashKey)),
          mode: encrypt.AESMode.cbc,
          padding: 'PKCS7',
        ),
      );

      final encodedData = json.encode(data);
      final encrypted = encrypter.encrypt(encodedData, iv: ivValue);

      final combined = Uint8List.fromList(ivValue.bytes + encrypted.bytes);
      return _toBase64Url(combined);
    } catch (e) {
      rethrow;
    }
  }

  /// Asynchronously decrypts a encrypted string using AES-256 in CBC mode.
  static Future<dynamic> decryptAES256CBC(
    String? encryptedData, {
    String? key,
  }) async {
    try {
      if (encryptedData == null || encryptedData.isEmpty) return null;

      final secretKey = _fixedPadString(key ?? _defaultKey, 32);
      final hashKey = sha256.convert(utf8.encode(secretKey)).bytes;

      final combined = _fromBase64Url(encryptedData);

      final iv = encrypt.IV(combined.sublist(0, 16));
      final ciphertext = combined.sublist(16);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key(Uint8List.fromList(hashKey)),
          mode: encrypt.AESMode.cbc,
          padding: 'PKCS7',
        ),
      );

      final decrypted = encrypter.decrypt(
        encrypt.Encrypted(ciphertext),
        iv: iv,
      );

      return json.decode(decrypted);
    } catch (e) {
      rethrow;
    }
  }
}
