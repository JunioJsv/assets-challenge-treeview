import 'package:assets_challenge/data/repositories/companies_assets/companies_assets_repository.dart';
import 'package:assets_challenge/utils/default_http_client.dart';
import 'package:assets_challenge/utils/ihttp_client.dart';
import 'package:get_it/get_it.dart';

final dependencies = GetIt.instance;

extension DependenciesExtension on GetIt {
  void initialize() {
    dependencies.registerSingleton<IHttpClient>(DefaultHttpClient());
    dependencies.registerSingleton(CompaniesAssetsRepository(dependencies()));
  }

  void dispose() {
    dependencies.unregister<CompaniesAssetsRepository>();
    dependencies.unregister<IHttpClient>();
  }
}
