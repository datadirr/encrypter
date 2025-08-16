import 'encrypter_platform_interface.dart';

class Encrypter {
  Future<String?> getPlatformVersion() {
    return EncrypterPlatform.instance.getPlatformVersion();
  }
}
