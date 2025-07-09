part of 'company_assets_bloc.dart';

sealed class CompanyAssetsState extends Equatable {
  const CompanyAssetsState();
}

final class CompanyAssetsInitial extends CompanyAssetsState {
  @override
  List<Object> get props => [];
}
