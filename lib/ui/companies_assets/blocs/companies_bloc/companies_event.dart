part of 'companies_bloc.dart';

sealed class CompaniesEvent extends Equatable {
  const CompaniesEvent();
}

class GetCompaniesEvent extends CompaniesEvent {
  @override
  List<Object> get props => [];
}
