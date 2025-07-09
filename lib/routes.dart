import 'package:assets_challenge/ui/companies_assets/screens/companies_screen.dart';
import 'package:assets_challenge/ui/companies_assets/screens/company_assets_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final builder = routes[settings.name];
  if (builder == null) return null;

  return MaterialPageRoute(settings: settings, builder: builder);
}

final Map<String, WidgetBuilder> routes = {
  CompaniesScreen.route: (context) => CompaniesScreen(),
  CompanyAssetsScreen.route: (context) => CompanyAssetsScreen(),
};
