part of 'companies_bloc.dart';

sealed class CompaniesState extends Equatable {
  const CompaniesState();
}

class CompaniesInitialState extends CompaniesState {
  @override
  List<Object> get props => [];
}

class CompaniesLoadingState extends CompaniesState {
  @override
  List<Object> get props => [];
}

class CompaniesSuccessState extends CompaniesState {
  final List<Company> companies;

  const CompaniesSuccessState(this.companies);

  @override
  List<Object> get props => [companies];
}

class CompaniesFailureState extends CompaniesState {
  final String message;
  final StackTrace? stackTrace;

  const CompaniesFailureState({required this.message, this.stackTrace});

  @override
  List<Object> get props => [message];
}
