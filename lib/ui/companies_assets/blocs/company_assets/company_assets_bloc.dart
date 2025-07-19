import 'dart:async';

import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/domain/services/companies_assets/icompany_assets_service.dart';
import 'package:assets_challenge/ui/companies_assets/utils/company_assets_filter.dart';
import 'package:assets_challenge/utils/nullable.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'company_assets_event.dart';

part 'company_assets_state.dart';

class CompanyAssetsBloc extends Bloc<CompanyAssetsEvent, CompanyAssetsState> {
  final ICompanyAssetsService service;

  CompanyAssetsBloc({required this.service}) : super(CompanyAssetsInitial()) {
    on<GetCompanyAssetsEvent>(_onGetCompanyAssetsEvent);
    on<FilterCompanyAssetsEvent>(
      _onFilterCompanyAssetsEvent,
      transformer: (events, mapper) {
        return events.debounceTime(Duration(milliseconds: 300)).flatMap(mapper);
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

      final roots = await service.getAssetsTreeNodes(event.companyId);

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
