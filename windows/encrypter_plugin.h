#ifndef FLUTTER_PLUGIN_ENCRYPTER_PLUGIN_H_
#define FLUTTER_PLUGIN_ENCRYPTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace encrypter {

class EncrypterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  EncrypterPlugin();

  virtual ~EncrypterPlugin();

  // Disallow copy and assign.
  EncrypterPlugin(const EncrypterPlugin&) = delete;
  EncrypterPlugin& operator=(const EncrypterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace encrypter

#endif  // FLUTTER_PLUGIN_ENCRYPTER_PLUGIN_H_
