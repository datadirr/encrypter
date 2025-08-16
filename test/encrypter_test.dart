import 'package:flutter_test/flutter_test.dart';
import 'package:encrypter/encrypter.dart';
import 'package:encrypter/encrypter_platform_interface.dart';
import 'package:encrypter/encrypter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEncrypterPlatform
    with MockPlatformInterfaceMixin
    implements EncrypterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EncrypterPlatform initialPlatform = EncrypterPlatform.instance;

  test('$MethodChannelEncrypter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEncrypter>());
  });

  test('getPlatformVersion', () async {
    Encrypter encrypterPlugin = Encrypter();
    MockEncrypterPlatform fakePlatform = MockEncrypterPlatform();
    EncrypterPlatform.instance = fakePlatform;

    expect(await encrypterPlugin.getPlatformVersion(), '42');
  });
}
