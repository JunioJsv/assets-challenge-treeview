import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:assets_challenge/dependencies.dart';
import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/company_assets/company_assets_bloc.dart';
import 'package:assets_challenge/utils/nullable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CompanyAssetsFilters extends StatefulWidget {
  const CompanyAssetsFilters({super.key});

  @override
  State<CompanyAssetsFilters> createState() => _CompanyAssetsFiltersState();
}

class _CompanyAssetsFiltersState extends State<CompanyAssetsFilters> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.translations;
    final bloc = dependencies<CompanyAssetsBloc>();
    final theme = Theme.of(context);
    var searchBar = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).add(EdgeInsetsGeometry.only(bottom: 8, top: 16)),
      child: BlocSelector<CompanyAssetsBloc, CompanyAssetsState, String?>(
        bloc: bloc,
        selector: (state) {
          return state is CompanyAssetsSuccessState
              ? state.filter?.byName
              : null;
        },
        builder: (context, query) {
          return SearchBar(
            controller: searchController,
            leading: Icon(Icons.search, color: Colors.grey.shade600),
            hintText: translations.searchAssets,
            onChanged: (value) {
              bloc.add(
                FilterCompanyAssetsEvent(
                  (filter) => filter.copyWith(byName: Nullable(value)),
                ),
              );
            },
            trailing: query?.isNotEmpty == true
                ? [
                    IconButton(
                      onPressed: () {
                        searchController.clear();
                        bloc.add(
                          FilterCompanyAssetsEvent(
                            (filter) => filter.copyWith(byName: Nullable(null)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ]
                : null,
          );
        },
      ),
    );
    var filters = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).add(EdgeInsetsGeometry.only(bottom: 8)),
      child: BlocSelector<CompanyAssetsBloc, CompanyAssetsState, List<Object>>(
        bloc: bloc,
        selector: (state) {
          if (state is! CompanyAssetsSuccessState) return [];

          return [?state.filter?.bySensorType, ?state.filter?.bySensorStatus];
        },
        builder: (context, query) {
          final isSensorEnergySelected = query.contains(SensorType.energy);
          final isSensorAlertSelected = query.contains(SensorStatus.alert);
          final textStyle = theme.chipTheme.labelStyle;
          return Row(
            children: [
              ChoiceChip(
                label: Text(
                  translations.energySensor,
                  style: textStyle!.copyWith(
                    color: isSensorEnergySelected
                        ? theme.colorScheme.onSecondary
                        : null,
                  ),
                ),
                avatar: SvgPicture.asset(
                  "assets/svg/bolt_outlined.svg",
                  width: 24,
                  height: 24,
                  color: isSensorEnergySelected
                      ? theme.colorScheme.onSecondary
                      : null,
                ),
                selected: isSensorEnergySelected,
                onSelected: (value) {
                  bloc.add(
                    FilterCompanyAssetsEvent(
                      (filter) => filter.copyWith(
                        bySensorType: Nullable(
                          value ? SensorType.energy : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 8),
              ChoiceChip(
                label: Text(
                  translations.critical,
                  style: textStyle.copyWith(
                    color: isSensorAlertSelected
                        ? theme.colorScheme.onSecondary
                        : null,
                  ),
                ),
                avatar: SvgPicture.asset(
                  "assets/svg/alert_outlined.svg",
                  width: 24,
                  height: 24,
                  color: isSensorAlertSelected
                      ? theme.colorScheme.onSecondary
                      : null,
                ),
                selected: isSensorAlertSelected,
                onSelected: (value) {
                  bloc.add(
                    FilterCompanyAssetsEvent(
                      (filter) => filter.copyWith(
                        bySensorStatus: Nullable(
                          value ? SensorStatus.alert : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
    return Column(children: [searchBar, filters]);
  }
}
