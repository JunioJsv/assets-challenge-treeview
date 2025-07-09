import 'package:assets_challenge/dependencies.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/companies_bloc/companies_bloc.dart';
import 'package:assets_challenge/ui/companies_assets/screens/company_assets_screen.dart';
import 'package:assets_challenge/ui/companies_assets/widgets/company_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompaniesScreen extends StatelessWidget {
  static final String route = "$CompaniesScreen";

  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset("assets/svg/tractian.svg")),
      body: _CompaniesScreenBody(),
    );
  }
}

class _CompaniesScreenBody extends StatelessWidget {
  const _CompaniesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      bloc: dependencies(),
      builder: (context, state) {
        if (state is CompaniesFailureState) {
          // Todo replace by error widget
          return Center(child: Text(state.message));
        }

        if (state is CompaniesSuccessState) {
          final companies = state.companies;
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return CompanyCard(
                company: company,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CompanyAssetsScreen.route,
                    arguments: CompanyAssetsScreenArguments(company: company),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 48);
            },
          );
        }

        // Todo replace by shimmer widget
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
