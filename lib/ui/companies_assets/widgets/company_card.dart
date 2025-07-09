import 'package:assets_challenge/data/models/companies_assets/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  final VoidCallback? onTap;

  const CompanyCard({super.key, required this.company, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.secondary,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Row(
            children: [
              SvgPicture.asset("assets/svg/company.svg"),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  company.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
