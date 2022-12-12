import '../../../../shared/mocks/repositories_mock.dart';
import '../../../../shared/providers/client_http/client_http_provider.dart';
import '../../models/package_type_model.dart';
import '../packages_types_repository.dart';

class PackagesTypesRepositoryFake implements PackagesTypesRepository {
  final ClientHttpProvider clientHttpProvider;

  PackagesTypesRepositoryFake(this.clientHttpProvider);

  @override
  Future<List<PackageTypeModel>> getAllPackagesTypes() async {
    return RepositoriesMocks.getMockPackagesType();
  }
}
