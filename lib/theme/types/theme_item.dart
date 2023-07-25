import 'package:clock_app/common/types/list_item.dart';
import 'package:clock_app/settings/types/setting_group.dart';
import 'package:flutter/material.dart';

abstract class ThemeItem extends ListItem {
  final int _id;
  final SettingGroup _settings;
  final bool _isDefault;

  ThemeItem(SettingGroup defaultSettings, bool isDefault, [int? id])
      : _id = id ?? UniqueKey().hashCode,
        _settings = defaultSettings,
        _isDefault = isDefault;

  ThemeItem.from(ThemeItem themeItem)
      : _id = UniqueKey().hashCode,
        _isDefault = false,
        _settings = themeItem.settings.copy();

  @override
  int get id => _id;
  SettingGroup get settings => _settings;
  bool get isDefault => _isDefault;
  String get name;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isDefault': isDefault,
      'settings': settings.toJson(),
    };
  }

  ThemeItem.fromJson(Map<String, dynamic> json, SettingGroup settings)
      : _id = json['id'],
        _isDefault = json['isDefault'],
        _settings = settings {
    settings.fromJson(json['settings']);
  }
}