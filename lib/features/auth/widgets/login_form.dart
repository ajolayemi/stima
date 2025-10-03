import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/features/auth/pages/login_controller.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_constants.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/buttons/app_secondary_button.dart';
import 'package:stima/shared/widgets/buttons/app_text_button.dart';
import 'package:stima/shared/widgets/buttons/visibility_icon_button.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';
import 'package:stima/shared/widgets/or_with_widget.dart';
import 'package:stima/shared/widgets/progress/app_circular_loader.dart';
import 'package:stima/core/utils/extensions/app_form_errors_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/keyboard/app_keyboard_utils.dart';
import 'package:stima/core/utils/validators/app_form_validator_mixin.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm>
    with AppFormValidatorMixin {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  // * Form field controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // * Form field controllers value getters
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  // * Keys for eventual widget texts
  static const emailFieldKey = Key('loginForm_emailField');
  static const passwordFieldKey = Key('loginForm_passwordField');
  static const loginButtonKey = Key('loginForm_loginButton');

  bool _formSubmitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _unfocus() {
    _node.unfocus();
    AppKeyboardUtils.hideKeyboard();
  }

  void _toggleFormSubmitted(bool? value) {
    setState(() {
      _formSubmitted = value ?? !_formSubmitted;
    });
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email: _email)) {
      _node.nextFocus();
    }
  }

  String? _emailErrorText() {
    if (!_formSubmitted) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getEmailErrorKey(email: _email),
    );
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email: _email)) {
      _node.previousFocus();
      return;
    }

    if (canSubmitPassword(
      password: _password,
      minLength: AppConstants.minPasswordLength,
    )) {
      _unfocus();
      // _node.nextFocus();
      _login();
      return;
    }
  }

  String? _passwordErrorText() {
    if (!_formSubmitted) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getPasswordErrorKey(
        password: _password,
        minLength: AppConstants.minPasswordLength,
      ),
      minFieldLength: AppConstants.minPasswordLength,
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _passwordController.clear();
    _toggleFormSubmitted(false);
  }

  // TODO: [Kehinde] implement logic
  Future<void> _login() async {
    _toggleFormSubmitted(true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    _unfocus();
    await ref
        .read(loginControllerProvider.notifier)
        .loginWithEmailAndPassword(email: _email, password: _password);
  }

  // TODO: [Kehinde] implement logic
  Future<void> _loginWithGoogle() async {
    _unfocus();
    _resetForm();
    await ref.read(loginControllerProvider.notifier).loginWithGoogle();
  }

  // TODO: [Kehinde] implement logic
  Future<void> _forgotPassword() async {}

  void _onFormFieldChanged(String val) {
    ref.read(loginButtonEnabledProvider.notifier).toggle(_email, _password);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return GestureDetector(
      onTap: _node.unfocus,
      child: FocusScope(
        node: _node,
        child: Container(
          width: context.screenWidth,
          padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p24)),
          ),
          child: Column(
            children: [
              gapH48,

              Text(
                loc.login_screen_welcome_back,
                style: textTheme.headlineMedium,
              ),
              gapH8,

              Text(
                loc.login_screen_sign_in_to_continue,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              gapH12,

              Form(
                key: _formKey,
                autovalidateMode: _formSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH32,

                    // Email field
                    FormTitleAndField(
                      fieldKey: emailFieldKey,
                      fieldTitle: loc.login_screen_email,
                      fieldHintText: loc.login_screen_email_hint,
                      fieldController: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _emailEditingComplete,
                      validator: (_) => _emailErrorText(),
                      prefixIcon: Assets.icons.email.svg(fit: BoxFit.scaleDown),
                      enabled: !widget.isLoading,
                      onChanged: _onFormFieldChanged,
                    ),
                    gapH20,

                    // Password field
                    Consumer(
                      builder: (context, ref, child) {
                        final obscure = !ref.watch(loginShowPasswordProvider);
                        return FormTitleAndField(
                          fieldKey: passwordFieldKey,
                          fieldTitle: loc.login_screen_password,
                          fieldHintText: loc.login_screen_password_hint,
                          fieldController: _passwordController,
                          obscureText: obscure,
                          enabled: !widget.isLoading,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _passwordEditingComplete,
                          validator: (_) => _passwordErrorText(),
                          prefixIcon: Assets.icons.lock.svg(
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: VisibilityIconButton(
                            isVisible: !obscure,
                            onPressed: () {
                              ref
                                  .read(loginShowPasswordProvider.notifier)
                                  .toggle();
                            },
                          ),
                          onChanged: _onFormFieldChanged,
                        );
                      },
                    ),
                  ],
                ),
              ),

              gapH12,
              Consumer(
                builder: (context, ref, child) {
                  final btnEnabled = ref.watch(loginButtonEnabledProvider);
                  return _LoginFormButtonSection(
                    isLoading: widget.isLoading,
                    loginButtonEnabled: btnEnabled,
                    onForgotPasswordPressed: _forgotPassword,
                    onLoginPressed: _login,
                    onLoginWithGooglePressed: _loginWithGoogle,
                    loginButtonKey: loginButtonKey,
                  );
                },
              ),

              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginFormButtonSection extends StatelessWidget {
  const _LoginFormButtonSection({
    this.isLoading = false,
    this.loginButtonEnabled = false,
    this.onForgotPasswordPressed,
    this.onLoginPressed,
    this.onLoginWithGooglePressed,
    this.loginButtonKey,
  });

  final bool isLoading;
  final bool loginButtonEnabled;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onLoginWithGooglePressed;
  final Key? loginButtonKey;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return isLoading
        ? const AppCircularLoader()
        : Column(
            children: [
              // Forgot password button
              Align(
                alignment: Alignment.bottomRight,
                child: AppTextButton(
                  label: loc.login_screen_forgot_password,
                  onPressed: onForgotPasswordPressed,
                ),
              ),

              gapH12,

              // Submit button
              AppPrimaryButton(
                label: loc.login_screen_sign_in_btn,
                onPressed: loginButtonEnabled ? onLoginPressed : null,
                key: loginButtonKey,
              ),

              gapH32,

              OrWithWidget(orText: loc.login_screen_continue_with),

              gapH32,

              AppSecondaryButton(
                label: loc.login_screen_login_with_google,
                onPressed: onLoginWithGooglePressed,
                icon: Assets.icons.google.svg(fit: BoxFit.scaleDown),
              ),
            ],
          );
  }
}
