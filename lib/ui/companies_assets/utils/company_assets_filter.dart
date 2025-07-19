import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/utils/nullable.dart';
import 'package:equatable/equatable.dart';

/// Filter applied to the asset tree:
///
/// Scenarios and conditions:
///
/// 1. No filter:
///    - Returns all nodes in the tree.
///
/// 2. Name filter (`byName`):
///    - Searches by name of location, asset, or component.
///    - If the name matches a location or asset and no sensor filter is active, keeps all children of that location.
///    - If the name matches an asset or component, returns only the nodes that match the name.
///    - Locations without asset or component-type children are excluded.
///
/// 3. Sensor filter (`bySensorType` or `bySensorStatus`):
///    - Filters only components that match the sensor type/status.
///    - Locations and assets are kept only if they have child components that match the filter.
///    - Locations without component-type children are excluded.
///
/// 4. Combined filter (`byName` + `bySensorType`/`bySensorStatus`):
///    - Allows searching by the name of a location, asset, or component.
///    - If the name matches a location or asset, keeps only the child components that match the filter.
class CompanyAssetsFilter extends Equatable {
  final String? byName;
  final SensorType? bySensorType;
  final SensorStatus? bySensorStatus;

  bool get isFilteringBySensor =>
      bySensorType != null || bySensorStatus != null;

  bool get isFilteringByName => byName != null && byName!.isNotEmpty;

  bool get isEnabled =>
      byName != null && byName!.isNotEmpty ||
      bySensorType != null ||
      bySensorStatus != null;

  const CompanyAssetsFilter({
    this.byName,
    this.bySensorType,
    this.bySensorStatus,
  });

  List<CompanyAssetTreeNode> apply(List<CompanyAssetTreeNode> nodes) {
    if (!isEnabled) return nodes;
    return _filterNodes(nodes, _nodeMatches);
  }

  bool _nodeMatches(CompanyAssetTreeNode node) {
    return _nameMatches(node) && _sensorMatches(node);
  }

  bool _nameMatches(CompanyAssetTreeNode node) {
    final byName = this.byName;

    if (byName == null || byName.isEmpty) return true;

    return node.name.toLowerCase().contains(byName.toLowerCase());
  }

  bool _sensorMatches(CompanyAssetTreeNode node) {
    final bySensorType = this.bySensorType;
    final bySensorStatus = this.bySensorStatus;

    if (node is! ComponentTreeNode) return true;

    if (bySensorType != null && node.sensorType != bySensorType) return false;
    if (bySensorStatus != null && node.sensorStatus != bySensorStatus) {
      return false;
    }

    return true;
  }

  List<CompanyAssetTreeNode> _filterNodes(
    List<CompanyAssetTreeNode> nodes,
    bool Function(CompanyAssetTreeNode) test,
  ) {
    List<CompanyAssetTreeNode> filtered = [];
    for (final node in nodes.map((CompanyAssetTreeNode e) => e.clone())) {
      final isAsset = node is AssetTreeNode;
      final isLocation = node is LocationTreeNode;

      final locationOrAssetNameMatch =
          isFilteringByName && (isLocation || isAsset) && _nameMatches(node);

      if (locationOrAssetNameMatch) {
        if (isFilteringBySensor) {
          node.children = _filterNodes(node.children, (child) {
            return child is ComponentTreeNode && _sensorMatches(child);
          });
        }
      } else {
        node.children = _filterNodes(node.children, test);
      }

      bool maybeKeepNode = test(node) || node.children.isNotEmpty;

      if (maybeKeepNode) {
        if ((isLocation || isAsset) &&
            isFilteringBySensor &&
            node.children.isEmpty) {
          continue;
        }
        filtered.add(node);
      }
    }
    return filtered;
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
