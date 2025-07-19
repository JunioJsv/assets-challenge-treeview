import 'dart:math';

import 'package:assets_challenge/domain/models/companies_assets/company.dart';
import 'package:assets_challenge/ui/companies_assets/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CompaniesListViewShimmer extends StatelessWidget {
  const CompaniesListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final listview = ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      itemCount: 3,
      itemBuilder: (context, index) {
        return CompanyCard(
          company: Company(
            id: 'id',
            name: "".padLeft(Random().nextInt(10) + 5, "#"),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 48);
      },
    );

    return Skeletonizer(
      enabled: true,
      containersColor: Colors.white,
      child: listview,
    );
  }
}
