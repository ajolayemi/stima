import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class CompaniesListPage extends StatefulWidget {
  const CompaniesListPage({super.key});

  @override
  State<CompaniesListPage> createState() => _CompaniesListPageState();
}

class _CompaniesListPageState extends State<CompaniesListPage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  String get _searchValue => _searchController.text;

  static const _searchFieldKey = Key('companiesList_searchField');

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return AppScaffold(
      canPop: AppUtils.pageCanPop(context),
      hasAppBar: true,
      hasFAB: true,
      onFABPressed: () => context.pushNamed(AppRoute.addCompanyStepOne.name),
      appBarTitle: Text(loc.companies_list_page_title),
      body: PaddedSafeArea(
        padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
        child: ResponsiveScrollable(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapH24,
              Form(
                key: _formKey,
                child: FormTitleAndField(
                  fieldKey: _searchFieldKey,
                  prefixIcon: Assets.icons.search.svg(fit: BoxFit.scaleDown),
                  fieldHintText: loc.companies_list_page_search_field_hint,
                  inputDecorationFillColor: AppColors.gray200.withValues(
                    alpha: 0.5,
                  ),
                  textInputAction: TextInputAction.search,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text('this is current index: $index');
                },
              ),
              gapH100,
            ],
          ),
        ),
      ),
    );
  }
}
