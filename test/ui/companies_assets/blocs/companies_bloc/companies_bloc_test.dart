import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assets_challenge/ui/companies_assets/blocs/companies_bloc/companies_bloc.dart';
import 'package:assets_challenge/domain/repositories/companies_assets/icompanies_assets_repository.dart';

import '../../../../data/repositories/companies_assets/mock_companies_assets_repository.dart';

void main() {
  late CompaniesBloc bloc;
  late ICompaniesAssetsRepository repository;

  setUp(() {
    repository = MockCompaniesAssetsRepository();
    bloc = CompaniesBloc(repository: repository);
  });

  test('initial state is CompaniesInitialState', () {
    expect(bloc.state, isA<CompaniesInitialState>());
  });

  blocTest<CompaniesBloc, CompaniesState>(
    'emits [CompaniesLoadingState, CompaniesSuccessState] when GetCompaniesEvent is added',
    build: () => bloc,
    act: (bloc) => bloc.add(GetCompaniesEvent()),
    expect: () => [
      isA<CompaniesLoadingState>(),
      isA<CompaniesSuccessState>()
          .having((state) => state.companies.length, 'companies length', 3)
          .having(
            (state) => state.companies.map((e) => e.id),
            'companies ids',
            ['1', '2', '3'],
          ),
    ],
  );
}
