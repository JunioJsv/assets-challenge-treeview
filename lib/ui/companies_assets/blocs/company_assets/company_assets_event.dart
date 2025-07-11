part of 'company_assets_bloc.dart';

sealed class CompanyAssetsEvent extends Equatable {
  const CompanyAssetsEvent();
}

class GetCompanyAssetsEvent extends CompanyAssetsEvent {
  final String companyId;

  const GetCompanyAssetsEvent(this.companyId);

  @override
  List<Object?> get props => [companyId];
}

class FilterCompanyAssetsEvent extends CompanyAssetsEvent {
  final CompanyAssetsFilter? Function(CompanyAssetsFilter) filter;

  const FilterCompanyAssetsEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
