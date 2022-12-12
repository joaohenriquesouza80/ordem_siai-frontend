import '../../../shared/providers/client_http/client_http_provider.dart';
import '../models/package_type_model.dart';
import 'implementations/packages_types_repository_fake.dart';

abstract class PackagesTypesRepository {
  Future<List<PackageTypeModel>> getAllPackagesTypes();

  factory PackagesTypesRepository(ClientHttpProvider clientHttpProvider) {
    //return PackagesTypesRepository(clientHttpProvider);
    return PackagesTypesRepositoryFake(clientHttpProvider);
  }
}
