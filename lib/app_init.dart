import 'setting/adapters/setting_hive.dart';
import 'package:hive_flutter/adapters.dart';

class AppInit{
  static late final Box<SettingHive> _box;
  static late SettingHive settingHive;

  static settup() async {
    _box = await Hive.openBox('setting');
    if(_box.isEmpty){
      settingHive = SettingHive(themeMode: 'light', language: 'vi', splash: true);
      _box.add(settingHive);
    }else{
      settingHive = _box.getAt(0)!;
    }
  }

  static update({SettingHive? data}){
    _box.putAt(0, data!);
  }
}