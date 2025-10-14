/// All supported routes in the application.
enum AppRoute {
  splashScreen('/'),
  login('/log-in'),
  forgotPassword('forgot-password'),
  forgotPasswordSuccess('success/:email'),
  resetPassword('reset-password/:code'),
  resetPasswordSuccess('resetSuccess'),
  register('/register'),
  home('/home'),
  draftSurvey('/draft-survey'),
  companies('/companies'),
  addCompanyStepOne('/companies/new/step-1'),
  addCompanyStepTwo('/companies/new/step-2'),
  updateCompany('update/:id'),
  profile('/profile');

  /// The path associated with the route.
  final String path;

  const AppRoute(this.path);
}
