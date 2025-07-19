import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:flutter/material.dart';

import 'company_assets_tree_view.dart';

class CompanyAssetTreeNodeTile extends StatelessWidget {
  final CompanyAssetTreeNode node;
  final double indent;

  final int level;

  final bool isLastNode;

  const CompanyAssetTreeNodeTile({
    super.key,
    required this.node,
    required this.indent,
    required this.level,
    required this.isLastNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasChildren = node.children.isNotEmpty;
    final isLastComponent = node is ComponentTreeNode && isLastNode;
    final tile = ExpansionTile(
      tilePadding: !hasChildren ? EdgeInsets.zero : null,
      iconColor: theme.colorScheme.secondary,
      leading: !hasChildren
          ? SizedBox(
              width: level > 0 ? 39 : 42,
              child: level > 0
                  ? Container(height: 1, color: Colors.grey.shade300)
                  : null,
            )
          : null,
      shape: Border(),
      title: Row(
        children: [
          node.icon,
          SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    node.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ?node.trailing,
              ],
            ),
          ),
          SizedBox(width: 8),
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
    );

    return IgnorePointer(
      ignoring: !hasChildren,
      child: Container(
        margin: EdgeInsets.only(left: level > 0 ? indent : 0),
        decoration: !isLastComponent
            ? BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey.shade300)),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLastComponent)
              Container(color: Colors.grey.shade300, width: 1, height: 29),
            Expanded(child: tile),
          ],
        ),
      ),
    );
  }
}
