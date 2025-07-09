import 'package:assets_challenge/data/models/companies_assets/company.dart';
import 'package:assets_challenge/dependencies.dart';
import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/company_assets/company_assets_bloc.dart';
import 'package:assets_challenge/ui/companies_assets/widgets/company_assets_filters.dart';
import 'package:assets_challenge/ui/companies_assets/widgets/company_assets_tree_view.dart';
import 'package:assets_challenge/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    dependencies.registerLazySingleton(() {
      return CompanyAssetsBloc(repository: dependencies())
        ..add(GetCompanyAssetsEvent(arguments.company.id));
    }, dispose: (bloc) => bloc.close());
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
    return BlocBuilder<CompanyAssetsBloc, CompanyAssetsState>(
      bloc: dependencies(),
      builder: (context, state) {
        if (state is CompanyAssetsFailureState) {
          // Todo replace by error widget
          return Center(child: Text(state.message));
        }

        if (state is CompanyAssetsSuccessState) {
          return Column(
            children: [
              CompanyAssetsFilters(),
              Divider(color: Colors.grey.shade300, thickness: 1.0),
              Expanded(child: CompanyAssetsTreeView(nodes: state.nodes)),
            ],
          );
        }

        // Todo replace by shimmer widget
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
