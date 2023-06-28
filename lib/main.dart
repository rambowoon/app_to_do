import 'package:app_to_do/scaffold_with_nav_bar.dart';
import 'setting/adapters/setting_hive.dart';
import 'setting/providers/setting_provider.dart';
import 'setting_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import 'app_init.dart';
import 'app_theme.dart';
import 'home/adapters/todo_hive.dart';
import 'home/home_screen.dart';

Future main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(SettingHiveAdapter());
  Hive.registerAdapter(TodoHiveAdapter());
  await Hive.openBox<SettingHive>('setting');
  await Hive.openBox<TodoHive>('todo');
  await AppInit.settup();
  runApp(ProviderScope(child: MyApp()));
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return HomeScreen();
          },
        )
      ],
    )
  ],
);

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingProvider);
    final languageMode = ref.watch(languageProvider);
    return MaterialApp.router(
      title: 'ToDo Tasks',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      localizationsDelegates: NDSharedLanguage().localeDelegate,
      supportedLocales: NDSharedLanguage().supportedLocales,
      locale: languageMode,
      routerConfig: _router,
    );
  }
}