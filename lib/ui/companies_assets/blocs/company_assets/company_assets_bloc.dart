import 'dart:async';

import 'package:assets_challenge/data/repositories/companies_assets/icompanies_assets_repository.dart';
import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/ui/companies_assets/utils/company_assets_filter.dart';
import 'package:assets_challenge/utils/nullable.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'company_assets_event.dart';

part 'company_assets_state.dart';

class CompanyAssetsBloc extends Bloc<CompanyAssetsEvent, CompanyAssetsState> {
  final ICompaniesAssetsRepository repository;

  CompanyAssetsBloc({required this.repository})
    : super(CompanyAssetsInitial()) {
    on<GetCompanyAssetsEvent>(_onGetCompanyAssetsEvent);
    on<FilterCompanyAssetsEvent>(
      _onFilterCompanyAssetsEvent,
      transformer: (events, mapper) {
        return events.debounceTime(Duration(milliseconds: 500)).flatMap(mapper);
      },
    );
  }

  FutureOr<void> _onGetCompanyAssetsEvent(
    GetCompanyAssetsEvent event,
    Emitter<CompanyAssetsState> emitter,
  ) async {
    try {
      final state = this.state;
      final filter = state is CompanyAssetsSuccessState ? state.filter : null;
      emitter(CompanyAssetsLoadingState());
      final locations = await repository.getCompanyLocations(event.companyId);
      final assets = await repository.getCompanyAssets(event.companyId);

      final nodes = Map.fromEntries(
        [
          ...locations.map((location) => location.toTreeNode()),
          ...assets.map((asset) => asset.toTreeNode()),
        ].map((node) {
          return MapEntry(node.id, node);
        }),
      );

      final List<CompanyAssetTreeNode> roots = [];

      for (final node in nodes.values) {
        final locationId = switch (node) {
          AssetTreeNode() => node.locationId,
          ComponentTreeNode() => node.locationId,
          _ => null,
        };

        final parentId = node.parentId ?? locationId;

        if (parentId != null && nodes.containsKey(node.id)) {
          nodes[parentId]!.children.add(node);
        } else {
          roots.add(node);
        }
      }

      emitter(CompanyAssetsSuccessState(nodes: roots, filter: filter));
    } catch (e, s) {
      emitter(CompanyAssetsFailureState(message: e.toString(), stackTrace: s));
    }
  }

  FutureOr<void> _onFilterCompanyAssetsEvent(
    FilterCompanyAssetsEvent event,
    Emitter<CompanyAssetsState> emitter,
  ) async {
    try {
      final state = this.state;
      if (state is CompanyAssetsSuccessState) {
        final filter = event.filter(state.filter ?? CompanyAssetsFilter());
        emitter(state.copyWith(filter: Nullable(filter)));
      }
    } catch (e, s) {}
  }
}
