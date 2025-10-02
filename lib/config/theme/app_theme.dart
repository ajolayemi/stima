import 'package:flutter/material.dart';

/// 🎨 Centralized Color Palette
class AppColors {
  // Primary
  static const green50 = Color(0xFFF0FDF4);
  static const green100 = Color(0xFFDCFCE7);
  static const green600 = Color(0xFF16A34A);
  static const green700 = Color(0xFF15803D);

  // Neutral
  static const white = Color(0xFFFFFFFF);
  static const gray50 = Color(0xFFF9FAFB);
  static const gray100 = Color(0xFFF3F4F6);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray400 = Color(0xFF9CA3AF);
  static const gray500 = Color(0xFF6B7280);
  static const gray600 = Color(0xFF4B5563);
  static const gray700 = Color(0xFF374151);
  static const gray900 = Color(0xFF111827);
  static const black = Color(0xFF000000);

  // Semantic
  static const red600 = Color(0xFFDC2626);
  static const red700 = Color(0xFFB91C1C);
  static const orange100 = Color(0xFFFFEDD5);
  static const orange700 = Color(0xFFC2410C);
  static const blue600 = Color(0xFF2563EB);
  static const blue700 = Color(0xFF1D4ED8);

  // Backgrounds
  static const backgroundPage = gray50;
  static const backgroundCard = white;
  static const backgroundInput = gray50;

  // Text
  static const textPrimary = gray900;
  static const textSecondary = gray500;
  static const textTertiary = gray400;
  static const textInverse = white;
  static const textLink = green600;
}

/// 🔠 Text Styles (Typography)
class AppTextStyles {
  static const h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  static const h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  static const h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  static const h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
  );
  static const small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textSecondary,
  );
  static const tiny = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textTertiary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const input = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}

/// 📏 Spacing Tokens
class AppSpacing {
  static const xxs = 4.0; // 0.25rem
  static const xs = 8.0; // 0.5rem
  static const sm = 12.0; // 0.75rem
  static const md = 16.0; // 1rem
  static const lg = 20.0; // 1.25rem
  static const xl = 24.0; // 1.5rem
  static const xxl = 32.0; // 2rem
  static const xxxl = 48.0; // 3rem
}

/// ⬜ Border Radius Tokens
class AppRadius {
  static const sm = 6.0;
  static const md = 8.0;
  static const lg = 10.0;
  static const xl = 12.0;
  static const xxl = 16.0;
  static const xxxl = 24.0;
  static const full = 9999.0;
}

/// 🌿 Full Theme
class AppTheme {
  static ThemeData dark = ThemeData.dark();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: "Roboto",
    scaffoldBackgroundColor: AppColors.backgroundPage,
    colorScheme: const ColorScheme.light(
      primary: AppColors.green600,
      onPrimary: AppColors.white,
      secondary: AppColors.blue600,
      onSecondary: AppColors.white,
      error: AppColors.red600,
      // background: AppColors.backgroundPage,
      surface: AppColors.white,
      // onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: AppColors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.small,
      bodySmall: AppTextStyles.tiny,
      labelLarge: AppTextStyles.label,
      titleLarge: AppTextStyles.h2,
      titleMedium: AppTextStyles.h3,
      titleSmall: AppTextStyles.h4,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      titleTextStyle: AppTextStyles.h2,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green600,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.button,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.xl)),
        ),
        shadowColor: AppColors.green600.withValues(alpha: 0.2),
        elevation: 4,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.green600,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.button,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.xl)),
        ),
        shadowColor: AppColors.green600.withValues(alpha: 0.2),
        elevation: 4,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.gray200),
        minimumSize: const Size.fromHeight(48),
        textStyle: AppTextStyles.label,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.xl)),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundInput,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        borderSide: const BorderSide(color: AppColors.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        borderSide: const BorderSide(color: AppColors.gray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        borderSide: const BorderSide(color: AppColors.green600, width: 2),
      ),
      hintStyle: const TextStyle(color: AppColors.textTertiary),
    ),

    // cardTheme: CardTheme(
    //   color: AppColors.white,
    //   margin: const EdgeInsets.all(AppSpacing.sm),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(AppRadius.xxxl),
    //     side: const BorderSide(color: AppColors.gray100),
    //   ),
    //   elevation: 2,
    //   shadowColor: Colors.black.withOpacity(0.1),
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.green600,
      unselectedItemColor: AppColors.gray500,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.green600,
      foregroundColor: AppColors.white,
      shape: CircleBorder(),
      elevation: 6,
    ),
  );
}
