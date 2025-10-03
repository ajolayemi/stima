import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/app_form_errors_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/keyboard/app_keyboard_utils.dart';
import 'package:stima/core/utils/validators/app_form_validator_mixin.dart';
import 'package:stima/features/auth/pages/registration_controller.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/features/auth/widgets/auth_form_buttons_section.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_constants.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/buttons/visibility_icon_button.dart';
import 'package:stima/shared/widgets/form/auth_form_card.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  const RegistrationForm({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm>
    with AppFormValidatorMixin {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  // * Form field controllers
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // * Form field controllers value getters
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;
  String get _name => _nameController.text;
  String get _surname => _surnameController.text;

  // * Keys for eventual widget texts
  static const emailFieldKey = Key('register_email_field');
  static const passwordFieldKey = Key('register_password_field');
  static const confirmPasswordFieldKey = Key('register_confirm_password_field');
  static const nameFieldKey = Key('register_name_field');
  static const surnameFieldKey = Key('register_surname_field');
  static const submitButtonKey = Key('register_submit_button');

  bool _formSubmitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
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

  void _nonEmptyFieldsEditingComplete(String value) {
    if (canSubmitNonEmptyFields(value: value)) {
      _node.nextFocus();
    }
  }

  String? _nonEmptyFieldsErrorText(String value) {
    if (!_formSubmitted) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value),
    );
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
    if (canSubmitPassword(
      password: _password,
      minLength: AppConstants.minPasswordLength,
    )) {
      _unfocus();
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
      _unfocus();
      _register();
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

  void _resetForm() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _nameController.clear();
    _surnameController.clear();
    _toggleFormSubmitted(false);
  }

  Future<void> _register() async {
    _toggleFormSubmitted(true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    _unfocus();
    await ref
        .read(registrationControllerProvider.notifier)
        .registerWithEmailAndPassword(email: _email, password: _password);
  }

  Future<void> _registerWithGoogle() async {
    _unfocus();
    _resetForm();
    await ref
        .read(registrationControllerProvider.notifier)
        .registerWithGoogle();
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
                    gapH32,

                    // Name field
                    FormTitleAndField(
                      fieldKey: nameFieldKey,
                      fieldTitle: loc.registration_form_name_field_title,
                      fieldHintText: loc.registration_form_name_field_hint,
                      fieldController: _nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onEditingComplete: () {
                        _nonEmptyFieldsEditingComplete(_name);
                      },
                      validator: (val) => _nonEmptyFieldsErrorText(val ?? ''),
                      enabled: !widget.isLoading,
                      prefixIcon: Assets.icons.person.svg(
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    gapH20,

                    // Surname field
                    FormTitleAndField(
                      fieldKey: surnameFieldKey,
                      fieldTitle: loc.registration_form_surname_field_title,
                      fieldHintText: loc.registration_form_surname_field_hint,
                      fieldController: _surnameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onEditingComplete: () {
                        _nonEmptyFieldsEditingComplete(_surname);
                      },
                      validator: (val) => _nonEmptyFieldsErrorText(val ?? ''),
                      enabled: !widget.isLoading,
                      prefixIcon: Assets.icons.person.svg(
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    gapH20,

                    // Email field
                    FormTitleAndField(
                      fieldKey: emailFieldKey,
                      fieldTitle: loc.registration_form_email_field_title,
                      fieldHintText: loc.registration_form_email_field_hint,
                      fieldController: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: _emailEditingComplete,
                      validator: (_) => _emailErrorText(),
                      enabled: !widget.isLoading,
                      prefixIcon: Assets.icons.email.svg(fit: BoxFit.scaleDown),
                    ),
                    gapH20,

                    // Password field
                    Consumer(
                      builder: (context, ref, child) {
                        final obscure = !ref.watch(
                          registrationShowPasswordProvider,
                        );
                        return FormTitleAndField(
                          fieldKey: passwordFieldKey,
                          fieldTitle:
                              loc.registration_form_password_field_title,
                          fieldHintText:
                              loc.registration_form_password_field_hint,
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
                              ref
                                  .read(
                                    registrationShowPasswordProvider.notifier,
                                  )
                                  .toggle();
                            },
                          ),
                        );
                      },
                    ),
                    gapH8,
                    // Password suggestion text
                    Text(
                      loc.registration_form_password_field_suggestion(
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
                        final obscure = !ref.watch(
                          registrationShowConfirmPasswordProvider,
                        );
                        return FormTitleAndField(
                          fieldKey: confirmPasswordFieldKey,
                          fieldTitle: loc
                              .registration_form_confirm_password_field_title,
                          fieldHintText:
                              loc.registration_form_confirm_password_field_hint,
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
                                  .read(
                                    registrationShowConfirmPasswordProvider
                                        .notifier,
                                  )
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
              Consumer(
                builder: (context, ref, child) {
                  return AuthFormButtonsSection(
                    orWithText: loc.registration_page_continue_with,
                    authCtaKey: submitButtonKey,
                    authButtonLabel: loc.registration_form_submit_btn,
                    authButtonEnabled: true,
                    onAuthButtonPressed: _register,
                    isLoading: widget.isLoading,
                    authWithGoogleLabel:
                        loc.registration_page_register_with_google,
                    onAuthWithGooglePressed: _registerWithGoogle,
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
