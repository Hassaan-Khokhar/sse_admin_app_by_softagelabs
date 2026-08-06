/// Supabase connection details, shared by BOTH apps.
///
/// Lives in school_core rather than in each app because the two devs share one
/// Supabase project (CLAUDE.md §13). Duplicating the URL in two repos in two
/// cities is how one app quietly ends up talking to a different project.
library;

/// Connection details for the school's Supabase project.
abstract final class SupabaseConfig {
  /// Project `sse_portal`, org `softageOrg`.
  ///
  /// Region is Northeast Asia (Tokyo, ap-northeast-1). A Supabase project's
  /// region cannot be changed after creation — moving means a new project and
  /// a data migration. Barely matters here, since the apps are offline-first
  /// and sync runs in the background, but see the note in CLAUDE.md.
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://brpcgilckqduuoykiwig.supabase.co',
  );

  /// The PUBLISHABLE key.
  ///
  /// Hardcoded on purpose, and safe. This key is *designed* to be public: it
  /// ships inside the .exe and the .apk no matter how it gets there, and
  /// anyone can extract it in about 30 seconds. Hiding it in a .env bundled as
  /// an asset, or behind --dart-define, buys exactly nothing — the compiled
  /// binary contains the string either way.
  ///
  /// What actually protects the database is RLS (schema.sql §9). Without RLS
  /// this key reads every student's marks; with RLS it can only reach what the
  /// signed-in user is entitled to.
  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_t-8uX6YDIR9wyutvjcO2SA__G5XSO-V',
  );

  // ==========================================================================
  //  🚨 THE SECRET KEY IS NOT HERE, AND MUST NEVER BE
  // ==========================================================================
  //
  //  `sb_secret_...` is a different animal from the publishable key above.
  //  It BYPASSES EVERY RLS POLICY.
  //
  //  The publishable key is safe to compile in precisely BECAUSE it is
  //  powerless on its own. That property does not transfer. A secret key in a
  //  Dart const gets compiled into every student's phone, and at that point
  //  any student with the .apk can read and rewrite every other student's
  //  marks and fees — the entire security model of this project, gone.
  //
  //  For a one-off server-side script, pass it in the shell for that command
  //  only. Never in source, never in a file git can see.
  // ==========================================================================

  /// Whether both values have actually been filled in.
  ///
  /// Guards against shipping a placeholder — a wrong URL fails at runtime with
  /// a confusing DNS error rather than an obvious one.
  static bool get isConfigured =>
      !url.contains('YOUR_PROJECT_REF') && publishableKey.startsWith('sb_');
}
