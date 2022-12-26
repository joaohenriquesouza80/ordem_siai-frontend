import 'package:ordem_siai/src/features/auth/providers/auth_provider.dart';
import 'package:ordem_siai/src/features/packages/models/package_users_model.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../models/package_model.dart';
import 'implementations/packages_repository_fake.dart';
import 'implementations/packages_repository_impl.dart';

abstract class PackagesRepository {
  Future<List<PackageModel>> getAllPackages();
  Future<PackageModel> insertPackage(PackageModel package);
  Future<void> updatePackageStatus(PackageModel package);
  Future<void> updatePackageUserPresenceStatus(PackageUsersModel packageUser);

  factory PackagesRepository(
    ClientHttpProvider clientHttpProvider,
    AuthProvider authProvider,
  ) {
    return PackagesRepositoryImpl(clientHttpProvider);
    //return PackagesRepositoryFake(authProvider);
  }
}
