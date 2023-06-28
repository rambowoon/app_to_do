import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_init.dart';

class SettingNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return changeThemeMode(AppInit.settingHive.themeMode);
  }

  changeThemeMode(String? mode){
    ThemeMode themeMode;
    switch(mode){
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
    state = themeMode;
    AppInit.update(data: AppInit.settingHive.copyWith(themeMode: mode));
    return themeMode;
  }
}
class LanguageNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return changeLanguage(AppInit.settingHive.language);
  }

  changeLanguage(String? lang){
    Locale langMode;
    switch(lang){
      case 'vi':
        langMode = Locale('vi');
        break;
      case 'en':
        langMode = Locale('en');
        break;
      default:
        langMode = Locale('vi');
        break;
    }
    state = langMode;
    AppInit.update(data: AppInit.settingHive.copyWith(language: lang));
    return langMode;
  }
}

class SplashNotifier extends Notifier<bool> {
  @override
  bool build() {
    return AppInit.settingHive.splash!;
  }

  changeSplash(bool? splash){
    state = splash!;
    AppInit.update(data: AppInit.settingHive.copyWith(splash: splash));
    return splash;
  }
}