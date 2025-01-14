import 'package:clock_app/settings/types/setting.dart';
import 'package:clock_app/settings/types/setting_group.dart';

abstract class SettingItem {
  String name;
  String description;
  String id;
  SettingGroup? _parent;
  final List<void Function(dynamic)> _settingListeners;
  List<void Function(dynamic)> get settingListeners => _settingListeners;
  List<String> searchTags = [];

  SettingGroup? get parent => _parent;
  set parent(SettingGroup? parent) {
    _parent = parent;
    id = "${_parent?.id}/$name";
  }

  List<SettingGroup> get path {
    List<SettingGroup> path = [];
    SettingGroup? currentParent = parent;
    while (currentParent != null) {
      path.add(currentParent);
      currentParent = currentParent.parent;
    }
    return path.reversed.toList();
  }

  SettingItem(this.name, this.description, this.searchTags)
      : id = name,
        _settingListeners = [];

  SettingItem copy();

  dynamic valueToJson();

  void loadValueFromJson(dynamic value);

  void addListener(void Function(dynamic) listener) {
    _settingListeners.add(listener);
  }

  void removeListener(void Function(dynamic) listener) {
    _settingListeners.remove(listener);
  }

  void callListeners(Setting setting) {
    for (var listener in _settingListeners) {
      listener(setting.value);
    }
    parent?.callListeners(setting);
  }
}
