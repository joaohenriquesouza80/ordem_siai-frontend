import '../../../shared/providers/client_http/client_http_provider.dart';
import '../models/package_type_model.dart';
import 'implementations/packages_types_repository_fake.dart';
import 'implementations/packages_types_repository_impl.dart';

abstract class PackagesTypesRepository {
  Future<List<PackageTypeModel>> getAllPackagesTypes();

  factory PackagesTypesRepository(ClientHttpProvider clientHttpProvider) {
    return PackagesTypesRepositoryImpl(clientHttpProvider);
    //return PackagesTypesRepositoryFake(clientHttpProvider);
  }
}
