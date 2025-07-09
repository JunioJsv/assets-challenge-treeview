import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
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
      physics: physics,
      itemBuilder: (context, index) {
        final node = nodes[index];
        return CompanyAssetTreeNodeTile(
          node: node,
          indent: indent,
          level: level,
        );
      },
    );
  }
}
