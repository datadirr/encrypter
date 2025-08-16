import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'encrypter_platform_interface.dart';

/// An implementation of [EncrypterPlatform] that uses method channels.
class MethodChannelEncrypter extends EncrypterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('encrypter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
