import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyAssetsFilters extends StatelessWidget {
  const CompanyAssetsFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.translations;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).add(EdgeInsetsGeometry.only(bottom: 8, top: 16)),
          child: SearchBar(
            leading: Icon(Icons.search, color: Colors.grey.shade600),
            hintText: translations.searchAssets,
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
                avatar: SvgPicture.asset(
                  "assets/svg/bolt_outlined.svg",
                  width: 24,
                  height: 24,
                ),
                selected: false,
                onSelected: (value) {},
              ),
              SizedBox(width: 8),
              ChoiceChip(
                label: Text(translations.critical),
                avatar: SvgPicture.asset(
                  "assets/svg/alert_outlined.svg",
                  width: 24,
                  height: 24,
                ),
                selected: false,
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
