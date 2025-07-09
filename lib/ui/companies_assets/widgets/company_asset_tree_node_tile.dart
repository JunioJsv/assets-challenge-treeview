import 'package:assets_challenge/domain/models/company_assets/company_asset_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'company_assets_tree_view.dart';

class CompanyAssetTreeNodeTile extends StatefulWidget {
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
  State<CompanyAssetTreeNodeTile> createState() =>
      _CompanyAssetTreeNodeTileState();
}

class _CompanyAssetTreeNodeTileState extends State<CompanyAssetTreeNodeTile> {
  final controller = ExpansibleController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final level = widget.level;
    final indent = widget.indent;
    final hasChildren = node.children.isNotEmpty;
    return IgnorePointer(
      ignoring: !hasChildren,
      child: Container(
        // color: Colors.accents.shuffled().first,
        margin: EdgeInsets.only(left: level > 0 ? indent : 0),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey.shade300)),
        ),
        child: ExpansionTile(
          controller: controller,
          tilePadding: !hasChildren ? EdgeInsets.zero : null,
          leading: !hasChildren
              ? SizedBox(
                  width: 32,
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
              physics: NeverScrollableScrollPhysics(),
              indent: indent,
              level: level + 1,
            ),
          ],
        ),
      ),
    );
  }
}
