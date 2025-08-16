import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'encrypter_method_channel.dart';

abstract class EncrypterPlatform extends PlatformInterface {
  /// Constructs a EncrypterPlatform.
  EncrypterPlatform() : super(token: _token);

  static final Object _token = Object();

  static EncrypterPlatform _instance = MethodChannelEncrypter();

  /// The default instance of [EncrypterPlatform] to use.
  ///
  /// Defaults to [MethodChannelEncrypter].
  static EncrypterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EncrypterPlatform] when
  /// they register themselves.
  static set instance(EncrypterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
