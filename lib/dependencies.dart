import 'package:assets_challenge/data/repositories/companies_assets/companies_assets_repository.dart';
import 'package:assets_challenge/domain/repositories/companies_assets/icompanies_assets_repository.dart';
import 'package:assets_challenge/domain/services/companies_assets/company_assets_service.dart';
import 'package:assets_challenge/domain/services/companies_assets/icompany_assets_service.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/companies_bloc/companies_bloc.dart';
import 'package:assets_challenge/utils/default_http_client.dart';
import 'package:assets_challenge/utils/ihttp_client.dart';
import 'package:get_it/get_it.dart';

final dependencies = GetIt.instance;

extension DependenciesExtension on GetIt {
  void initialize() {
    dependencies.registerSingleton<IHttpClient>(DefaultHttpClient());
    dependencies.registerSingleton<ICompaniesAssetsRepository>(
      CompaniesAssetsRepository(dependencies()),
    );
    dependencies.registerSingleton<ICompanyAssetsService>(
      CompanyAssetsService(dependencies()),
    );
    dependencies.registerLazySingleton(() {
      return CompaniesBloc(repository: dependencies())
        ..add(GetCompaniesEvent());
    }, dispose: (bloc) => bloc.close());
  }

  void dispose() {
    dependencies.unregister<CompaniesBloc>();
    dependencies.unregister<ICompaniesAssetsRepository>();
    dependencies.unregister<IHttpClient>();
  }
}
