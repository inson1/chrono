import 'package:clock_app/clock/logic/inittialize_default_favorite_cities.dart';
import 'package:clock_app/settings/data/settings_data.dart';
import 'package:clock_app/settings/types/setting.dart';
import 'package:clock_app/settings/types/settings_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

initializeSettings() async {
  await SettingsManager.initialize();
  SharedPreferences? preferences = SettingsManager.preferences;

  // Used to clear the preferences in case of a change in format of the data
  // Comment this out after the preferences are cleared
  // preferences?.clear();

  bool? firstLaunch = SettingsManager.preferences?.getBool('first_launch');
  if (firstLaunch == null) {
    SettingsManager.preferences?.setBool('first_launch', false);
    initializeDefaultFavoriteCities();

    for (SettingGroup group in settings) {
      for (Setting setting in group.settings) {
        if (setting is ToggleSetting) {
          preferences?.setBool(setting.name, setting.defaultValue);
        } else if (setting is NumberSetting) {
          preferences?.setDouble(setting.name, setting.defaultValue);
        } else if (setting is ColorSetting) {
          preferences?.setInt(setting.name, setting.defaultValue.value);
        } else if (setting is StringSetting) {
          preferences?.setString(setting.name, setting.defaultValue);
        } else if (setting is SliderSetting) {
          preferences?.setDouble(setting.name, setting.defaultValue);
        } else if (setting is SelectSetting) {
          preferences?.setInt(setting.name, setting.defaultValue);
        }
      }
    }
  }
}