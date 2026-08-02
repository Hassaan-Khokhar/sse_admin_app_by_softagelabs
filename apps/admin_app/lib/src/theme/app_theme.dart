import 'package:flutter/material.dart';

/// The app's visual system.
///
/// Design intent: this is a tool a principal opens every morning and keeps
/// open. It should read as calm, institutional and precise — closer to a
/// well-set ledger than to a consumer app. Restraint is the point: colour is
/// used to *locate* things, never to decorate.
///
/// Three rules everything else follows from:
///
///   * **One accent, many neutrals.** Deep navy carries identity and action.
///     Everything else is a neutral until it has a reason not to be.
///   * **Borders, not shadows.** Dense data screens with drop shadows look
///     muddy; a 1px hairline separates a card from its surface without adding
///     visual weight to every row.
///   * **Colour only where it means something.** The five accents below name
///     a metric; the five status colours name an attendance state. Nothing is
///     coloured because it looked plain.
abstract final class AppTheme {
  // ── brand ────────────────────────────────────────────────────────────────

  /// Deep navy. Institutional without being cold — a school, not a bank.
  static const navy = Color(0xFF1B3A6B);
  static const navyDark = Color(0xFF122A4F);
  static const navyLight = Color(0xFF2E5590);

  /// Warm off-white. A pure #FFF page glares under the fluorescent lighting
  /// of a school office; a hint of warmth is easier to sit in front of.
  static const canvas = Color(0xFFF7F7F5);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFF1F1EE);

  static const ink = Color(0xFF16191D);
  static const inkSecondary = Color(0xFF4B5259);
  static const inkMuted = Color(0xFF7C858E);
  static const hairline = Color(0xFFE3E3DF);

  // ── metric accents ───────────────────────────────────────────────────────

  /// Okabe–Ito, validated for colour-blind separation.
  ///
  /// Chosen by running the palette through a CVD validator, not by eye: the
  /// obvious blue/violet/cyan set fails badly — violet and blue differ by
  /// ΔE 0.4 under deuteranopia, which is to say not at all.
  ///
  /// Each is always paired with an icon and a text label, which is what makes
  /// the remaining ΔE 7.6 pair legitimate. Colour locates; the label names.
  static const accentBlue = Color(0xFF0072B2);
  static const accentAmber = Color(0xFFE69F00);
  static const accentGreen = Color(0xFF009E73);
  static const accentPink = Color(0xFFCC79A7);
  static const accentOrange = Color(0xFFD55E00);

  // ── attendance status ────────────────────────────────────────────────────

  /// Fixed by schema.sql §3 — a contract with the student app, not a choice.
  ///
  /// Known issue: `late` and `leave` sit ΔE 2.9 apart under deuteranopia and
  /// only 11.7 apart for normal vision. Both apps must therefore always pair
  /// them with a letter, never rely on the swatch alone.
  static const statusPresent = Color(0xFF16A34A);
  static const statusAbsent = Color(0xFFDC2626);
  static const statusLeave = Color(0xFFCA8A04);
  static const statusLate = Color(0xFFEA580C);
  static const statusHoliday = Color(0xFF6B7280);

  // ── navigation ───────────────────────────────────────────────────────────

  /// A hue per section of the app.
  ///
  /// Wider than the validated five-colour metric set, and that is fine here
  /// for a specific reason: in the rail, colour is **not** the identity
  /// carrier. Every item shows a distinct icon and its name in words, so a
  /// reader who cannot separate two hues loses nothing — they are reading the
  /// label. The colour is a landmark that makes "Fees is the orange one"
  /// learnable after a week of daily use.
  ///
  /// This is the opposite of the dashboard metric cards, where colour encodes
  /// which series a bar belongs to and therefore had to be validated.
  static const navDashboard = Color(0xFF1B3A6B);
  static const navClasses = Color(0xFF0E7490);
  static const navStudents = Color(0xFF0072B2);
  static const navFaculty = Color(0xFF009E73);
  static const navAttendance = Color(0xFF15803D);
  static const navMarks = Color(0xFF7C3AED);
  static const navFees = Color(0xFFD55E00);
  static const navTimetable = Color(0xFFB45309);
  static const navAssignments = Color(0xFFBE185D);
  static const navNotices = Color(0xFFC2410C);
  static const navLostFound = Color(0xFF475569);

  static const radius = 12.0;
  static const radiusSmall = 8.0;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: navy,
      surface: surface,
    ).copyWith(
      primary: navy,
      onPrimary: Colors.white,
      surface: surface,
      onSurface: ink,
      surfaceContainerLowest: surface,
      surfaceContainerLow: canvas,
      surfaceContainer: canvas,
      surfaceContainerHigh: surfaceMuted,
      surfaceContainerHighest: surfaceMuted,
      outlineVariant: hairline,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      dividerColor: hairline,
      splashFactory: InkSparkle.splashFactory,

      // Tighter than Material's default. These screens are tables of names and
      // numbers; the stock line height wastes a third of a laptop screen.
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
            fontSize: 26, fontWeight: FontWeight.w700, color: ink, height: 1.2),
        headlineSmall: TextStyle(
            fontSize: 21, fontWeight: FontWeight.w700, color: ink, height: 1.2),
        titleLarge: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: ink),
        titleMedium: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: ink),
        titleSmall: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w600, color: inkSecondary),
        bodyLarge: TextStyle(fontSize: 14.5, color: ink, height: 1.35),
        bodyMedium: TextStyle(fontSize: 13.5, color: inkSecondary, height: 1.35),
        bodySmall: TextStyle(fontSize: 12, color: inkMuted, height: 1.3),
        labelLarge:
            TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: ink),
      ),

      dividerTheme: const DividerThemeData(
        color: hairline,
        thickness: 1,
        space: 1,
      ),

      // Hairline borders instead of elevation — see the class doc.
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: hairline),
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        indicatorColor: navy.withValues(alpha: 0.10),
        selectedIconTheme: const IconThemeData(color: navy, size: 22),
        unselectedIconTheme: const IconThemeData(color: inkMuted, size: 22),
        selectedLabelTextStyle: const TextStyle(
            fontSize: 11.5, fontWeight: FontWeight.w600, color: navy),
        unselectedLabelTextStyle:
            const TextStyle(fontSize: 11.5, color: inkMuted),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle:
              const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          side: const BorderSide(color: hairline),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle:
              const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: navy,
          textStyle:
              const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: navy, width: 1.6),
        ),
        labelStyle: const TextStyle(fontSize: 13.5, color: inkMuted),
        hintStyle: const TextStyle(fontSize: 13.5, color: inkMuted),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceMuted,
        side: const BorderSide(color: hairline),
        labelStyle: const TextStyle(fontSize: 12, color: inkSecondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),

      tabBarTheme: const TabBarThemeData(
        labelColor: navy,
        unselectedLabelColor: inkMuted,
        indicatorColor: navy,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 13.5),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius + 2),
          side: const BorderSide(color: hairline),
        ),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: ink),
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
        titleTextStyle:
            TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: ink),
        subtitleTextStyle: TextStyle(fontSize: 12.5, color: inkMuted),
      ),

      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(fontSize: 13.5, color: ink),
      ),
    );
  }
}
