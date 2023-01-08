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

  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';

  List<PackageModel> _packages = [];
  List<PackageModel> get packages => [..._packages];

  Future<void> loadAllPackages() async {
    _packages = [];

    try {
      errorMessage = '';
      isError = false;
      isLoading = true;
      notifyListeners();
      _packages = await packagesRepository.getAllPackages();
    } catch (e) {
      errorMessage = e.toString();
      isError = true;
    }

    isLoading = false;
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
        pac_dt_evento: eventDateTime,
        tipo_pacote: packageType,
        assembleia: assemblage,
        rel_pacote_usuario: packageUsers,
        usuario_pacote_usu_id_criacao_fkTousuario: createdUser,
        pac_dt_criacao: DateTime.now(),
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
