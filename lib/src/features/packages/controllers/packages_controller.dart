import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ordem_siai/src/features/assemblages/models/assemblage_mode.dart';
import 'package:ordem_siai/src/features/assemblages/providers/assemblages_provider.dart';
import 'package:ordem_siai/src/features/packages/models/package_model.dart';
import 'package:ordem_siai/src/features/packages/models/package_type_model.dart';
import 'package:provider/provider.dart';

import '../../../shared/routes/app_routes_names.dart';
import '../../../shared/utils/display_dialog.dart';
import '../../auth/providers/auth_provider.dart';
import '../../users/models/users_models.dart';
import '../../users/providers/users_provider.dart';
import '../../users/models/insert_user_and_profile_model.dart';
import '../models/insert_package_selected_email_model.dart';
import '../models/package_users_model.dart';
import '../providers/packages_provider.dart';
import '../providers/packages_types_provider.dart';

class PackagesController {
  final BuildContext _context;
  final PageController? pageController;

  static PackageModel packageDetail = PackageModel();

  PackagesController(
    this._context,
    this.pageController,
  );

  handleAddNewPackage() {
    if (pageController != null) {
      pageController!.jumpToPage(6);
    } else {
      Navigator.pushReplacementNamed(
        _context,
        AppRoutesNames.INSERT_PACKAGE,
      );
    }
  }

  handleCancelNewPackage() {
    if (pageController != null) {
      pageController!.jumpToPage(1);
    } else {
      Navigator.pushReplacementNamed(
        _context,
        AppRoutesNames.PACKAGES,
      );
    }
  }

  handleInsertNewUser(InsertUseAndProfileModel user) async {
    UsersProvider usersProvider = Provider.of(
      _context,
      listen: false,
    );
    try {
      await usersProvider.insertUser(user);
    } catch (e) {
      DisplayDialog.showDialogAsync(
        _context,
        "Erro na Inclusão de Novo usuário",
        e.toString(),
        FeatherIcons.frown,
      );
    }
  }

  handleInsertPackage({
    required DateTime eventDateTime,
    required AssemblageModel assemblage,
    required PackageTypeModel packageType,
    required List<InsertPackageSelectedEmailModel> checkedUsers,
  }) async {
    PackagesProvider packagesProvider = Provider.of(
      _context,
      listen: false,
    );
    AuthProvider authProvider = Provider.of(
      _context,
      listen: false,
    );
    UsersProvider usersProvider = Provider.of(
      _context,
      listen: false,
    );

    try {
      UsersModel authUser = await usersProvider.getUser(
        authProvider.authUser!.user.id!,
      );

      List<UsersModel> listUsers = usersProvider.users;

      await packagesProvider.insertPackage(
        eventDateTime: eventDateTime,
        assemblage: assemblage,
        packageType: packageType,
        createdUser: authUser,
        packageUsers: checkedUsers.map(
          (e) {
            int i = listUsers.indexWhere((e2) => e2.usu_uuid == e.usu_uuid);
            return PackageUsersModel(
              usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario:
                  listUsers[i],
            );
          },
        ).toList(),
      );

      if (pageController != null) {
        pageController!.jumpToPage(1);
      } else {
        Navigator.pushReplacementNamed(
          _context,
          AppRoutesNames.PACKAGES,
        );
      }
    } catch (e) {
      DisplayDialog.showDialogAsync(
        _context,
        "Erro na Inclusão do Novo Pacote",
        e.toString(),
        FeatherIcons.frown,
      );
    }
  }

  Future<void> loadAllPackages() async {
    PackagesProvider packagesProvider = Provider.of(
      _context,
      listen: false,
    );

    await packagesProvider.loadAllPackages();
  }

  Future<void> loadAllAssemblages() async {
    AssemblagesProvider assemblagesProvider = Provider.of(
      _context,
      listen: false,
    );

    AuthProvider authProvider = Provider.of(
      _context,
      listen: false,
    );

    UsersProvider usersProvider = Provider.of(
      _context,
      listen: false,
    );
    UsersModel user =
        await usersProvider.getUser(authProvider.authUser!.user.id!);

    await assemblagesProvider
        .loadAllAssemblages(user.assembleia!.ordem!.ord_uuid!);
  }

  Future<void> loadAllPackagesTypes() async {
    PackagesTypesProvider provider = Provider.of(
      _context,
      listen: false,
    );

    await provider.loadAllPackagesTypes();
  }

  Future<void> loadUsers() async {
    UsersProvider usersProvider = Provider.of(
      _context,
      listen: false,
    );

    await usersProvider.loadUsers();
  }

  void handlePackageDetail(PackageModel? package) {
    packageDetail = package ?? PackageModel();
    if (pageController != null) {
      pageController!.jumpToPage(7);
    } else {
      Navigator.pushReplacementNamed(
        _context,
        AppRoutesNames.DETAIL_PACKAGE,
      );
    }
  }

  Future<UsersModel?> getAuthenticateUser() async {
    AuthProvider authProvider = Provider.of(
      _context,
      listen: false,
    );

    return await getUser(authProvider.authUser!.user.id!);
  }

  Future<UsersModel?> getUser(String userId) async {
    UsersProvider usersProvider = Provider.of(
      _context,
      listen: false,
    );

    return usersProvider.getUser(userId);
  }

  Future<bool> canUpdateUserPresenceStatus() async {
    return true;

    //MOCK
    /*UsersModel? authUser = await getAuthenticateUser();
    String value = authUser!.email!.split('@')[0];
    return (value.contains('0') ||
        value.contains('9') ||
        value.contains('8') ||
        value.contains('7') ||
        value.contains('6') ||
        value.contains('5'));*/
  }

  Future<bool> canUpdatePackageStatus() async {
    return true;

    /*UsersModel? authUser = await getAuthenticateUser();

    //MOCK
    //String value = authUser!.email!.split('@')[0];
    //return (value.contains('0'));

    if ((authUser!.assembleia != null)) {
      return false;
    }
    return true;*/
  }

  updatePackageStatus(PackageModel packageModel) async {
    PackagesProvider packagesProvider = Provider.of(
      _context,
      listen: false,
    );

    try {
      await packagesProvider.updatePackageStatus(
        package: packageModel,
      );
    } catch (e) {
      DisplayDialog.showDialogAsync(
        _context,
        "Erro na Atualização no Status do Pacote",
        e.toString(),
        FeatherIcons.frown,
      );
    }
  }

  updatePackageUserPresenceStatus(PackageUsersModel packageUser) async {
    PackagesProvider packagesProvider = Provider.of(
      _context,
      listen: false,
    );

    try {
      await packagesProvider.updatePackageUserPresenceStatus(
        packageUser: packageUser,
      );
    } catch (e) {
      DisplayDialog.showDialogAsync(
        _context,
        "Erro na Atualização na Presença do Usuário",
        e.toString(),
        FeatherIcons.frown,
      );
    }
  }

  loginUser(String credentials) async {
    AuthProvider authProvider = Provider.of(
      _context,
      listen: false,
    );

    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      List<String> decoded = stringToBase64.decode(credentials).split(':');

      await authProvider.login(decoded[0].trim(), decoded[1]);
    } catch (e) {
      DisplayDialog.showDialogAsync(
        _context,
        "Erro na Autenticação",
        e.toString(),
        FeatherIcons.frown,
      );
    }
  }
}
