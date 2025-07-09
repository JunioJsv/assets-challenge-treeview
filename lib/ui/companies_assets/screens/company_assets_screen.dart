import 'package:assets_challenge/data/models/companies_assets/company.dart';
import 'package:assets_challenge/dependencies.dart';
import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/company_assets/company_assets_bloc.dart';
import 'package:assets_challenge/utils/route_utils.dart';
import 'package:flutter/material.dart';

class CompanyAssetsScreenArguments {
  final Company company;

  const CompanyAssetsScreenArguments({required this.company});
}

class CompanyAssetsScreen extends StatefulWidget {
  static final String route = "$CompanyAssetsScreen";

  const CompanyAssetsScreen({super.key});

  @override
  State<CompanyAssetsScreen> createState() => _CompanyAssetsScreenState();
}

class _CompanyAssetsScreenState extends State<CompanyAssetsScreen> {
  late final arguments = context.arguments<CompanyAssetsScreenArguments>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dependencies
          .registerSingleton(
            CompanyAssetsBloc(repository: dependencies()),
            dispose: (bloc) => bloc.close(),
          )
          .add(GetCompanyAssetsEvent(arguments.company.id));
    });
  }

  @override
  void dispose() {
    super.dispose();
    dependencies.unregister<CompanyAssetsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translations.assets)),
      body: _CompanyAssetsScreenBody(),
    );
  }
}

class _CompanyAssetsScreenBody extends StatelessWidget {
  const _CompanyAssetsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
