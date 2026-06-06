import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/validators/app_form_mixin.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/features/companies/providers/company_data_providers.dart';
import 'package:stima/features/companies/widgets/companies_list_item.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/empty_state_widget.dart';
import 'package:stima/shared/widgets/form/form_title_and_field.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/progress/app_loading_widget.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class CompaniesListPage extends ConsumerStatefulWidget {
  const CompaniesListPage({super.key});

  @override
  ConsumerState<CompaniesListPage> createState() => _CompaniesListPageState();
}

class _CompaniesListPageState extends ConsumerState<CompaniesListPage>
    with AppFormMixin {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  String get _searchValue => _searchController.text;

  static const _searchFieldKey = Key('companiesList_searchField');

  @override
  void dispose() {
    _node.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _resetSearch() {
    _node.unfocus();
    _searchController.clear();
    ref.read(companySearchControllerProvider.notifier).searchCompanies('');
  }

  void _onSearchChanged(String value) {
    ref.read(companySearchControllerProvider.notifier).searchCompanies(value);
  }

  @override
  Widget build(BuildContext context) {
    final companiesSearchController = ref.watch(
      companySearchControllerProvider,
    );
    final userRole = ref.watch(userRoleProvider).value;
    final canEdit = userRole?.canEdit == true;

    final loc = context.loc;

    return companiesSearchController.when(
      data: (data) {
        final isSearching = _searchValue.isNotEmpty;
        final hasCompanies = data.isNotEmpty == true;
        return AppScaffold(
          canPop: AppUtils.pageCanPop(context),
          hasAppBar: true,
          hasFAB: canEdit,
          onFABPressed: () {
            context.pushNamed(AppRoute.addCompanyStepOne.name);
          },
          appBarTitle: Text(loc.companies_list_page_title),
          body: FocusScope(
            node: _node,
            child: PaddedSafeArea(
              padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
              child: RefreshIndicator.adaptive(
                onRefresh: () async {
                  return await ref.refresh(companiesFutureProvider.future);
                },
                child: !hasCompanies && !isSearching
                    ? Center(
                        child: EmptyStateWidget(
                          content: loc.companies_list_page_empty_state_title,
                          cta: Visibility(
                            visible: canEdit,
                            child: AppPrimaryButton(
                              label: loc.companies_list_page_add_company_cta,
                              onPressed: () {
                                context.pushNamed(
                                  AppRoute.addCompanyStepOne.name,
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : ResponsiveScrollable(
                        scrollController: _scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSizes.gapH24,
                            Form(
                              key: _formKey,
                              child: FormTitleAndField(
                                fieldController: _searchController,
                                fieldKey: _searchFieldKey,
                                onChanged: _onSearchChanged,
                                prefixIcon: Assets.icons.search.svg(
                                  fit: BoxFit.scaleDown,
                                ),
                                suffixIcon: isSearching
                                    ? IconButton(
                                        onPressed: _resetSearch,
                                        icon: Assets.icons.close.svg(
                                          fit: BoxFit.scaleDown,
                                        ),
                                      )
                                    : null,
                                fieldHintText:
                                    loc.companies_list_page_search_field_hint,
                                inputDecorationFillColor: AppColors.gray200
                                    .withValues(alpha: 0.5),
                                textInputAction: TextInputAction.search,
                              ),
                            ),
                            AppSizes.gapH24,
                            ListView.separated(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: data.length,
                              separatorBuilder: (context, index) {
                                return AppSizes.gapH16;
                              },
                              itemBuilder: (context, index) {
                                return CompaniesListItem(company: data[index]);
                              },
                            ),
                            AppSizes.gapH100,
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
      loading: () => AppLoadingWidget(showText: true),
    );
  }
}
