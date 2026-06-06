import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/app_form_errors_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/validators/app_form_mixin.dart';
import 'package:stima/features/companies/providers/company_form_providers.dart';
import 'package:stima/features/companies/utils/company_utils.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/form/form_stepper_indicator.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class AddNewCompanyStepOnePage extends ConsumerStatefulWidget {
  const AddNewCompanyStepOnePage({super.key});

  @override
  ConsumerState<AddNewCompanyStepOnePage> createState() =>
      _AddNewCompanyStepOnePageState();
}

class _AddNewCompanyStepOnePageState
    extends ConsumerState<AddNewCompanyStepOnePage>
    with AppFormMixin {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  // * Form field controllers
  final _companyNameController = TextEditingController();
  final _contactPersonNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  // * Form fields value getter
  String get _companyName => _companyNameController.text;
  String get _contactPersonName => _contactPersonNameController.text;
  String get _phoneNumber => _phoneNumberController.text;
  String get _email => _emailController.text;
  String get _address => _addressController.text;

  // * Keys for eventual testing
  static const companyNameFieldKey = Key('newCompany_nameField');
  static const contactPersonNameFieldKey = Key(
    'newCompany_contactPersonNameField',
  );
  static const phoneNumberFieldKey = Key('newCompany_phoneNumberField');
  static const emailFieldKey = Key('newCompany_emailField');
  static const addressFieldKey = Key('newCompany_addressField');

  bool _formSubmitted = false;

  @override
  void dispose() {
    _node.dispose();
    _companyNameController.dispose();
    _contactPersonNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
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

  String? _nonEmptyFieldsErrorText(String? value) {
    if (!_formSubmitted) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value ?? ''),
    );
  }

  void _emailEditingComplete() {
    if (_email.isEmpty) {
      _node.nextFocus();
      return;
    }

    if (canSubmitEmail(email: _email)) {
      _node.nextFocus();
    }
  }

  String? _emailErrorText() {
    if (!_formSubmitted || _email.isEmpty) return null;
    return context.getLocalizedFormErrorText(
      errorKey: getEmailErrorKey(email: _email),
    );
  }

  void _continueToNextStep() {
    _toggleFormSubmitted(true);
    // Validate the form
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    unfocus(_node);
    // Update the form data in the provider
    ref
        .read(companyFormDataProvider.notifier)
        .updateGeneralInfo(
          companyName: _companyName,
          contactPersonName: _contactPersonName,
          phoneNumber: _phoneNumber,
          email: _email,
          address: _address,
        );
    context.pushNamed(AppRoute.addCompanyStepTwo.name);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.screenBottomPadding;
    final loc = context.loc;
    return AppScaffold(
      hasAppBar: true,
      appBarActionWidgets: [
        IconButton(
          onPressed: () {
            CompanyUtils.confirmFormExit(
              context: context,
              onConfirmed: context.pop,
              ref: ref,
            );
          },
          icon: Padding(
            padding: const EdgeInsets.only(right: AppSizes.p12),
            child: Assets.icons.close.svg(fit: BoxFit.scaleDown),
          ),
        ),
      ],
      appBarTitle: Text(loc.add_new_company_page_title),
      body: PaddedSafeArea(
        padding: EdgeInsets.only(left: AppSizes.p16, right: AppSizes.p16),
        child: GestureDetector(
          onTap: () => unfocus(_node),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ResponsiveScrollable(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppSizes.gapH24,
                      FormStepperIndicator(totalSteps: 2, currentStep: 1),
                      AppSizes.gapH24,
                      FocusScope(
                        node: _node,
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _formSubmitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: AppSizes.p20,
                            children: [
                              // Company name field
                              FormTitleAndField(
                                fieldKey: companyNameFieldKey,
                                fieldController: _companyNameController,
                                inputDecorationFillColor: AppColors.gray200
                                    .withValues(alpha: 0.5),
                                fieldTitle:
                                    loc.add_new_company_form_name_field_title,
                                fieldHintText:
                                    loc.add_new_company_form_name_field_hint,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  return _nonEmptyFieldsEditingComplete(
                                    _companyName,
                                  );
                                },
                                validator: _nonEmptyFieldsErrorText,
                              ),

                              // Contact person's field
                              FormTitleAndField(
                                fieldKey: contactPersonNameFieldKey,
                                fieldController: _contactPersonNameController,
                                inputDecorationFillColor: AppColors.gray200
                                    .withValues(alpha: 0.5),
                                fieldTitle: loc
                                    .add_new_company_form_contact_person_field_title,
                                fieldHintText: loc
                                    .add_new_company_form_contact_person_field_hint,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  _nonEmptyFieldsEditingComplete(
                                    _contactPersonName,
                                  );
                                },
                                validator: _nonEmptyFieldsErrorText,
                              ),

                              // Phone number field
                              FormTitleAndField(
                                fieldKey: phoneNumberFieldKey,
                                fieldController: _phoneNumberController,
                                inputDecorationFillColor: AppColors.gray200
                                    .withValues(alpha: 0.5),
                                fieldTitle: loc
                                    .add_new_company_form_phone_number_field_title,
                                fieldHintText: loc
                                    .add_new_company_form_phone_number_field_hint,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  return _nonEmptyFieldsEditingComplete(
                                    _phoneNumber,
                                  );
                                },
                                validator: _nonEmptyFieldsErrorText,
                              ),

                              // Email field
                              FormTitleAndField(
                                fieldKey: emailFieldKey,
                                fieldController: _emailController,
                                inputDecorationFillColor: AppColors.gray200
                                    .withValues(alpha: 0.5),
                                fieldTitle:
                                    loc.add_new_company_form_email_field_title,
                                fieldHintText:
                                    loc.add_new_company_form_email_field_hint,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: _emailEditingComplete,
                                validator: (_) => _emailErrorText(),
                              ),

                              // Address field
                              FormTitleAndField(
                                fieldKey: addressFieldKey,
                                fieldController: _addressController,
                                inputDecorationFillColor: AppColors.gray200
                                    .withValues(alpha: 0.5),
                                fieldTitle: loc
                                    .add_new_company_form_address_field_title,
                                fieldHintText:
                                    loc.add_new_company_form_address_field_hint,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: _continueToNextStep,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSizes.gapH24,
              AppPrimaryButton(
                label: loc.continue_cta_button,
                onPressed: _continueToNextStep,
              ),
              SizedBox(height: bottomPadding + AppSizes.p16),
            ],
          ),
        ),
      ),
    );
  }
}
