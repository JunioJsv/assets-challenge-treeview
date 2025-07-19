import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/ui/companies_assets/widgets/company_asset_tree_node_tile.dart';
import 'package:flutter/material.dart';

class CompanyAssetsTreeView extends StatelessWidget {
  final List<CompanyAssetTreeNode> nodes;
  final ScrollPhysics? physics;

  final double indent;

  final int level;

  const CompanyAssetsTreeView({
    super.key,
    required this.nodes,
    this.physics,
    this.indent = 28,
    this.level = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nodes.length,
      shrinkWrap: true,
      primary: level == 0,
      physics: physics,
      findChildIndexCallback: (key) {
        if (key is ValueKey) {
          final index = nodes.indexWhere((node) => node.id == key.value);
          if (index != -1) return index;
        }
        return null;
      },
      itemBuilder: (context, index) {
        final node = nodes[index];
        return CompanyAssetTreeNodeTile(
          key: ValueKey(node.id),
          node: node,
          isLastNode: index == nodes.length - 1,
          indent: indent,
          level: level,
        );
      },
    );
  }
}
