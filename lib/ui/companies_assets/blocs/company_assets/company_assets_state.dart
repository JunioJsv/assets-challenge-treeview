part of 'company_assets_bloc.dart';

sealed class CompanyAssetsState extends Equatable {
  const CompanyAssetsState();
}

final class CompanyAssetsInitial extends CompanyAssetsState {
  @override
  List<Object> get props => [];
}

class CompanyAssetsLoadingState extends CompanyAssetsState {
  @override
  List<Object> get props => [];
}

class CompanyAssetsSuccessState extends CompanyAssetsState {
  final List<CompanyAssetTreeNode> nodes;

  const CompanyAssetsSuccessState(this.nodes);

  @override
  List<Object> get props => [nodes];
}

class CompanyAssetsFailureState extends CompanyAssetsState {
  final String message;
  final StackTrace? stackTrace;

  const CompanyAssetsFailureState({required this.message, this.stackTrace});

  @override
  List<Object> get props => [message];
}
