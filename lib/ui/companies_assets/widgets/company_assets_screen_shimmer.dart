import 'dart:math';

import 'package:assets_challenge/domain/models/companies_assets/company_asset_tree_node.dart';
import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:assets_challenge/ui/companies_assets/widgets/company_asset_tree_node_tile.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CompanyAssetsScreenShimmer extends StatelessWidget {
  const CompanyAssetsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.translations;
    final header = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).add(EdgeInsetsGeometry.only(bottom: 8, top: 16)),
          child: SearchBar(
            hintText: translations.searchAssets,
            leading: Icon(Icons.search, color: Colors.grey.shade600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).add(EdgeInsetsGeometry.only(bottom: 8)),
          child: Row(
            children: [
              ChoiceChip(
                label: Text(translations.energySensor),
                selected: false,
                avatar: SizedBox(height: 24, width: 24),
              ),
              SizedBox(width: 8),
              ChoiceChip(
                label: Text(translations.critical),
                selected: false,
                avatar: SizedBox(height: 24, width: 24),
              ),
            ],
          ),
        ),
      ],
    );
    final listview = ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CompanyAssetTreeNodeTile(
          node: LocationTreeNode(
            id: "id",
            name: "".padLeft(Random().nextInt(10) + 5, "#"),
          ),
          isLastNode: false,
          indent: 0,
          level: 0,
        );
      },
    );
    final layout = Column(
      children: [
        header,
        Divider(color: Colors.grey.shade300, thickness: 1.0),
        Expanded(child: listview),
      ],
    );

    return Skeletonizer(enabled: true, ignorePointers: true, child: layout);
  }
}
