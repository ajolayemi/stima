// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppStartupResult {
  final bool startupCompleted;
  final bool updateRequired;
  final String? androidPackageName;
  const AppStartupResult({
    required this.startupCompleted,
    required this.updateRequired,
    this.androidPackageName,
  });
}
