import 'package:ordem_siai/src/features/packages/models/package_users_model.dart';

import '../../../../shared/mocks/repositories_mock.dart';
import '../../../auth/models/user_model.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../users/models/users_models.dart';
import '../../models/package_model.dart';
import '../packages_repository.dart';

class PackagesRepositoryFake implements PackagesRepository {
  final AuthProvider authProvider;

  PackagesRepositoryFake(this.authProvider);

  @override
  Future<List<PackageModel>> getAllPackages() async {
    List<PackageModel> packages = RepositoriesMocks.getMockPackages(0);
    packages.sort(
      (a, b) => b.event_date_time!.compareTo(a.event_date_time!),
    );

    List<UsersModel> usersModel = RepositoriesMocks.getMockFullUsers();

    String userId = authProvider.authUser!.user.id!;

    final index = usersModel.indexWhere(
      (u) => u.id == userId,
    );

    if (index < 0) {
      return [];
    }

    UsersModel user = usersModel[index];

    if (user.UserProfile?.assemblage == null) {
      return packages
          .where((e) => e.assemblage?.order?.id == user.UserProfile?.order?.id)
          .toList();
    }
    return packages
        .where((e) => e.assemblage?.id == user.UserProfile?.assemblage?.id)
        .toList();
  }

  @override
  Future<PackageModel> insertPackage(PackageModel package) {
    UserModel authenticatedUser = authProvider.authUser!.user;

    PackageModel newPackage = RepositoriesMocks.insertPackage(
      package: package,
      authenticatedUser: authenticatedUser,
    );

    return Future.value(newPackage);
  }

  @override
  Future<void> updatePackageStatus(PackageModel package) {
    // TODO: implement updatePackageStatus
    throw UnimplementedError();
  }

  @override
  Future<void> updatePackageUserPresenceStatus(PackageUsersModel packageUser) {
    // TODO: implement updatePackageUserPresenceStatus
    throw UnimplementedError();
  }
}
