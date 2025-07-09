import 'dart:async';

import 'package:assets_challenge/data/repositories/companies_assets/icompanies_assets_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'company_assets_event.dart';

part 'company_assets_state.dart';

class CompanyAssetsBloc extends Bloc<CompanyAssetsEvent, CompanyAssetsState> {
  final ICompaniesAssetsRepository repository;

  CompanyAssetsBloc({required this.repository})
    : super(CompanyAssetsInitial()) {
    on<GetCompanyAssetsEvent>(_onGetCompanyAssetsEvent);
  }

  FutureOr<void> _onGetCompanyAssetsEvent(
    GetCompanyAssetsEvent event,
    Emitter<CompanyAssetsState> emitter,
  ) async {}
}
