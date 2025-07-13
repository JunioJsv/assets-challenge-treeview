import 'package:assets_challenge/data/models/companies_assets/sensor_status.dart';
import 'package:assets_challenge/data/models/companies_assets/sensor_type.dart';
import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/utils/nullable.dart';
import 'package:equatable/equatable.dart';

/// Filtro aplicado na árvore de ativos:
///
/// Cenários e condições:
///
/// 1. Sem filtro:
///    - Retorna todos os nós da árvore.
///
/// 2. Filtro por nome (byName):
///    - Busca por nome de localização, ativo ou componente.
///    - Se o nome corresponder a uma localização e não houver filtro de sensor ativo, mantém todos os filhos dessa localização.
///    - Se o nome corresponder a um ativo ou componente, retorna apenas os nós que correspondem ao nome.
///    - Localizações sem filhos do tipo ativo ou componente são excluídas.
///
/// 3. Filtro por sensor (bySensorType ou bySensorStatus):
///    - Filtra apenas componentes que correspondam ao tipo/status do sensor.
///    - Localizações e ativos só são mantidos se tiverem filhos componentes que correspondam ao filtro.
///    - Localizações sem filhos do tipo componente são excluídas.
///
/// 4. Filtro combinado (byName + bySensorType/bySensorStatus):
///    - Permite buscar pelo nome da localização, ativo ou componente.
///    - Se o nome corresponder a uma localização, mantém apenas os filhos componentes que corresponda
class CompanyAssetsFilter extends Equatable {
  final String? byName;
  final SensorType? bySensorType;
  final SensorStatus? bySensorStatus;

  bool get isFilteringBySensor =>
      bySensorType != null || bySensorStatus != null;

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
    return _filterNodes(nodes, _matchesNode);
  }

  bool _matchesNode(CompanyAssetTreeNode node) {
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

  List<CompanyAssetTreeNode> _filterNodes(
    List<CompanyAssetTreeNode> nodes,
    bool Function(CompanyAssetTreeNode) match,
  ) {
    List<CompanyAssetTreeNode> filtered = [];
    for (final node in nodes) {
      final isComponent = node is ComponentTreeNode;
      final isAsset = node is AssetTreeNode;
      final isLocation = node is LocationTreeNode;

      final locationOrAssetNameMatch =
          (isLocation || isAsset) &&
          byName != null &&
          byName!.isNotEmpty &&
          node.name.toLowerCase().contains(byName!.toLowerCase());

      List<CompanyAssetTreeNode> filteredChildren;
      if (locationOrAssetNameMatch) {
        if (isFilteringBySensor) {
          filteredChildren = _filterNodes(node.children, (child) {
            if (child is ComponentTreeNode) {
              if (bySensorType != null && child.sensorType != bySensorType)
                return false;
              if (bySensorStatus != null &&
                  child.sensorStatus != bySensorStatus)
                return false;
              return true;
            }
            return false;
          });
        } else {
          // Se só está buscando por nome da localização, mantém todos os filhos sem filtrar
          filteredChildren = node.children
              .map((e) => e.cloneWithoutChildren()..children.addAll(e.children))
              .toList();
        }
      } else {
        filteredChildren = _filterNodes(node.children, match);
      }

      bool keepNode = false;
      if (isFilteringBySensor) {
        if (isComponent && match(node)) {
          keepNode = true;
        } else if (locationOrAssetNameMatch && filteredChildren.isNotEmpty) {
          keepNode = true;
        }
      } else {
        if ((isComponent || isAsset || isLocation) && match(node)) {
          keepNode = true;
        }
      }
      if (filteredChildren.isNotEmpty) {
        keepNode = true;
      }
      if (keepNode) {
        final newNode = node.cloneWithoutChildren()
          ..children.addAll(filteredChildren);
        if (isLocation && newNode.children.isEmpty) continue;
        if (isAsset && newNode.children.isEmpty && isFilteringBySensor)
          continue;
        filtered.add(newNode);
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
