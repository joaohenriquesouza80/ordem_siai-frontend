import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/packages/models/package_users_model.dart';
import 'package:ordem_siai/src/features/users/models/users_models.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../../assemblages/models/assemblage_mode.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/package_model.dart';
import '../models/package_type_model.dart';
import '../repositories/packages_repository.dart';

class PackagesProvider with ChangeNotifier {
  late PackagesRepository packagesRepository;

  PackagesProvider(
    ClientHttpProvider clientHttpProvider,
    AuthProvider authProvider,
  ) {
    packagesRepository = PackagesRepository(
      clientHttpProvider,
      authProvider,
    );
  }

  List<PackageModel> _packages = [];
  List<PackageModel> get packages => [..._packages];

  Future<void> loadAllPackages() async {
    _packages = [];

    _packages = await packagesRepository.getAllPackages();

    notifyListeners();
  }

  Future<void> insertPackage({
    required DateTime eventDateTime,
    required AssemblageModel assemblage,
    required PackageTypeModel packageType,
    required List<PackageUsersModel> packageUsers,
    required UsersModel createdUser,
  }) async {
    await packagesRepository.insertPackage(
      PackageModel(
        event_date_time: eventDateTime,
        package_type: packageType,
        assemblage: assemblage,
        package_users: packageUsers,
        creator_user: createdUser,
        created_at: DateTime.now(),
      ),
    );

    loadAllPackages();
  }

  Future<void> updatePackageStatus({required PackageModel package}) async {
    await packagesRepository.updatePackageStatus(package);
  }

  updatePackageUserPresenceStatus(
      {required PackageUsersModel packageUser}) async {
    await packagesRepository.updatePackageUserPresenceStatus(packageUser);
  }
}
