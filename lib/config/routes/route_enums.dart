/// All supported routes in the application.
enum AppRoute {
  login('/log-in'),
  register('/register'),
  home('/home');

  /// The path associated with the route.
  final String path;

  const AppRoute(this.path);
}
