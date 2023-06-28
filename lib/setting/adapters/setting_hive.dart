import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'setting_hive.g.dart';

@HiveType(typeId: 1)
class SettingHive extends HiveObject {
  @HiveField(0)
  @required
  String? themeMode;

  @HiveField(1)
  @required
  String? language;

  @HiveField(2)
  @required
  bool? splash;

  SettingHive({this.themeMode, this.language, this.splash});

  SettingHive copyWith({String? themeMode, String? language, bool? splash}){
    return SettingHive(themeMode: themeMode ?? this.themeMode, language: language ?? this.language, splash: splash ?? this.splash);
  }
}