import 'dart:convert';

import 'package:clock_app/settings/types/setting.dart';
import 'package:clock_app/settings/types/setting_item.dart';
import 'package:clock_app/settings/types/setting_link.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SettingGroup extends SettingItem {
  final String _description;
  final IconData? _icon;
  final List<String> _summarySettings;
  final bool? _showExpandedView;
  final List<SettingItem> _settingItems;
  final List<Setting> _settings;
  final List<SettingGroup> _settingGroups;
  final bool _isSearchable;

  String get description => _description;
  IconData? get icon => _icon;
  List<String> get summarySettings => _summarySettings;
  bool? get showExpandedView => _showExpandedView;
  List<Setting> get settings => _settings;
  List<SettingGroup> get settingGroups => _settingGroups;
  List<SettingItem> get settingItems => _settingItems;
  bool get isSearchable => _isSearchable;

  SettingGroup(
    String name,
    this._settingItems, {
    IconData? icon,
    List<String> summarySettings = const [],
    String description = "",
    bool? showExpandedView,
    bool isSearchable = false,
  })  : _icon = icon,
        _description = description,
        _summarySettings = summarySettings,
        _showExpandedView = showExpandedView,
        _isSearchable = isSearchable,
        _settingGroups = [],
        _settings = [],
        super(name) {
    for (SettingItem item in _settingItems) {
      item.parent = this;
      if (item is Setting) {
        _settings.add(item);
      } else if (item is SettingGroup) {
        _settingGroups.add(item);
        _settingGroups.addAll(item.settingGroups);
        _settings.addAll(item.settings);
      }
    }

    for (Setting setting in _settings) {
      setting.changesEnableCondition = _settings.any((otherSetting) =>
          otherSetting.enableConditions
              .any((condition) => condition.settingName == setting.name));

      setting.enableSettings = setting.enableConditions.map((enableCondition) {
        return SettingEnableCondition(
            getSetting(enableCondition.settingName), enableCondition.value);
      }).toList();
    }
  }

  @override
  SettingGroup copy() {
    return SettingGroup(
      name,
      _settingItems.map((setting) => setting.copy()).toList(),
      icon: icon,
      summarySettings: _summarySettings,
      description: description,
    );
  }

  SettingGroup getGroup(String name) {
    return _settingGroups.firstWhere((item) => item.name == name);
  }

  Setting getSetting(String name) {
    try {
      return _settings.firstWhere((item) => item.name == name);
    } catch (e) {
      print("Could not find setting ${name}: ${e}");
      rethrow;
    }
  }

  void restoreDefault(
    BuildContext context,
    Map<String, bool> settingsToRestore,
  ) {
    for (var settingItem in _settingItems) {
      if (settingItem is SettingPageLink) {
        continue;
      }
      if (settingsToRestore.containsKey(settingItem.id)) {
        if (!settingsToRestore[settingItem.id]!) {
          continue;
        }
      }
      if (settingItem is Setting) {
        settingItem.restoreDefault(context);
      } else if (settingItem is SettingGroup) {
        settingItem.restoreDefault(context, settingsToRestore);
      }
    }
  }

  @override
  dynamic toJson() {
    Map<String, dynamic> json = {};
    for (var setting in _settingItems) {
      json[setting.name] = setting.toJson();
    }
    return json;
  }

  @override
  void fromJson(dynamic value) {
    for (var setting in _settingItems) {
      setting.fromJson(value[setting.name]);
    }
  }

  Future<void> save() {
    return GetStorage().write(id, json.encode(toJson()));
  }

  void load() {
    fromJson(json.decode(GetStorage().read(id)));
  }
}