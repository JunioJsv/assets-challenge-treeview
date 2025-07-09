import 'dart:async';

import 'package:assets_challenge/data/models/companies_assets/company.dart';
import 'package:assets_challenge/data/repositories/companies_assets/icompanies_assets_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'companies_event.dart';

part 'companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final ICompaniesAssetsRepository repository;

  CompaniesBloc({required this.repository}) : super(CompaniesInitialState()) {
    on<GetCompaniesEvent>(_onGetCompaniesEvent);
    add(GetCompaniesEvent());
  }

  FutureOr<void> _onGetCompaniesEvent(
    GetCompaniesEvent event,
    Emitter<CompaniesState> emitter,
  ) async {
    try {
      emitter(CompaniesLoadingState());
      final companies = await repository.getCompanies();
      emitter(CompaniesSuccessState(companies));
    } catch (e, s) {
      emitter(CompaniesFailureState(message: e.toString(), stackTrace: s));
    }
  }
}
