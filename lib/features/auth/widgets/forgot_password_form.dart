import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/models/path_parameters.dart';
import 'package:stima/core/utils/extensions/app_form_errors_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/validators/app_form_mixin.dart';
import 'package:stima/features/auth/controller/forgot_password_controller.dart';
import 'package:stima/features/auth/widgets/auth_form_buttons_section.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/form/auth_form_card.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends ConsumerState<ForgotPasswordForm>
    with AppFormMixin {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  // * Form field controllers
  final _emailController = TextEditingController();

  // * Form field controllers value getters
  String get _email => _emailController.text;

  // * Keys for eventual widget tests
  static const emailFieldKey = Key('forgot_password_email_field');

  bool _formSubmitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email: _email)) {
      _sendPasswordRecoveryMail();
    }
  }

  String? _emailErrorText() {
    if (!_formSubmitted) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getEmailErrorKey(email: _email),
    );
  }

  void _toggleFormSubmitted(bool? value) {
    setState(() {
      _formSubmitted = value ?? !_formSubmitted;
    });
  }

  Future<void> _sendPasswordRecoveryMail() async {
    _toggleFormSubmitted(true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    unfocus(_node);
    final emailSent = await ref
        .read(forgotPasswordControllerProvider.notifier)
        .sendPasswordRecoveryMail(_email);

    if (emailSent && mounted) {
      context.goNamed(
        AppRoute.forgotPasswordSuccess.name,
        pathParameters: PathParameters(email: _email).toJson(),
      );
      _formKey.currentState?.reset();
      _emailController.clear();
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
          child: Form(
            key: _formKey,
            autovalidateMode: _formSubmitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                gapH12,

                Text(
                  loc.forgot_password_email_form_header,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                gapH12,
                // Email field
                FormTitleAndField(
                  fieldKey: emailFieldKey,
                  fieldTitle: loc.forgot_password_email_form_mail_field_title,
                  fieldHintText: loc.forgot_password_email_form_mail_field_hint,
                  fieldController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _emailEditingComplete,
                  validator: (_) => _emailErrorText(),
                  prefixIcon: Assets.icons.email.svg(fit: BoxFit.scaleDown),
                  enabled: !widget.isLoading,
                ),
                gapH20,
                AuthFormButtonsSection(
                  isLoading: widget.isLoading,
                  onAuthButtonPressed: _sendPasswordRecoveryMail,
                  authButtonLabel: loc.forgot_password_email_page_continue_btn,
                  authButtonEnabled: true,
                ),

                gapH32,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
