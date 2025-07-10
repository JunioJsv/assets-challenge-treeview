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
  final List<CompanyAssetTreeNode> _nodes;
  final CompanyAssetsFilter? filter;

  CompanyAssetsSuccessState({
    required List<CompanyAssetTreeNode> nodes,
    this.filter,
  }) : _nodes = nodes;
  late final List<CompanyAssetTreeNode> nodes = () {
    final filter = this.filter;
    if (filter == null || !filter.isEnabled) {
      return _nodes;
    }
    return filter.apply(_nodes);
  }();

  CompanyAssetsSuccessState copyWith({
    List<CompanyAssetTreeNode>? nodes,
    Nullable<CompanyAssetsFilter>? filter,
  }) {
    return CompanyAssetsSuccessState(
      nodes: nodes ?? _nodes,
      filter: filter != null ? filter.value : this.filter,
    );
  }

  @override
  List<Object?> get props => [_nodes, filter];
}

class CompanyAssetsFailureState extends CompanyAssetsState {
  final String message;
  final StackTrace? stackTrace;

  const CompanyAssetsFailureState({required this.message, this.stackTrace});

  @override
  List<Object> get props => [message];
}
