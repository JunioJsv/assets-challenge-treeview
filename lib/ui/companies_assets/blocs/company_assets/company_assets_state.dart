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

class CompanyAssetsFilter extends Equatable {
  final String? byName;
  final SensorType? bySensorType;
  final SensorStatus? bySensorStatus;

  const CompanyAssetsFilter({
    this.byName,
    this.bySensorType,
    this.bySensorStatus,
  });

  bool matches(CompanyAssetTreeNode node) {
    if (byName != null &&
        !node.name.toLowerCase().contains(byName!.toLowerCase())) {
      return false;
    }
    if (bySensorType != null &&
        node is ComponentTreeNode &&
        node.sensorType != bySensorType) {
      return false;
    }
    if (bySensorStatus != null &&
        node is ComponentTreeNode &&
        node.sensorStatus != bySensorStatus) {
      return false;
    }
    return true;
  }

  CompanyAssetsFilter copyWith({
    Nullable<String>? byName,
    Nullable<SensorType>? bySensorType,
    Nullable<SensorStatus>? bySensorStatus,
  }) {
    return CompanyAssetsFilter(
      byName: byName != null ? byName.value : this.byName,
      bySensorType: bySensorType != null
          ? bySensorType.value
          : this.bySensorType,
      bySensorStatus: bySensorStatus != null
          ? bySensorStatus.value
          : this.bySensorStatus,
    );
  }

  @override
  List<Object?> get props => [byName, bySensorType, bySensorStatus];
}

class CompanyAssetsSuccessState extends CompanyAssetsState {
  final List<CompanyAssetTreeNode> _nodes;
  final CompanyAssetsFilter? filter;

  CompanyAssetsSuccessState({
    required List<CompanyAssetTreeNode> nodes,
    this.filter,
  }) : _nodes = nodes;

  List<CompanyAssetTreeNode> _getFilteredNodes(
    List<CompanyAssetTreeNode> nodes,
    bool Function(CompanyAssetTreeNode) match,
  ) {
    List<CompanyAssetTreeNode> filtered = [];

    for (final node in nodes) {
      final filteredChildren = _getFilteredNodes(node.children, match);

      final isComponent = node is ComponentTreeNode;

      if ((isComponent && match(node)) || filteredChildren.isNotEmpty) {
        final newNode = node.cloneWithoutChildren()
          ..children.addAll(filteredChildren);
        filtered.add(newNode);
      }
    }

    return filtered;
  }

  late final List<CompanyAssetTreeNode> nodes = () {
    final filter = this.filter;
    if (filter == null) {
      return _nodes;
    }
    return _getFilteredNodes(_nodes, (node) => filter.matches(node));
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
