import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const bool themeMaterial3 = true;
const ThemeMode themeModeDefault = ThemeMode.light;
// final String? themeFont = GoogleFonts.quicksand().fontFamily;

ThemeData get lightTheme {
  return FlexThemeData.light(
    scheme: FlexScheme.deepBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      useM2StyleDividerInM3: true,
      textButtonRadius: 0.0,
      filledButtonRadius: 0.0,
      elevatedButtonRadius: 0.0,
      outlinedButtonRadius: 0.0,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorRadius: 0.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedBorderWidth: 0.5,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}

ThemeData get darkTheme {
  return FlexThemeData.dark(
    scheme: FlexScheme.deepBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    bottomAppBarElevation: 0.0,
    subThemesData: const FlexSubThemesData(
      useM2StyleDividerInM3: true,
      textButtonRadius: 0.0,
      filledButtonRadius: 0.0,
      elevatedButtonRadius: 0.0,
      outlinedButtonRadius: 0.0,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorRadius: 0.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedBorderWidth: 0.5,
      appBarScrolledUnderElevation: 0.0,
    ),
    keyColors: const FlexKeyColors(),
    tones: FlexTones.material(Brightness.dark).onMainsUseBW().onSurfacesUseBW(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}
