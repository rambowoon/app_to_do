import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../generated/l10n.dart';

class NDSharedLanguage {
  /// Thiết lập Ngôn ngữ mặc định [en: English - vi: VietNam]
  final Iterable<LocalizationsDelegate<dynamic>>? localeDelegate = const [
    AppLocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  final Iterable<Locale> supportedLocales = const AppLocalizationDelegate().supportedLocales;
  final Locale? localeDefault = const Locale('vi');

/// Kết thúc : Thiết lập Ngôn ngữ mặc định [en: English - vi: VietNam]
}

/// Hàm sử dụng ngonngu làm alias cho AppLocalazation.of(context) để gọi các chuỗi ngôn ngữ
/// Cách sử dụng ${ngonngu(context).<key_ngon_ngu>
/// Mục đích để dễ nhớ và rút ngắn cú pháp khi sử dụng các biến ngôn ngữ
S ngonngu(BuildContext context) {
  return S.of(context);
}
