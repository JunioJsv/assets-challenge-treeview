import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
import 'package:flutter/material.dart';

import 'company_assets_tree_view.dart';

class CompanyAssetTreeNodeTile extends StatelessWidget {
  final CompanyAssetTreeNode node;
  final double indent;

  final int level;

  const CompanyAssetTreeNodeTile({
    super.key,
    required this.node,
    required this.indent,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasChildren = node.children.isNotEmpty;
    return IgnorePointer(
      ignoring: !hasChildren,
      child: Container(
        margin: EdgeInsets.only(left: level > 0 ? indent : 0),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey.shade300)),
        ),
        child: ExpansionTile(
          tilePadding: !hasChildren ? EdgeInsets.zero : null,
          iconColor: theme.colorScheme.secondary,
          leading: !hasChildren
              ? SizedBox(
                  width: level > 0 ? 39 : 42,
                  child: level > 0
                      ? Divider(color: Colors.grey.shade300, thickness: 1.0)
                      : null,
                )
              : null,
          shape: Border(),
          title: Row(
            children: [
              node.icon,
              SizedBox(width: 8),
              Expanded(child: Text(node.name)),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
          children: [
            CompanyAssetsTreeView(
              nodes: node.children,
              indent: indent,
              level: level + 1,
            ),
          ],
        ),
      ),
    );
  }
}
