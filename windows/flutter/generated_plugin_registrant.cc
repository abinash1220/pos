//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <awesome_notifications/awesome_notifications_plugin_c_api.h>
#include <flutter_pos_printer_platform/flutter_pos_printer_platform_plugin.h>
#include <flutter_tts/flutter_tts_plugin.h>
#include <network_info_plus_windows/network_info_plus_windows_plugin.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>
#include <printing/printing_plugin.h>
#include <share_plus/share_plus_windows_plugin_c_api.h>
#include <url_launcher_windows/url_launcher_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AwesomeNotificationsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AwesomeNotificationsPluginCApi"));
  FlutterPosPrinterPlatformPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterPosPrinterPlatformPlugin"));
  FlutterTtsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterTtsPlugin"));
  NetworkInfoPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NetworkInfoPlusWindowsPlugin"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
  SharePlusWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SharePlusWindowsPluginCApi"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
}
