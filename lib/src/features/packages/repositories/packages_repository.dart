import 'package:ordem_siai/src/features/auth/providers/auth_provider.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../models/package_model.dart';
//import 'implementations/packages_repository_impl.dart';
import 'implementations/packages_repository_fake.dart';

abstract class PackagesRepository {
  Future<List<PackageModel>> getAllPackages();
  Future<PackageModel> insertPackage(PackageModel package);

  factory PackagesRepository(
    ClientHttpProvider clientHttpProvider,
    AuthProvider authProvider,
  ) {
    //return PackagesRepositoryImpl(clientHttpProvider, authProvider);
    return PackagesRepositoryFake(authProvider);
  }
}