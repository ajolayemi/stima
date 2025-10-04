import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/models/path_parameters.dart';
import 'package:stima/core/utils/extensions/app_form_errors_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/validators/app_form_mixin.dart';
import 'package:stima/features/auth/controller/new_password_controller.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/features/auth/widgets/auth_form_buttons_section.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_constants.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/buttons/visibility_icon_button.dart';
import 'package:stima/shared/widgets/form/auth_form_card.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';

class ResetPasswordForm extends ConsumerStatefulWidget {
  const ResetPasswordForm({
    super.key,
    required this.confirmationCode,
    this.isLoading = false,
  });

  final bool isLoading;
  final String confirmationCode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm>
    with AppFormMixin {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  // * Form field controllers
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // * Form field controllers value getters
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;

  // * Keys for eventual widget texts
  static const passwordFieldKey = Key('reset_password_field');
  static const confirmPasswordFieldKey = Key('reset_confirm_password_field');
  static const submitButtonKey = Key('reset_submit_button');

  bool _formSubmitted = false;

  @override
  void dispose() {
    _node.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleFormSubmitted(bool? value) {
    setState(() {
      _formSubmitted = value ?? !_formSubmitted;
    });
  }

  void _passwordEditingComplete() {
    if (canSubmitPassword(
      password: _password,
      minLength: AppConstants.minPasswordLength,
    )) {
      _node.nextFocus();
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

  void _passwordConfirmEditingComplete() {
    if (doFieldsMatch(value1: _password, value2: _confirmPassword)) {
      unfocus(_node);
      _resetPassword();
    }
  }

  String? _confirmPasswordErrorText() {
    if (!_formSubmitted) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getPasswordFieldsErrorKey(
        password: _password,
        confirmPassword: _confirmPassword,
      ),
    );
  }

  Future<void> _resetPassword() async {
    _toggleFormSubmitted(true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    unfocus(_node);
    final reset = await ref
        .read(newPasswordControllerProvider.notifier)
        .createNewPassword(
          newPassword: _password,
          confirmationCode: widget.confirmationCode,
        );
    if (reset && mounted) {
      context.pushReplacementNamed(
        AppRoute.resetPasswordSuccess.name,
        pathParameters: PathParameters(
          passwordResetConfirmationCode: widget.confirmationCode,
        ).toJson(),
      );
      _formKey.currentState?.reset();
      _toggleFormSubmitted(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return GestureDetector(
      onTap: _node.unfocus,
      child: FocusScope(
        node: _node,
        child: AuthFormCard(
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: _formSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH12,

                    // Password field
                    Consumer(
                      builder: (context, ref, child) {
                        final obscure = !ref.watch(showPasswordProvider);
                        return FormTitleAndField(
                          fieldKey: passwordFieldKey,
                          fieldTitle: loc
                              .forgot_password_reset_page_new_password_field_title,
                          fieldHintText: loc
                              .forgot_password_reset_page_new_password_field_hint,
                          fieldController: _passwordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onEditingComplete: _passwordEditingComplete,
                          obscureText: obscure,
                          validator: (_) => _passwordErrorText(),
                          prefixIcon: Assets.icons.lock.svg(
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: VisibilityIconButton(
                            isVisible: !obscure,
                            onPressed: () {
                              ref.read(showPasswordProvider.notifier).toggle();
                            },
                          ),
                        );
                      },
                    ),
                    gapH8,
                    // Password suggestion text
                    Text(
                      loc.forgot_password_reset_page_field_suggestion(
                        AppConstants.minPasswordLength,
                      ),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    // Confirm password field
                    gapH20,
                    Consumer(
                      builder: (context, ref, child) {
                        final obscure = !ref.watch(showConfirmPasswordProvider);
                        return FormTitleAndField(
                          fieldKey: confirmPasswordFieldKey,
                          fieldTitle: loc
                              .forgot_password_reset_page_confirm_new_password_field_title,
                          fieldHintText: loc
                              .forgot_password_reset_page_confirm_new_password_field_hint,
                          fieldController: _confirmPasswordController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onEditingComplete: _passwordConfirmEditingComplete,
                          validator: (_) => _confirmPasswordErrorText(),
                          enabled: !widget.isLoading,
                          obscureText: obscure,
                          prefixIcon: Assets.icons.lock.svg(
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: VisibilityIconButton(
                            isVisible: !obscure,
                            onPressed: () {
                              ref
                                  .read(showConfirmPasswordProvider.notifier)
                                  .toggle();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              gapH12,

              AuthFormButtonsSection(
                authCtaKey: submitButtonKey,
                authButtonLabel: loc
                    .forgot_password_reset_page_new_password_reset_password_btn,
                authButtonEnabled: true,
                onAuthButtonPressed: _resetPassword,
                isLoading: widget.isLoading,
              ),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
