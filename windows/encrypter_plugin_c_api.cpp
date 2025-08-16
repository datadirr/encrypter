#include "include/encrypter/encrypter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "encrypter_plugin.h"

void EncrypterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  encrypter::EncrypterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
