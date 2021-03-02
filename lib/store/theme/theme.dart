import 'package:flutter/material.dart';

enum ThemeTypes {
  DARK_LIGHT,
  YELLOW_DARK,
  GREEN_LIGHT,
  PURPLE_DARK,
}

class Themes {
  static ThemeData getTheme(ThemeTypes theme) {
    switch (theme) {
      case ThemeTypes.DARK_LIGHT:
        return Themes.darkLight;

      case ThemeTypes.YELLOW_DARK:
        return Themes.yellowDark;

      case ThemeTypes.GREEN_LIGHT:
        return Themes.greenLight;

      case ThemeTypes.PURPLE_DARK:
        return Themes.purpleDark;

      default:
        return Themes.defaultTheme;
    }
  }

  static String getThemeName(ThemeTypes theme) {
    switch (theme) {
      case ThemeTypes.DARK_LIGHT:
        return 'Dark[Light]';

      case ThemeTypes.YELLOW_DARK:
        return 'Yellow[Dark]';

      case ThemeTypes.GREEN_LIGHT:
        return 'Green[Light]';

      case ThemeTypes.PURPLE_DARK:
        return 'Purple[Dark]';

      default:
        return 'Default';
    }
  }

  static ThemeData get darkLight {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      backgroundColor: Colors.grey[100],
      accentColor: Colors.cyan[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.cyan[100],
    );
  }

  static ThemeData get yellowDark {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.yellow[800],
      backgroundColor: Colors.grey[800],
      accentColor: Colors.grey[800],
      buttonColor: Colors.yellow[800],
      textSelectionColor: Colors.cyan[100],
    );
  }

  static ThemeData get greenLight {
    return ThemeData.light().copyWith(
      primaryColor: const Color(0xFF022601),
      accentColor: const Color(0xFFBFBFBF),
      backgroundColor: Colors.green[900],
      buttonColor: const Color(0xFF99A66A),
      textSelectionColor: const Color(0xFFF2F2F2),
    );
  }

  static ThemeData get purpleDark {
    return ThemeData.dark().copyWith(
      primaryColor: const Color(0xFF222059),
      accentColor: const Color(0xFF22F2DD),
      backgroundColor: Colors.purple[100],
      buttonColor: const Color(0xFFA3A0F2),
      textSelectionColor: const Color(0xFFCFCEF2),
    );
  }

  static ThemeData get defaultTheme {
    return ThemeData.light().copyWith(
      primaryColor: Colors.grey[700],
      accentColor: Colors.white,
      backgroundColor: Colors.grey[100],
    );
  }
}
