import 'dart:math';
import 'package:ordem_siai/src/features/packages/models/package_users_model.dart';
import 'package:ordem_siai/src/features/users/models/users_models.dart';
import 'package:random_x/random_x.dart';

import '../../features/assemblages/models/assemblage_mode.dart';
import '../../features/auth/models/user_model.dart';
import '../../features/orders/models/order_model.dart';
import '../../features/packages/models/package_model.dart';
import '../../features/packages/models/package_type_model.dart';
import '../../features/user_profile/models/user_profile_model.dart';
import '../../features/users/models/insert_user_and_profile_model.dart';
import '../../features/users/models/users_profile_model.dart';

class RepositoriesMocks {
  static final List<OrderModel> _listOrders = [];
  static final List<AssemblageModel> _listAssemblages = [];
  static final List<PackageTypeModel> _listPackagesTypes = [];
  static final List<PackageModel> _listPackageModel = [];
  static final List<UserModel> _listUsersModel = [];
  static final List<UserProfileModel> _listUsersProfilesModel = [];
  static final List<UsersModel> _listFullUsersModel = [];

  static List<OrderModel> getMockOrders(int size) {
    if (_listOrders.isNotEmpty) {
      return _listOrders;
    }

    for (int i = 0; i < size; i++) {
      _listOrders.add(
        OrderModel(
          ord_uuid: RndX.genUUID(),
          ord_name: RndX.generateRandomCity().toString().toUpperCase(),
        ),
      );
    }

    return _listOrders;
  }

  static List<AssemblageModel> getMockAssemblages(int size) {
    if (_listAssemblages.isNotEmpty) {
      return _listAssemblages;
    }

    var ordersList = getMockOrders(2);

    final random = Random();

    for (int i = 0; i < size; i++) {
      String orderName = RndX.generateRandomCity();
      _listAssemblages.add(
        AssemblageModel(
          ass_uuid: RndX.genUUID(),
          ass_nome: orderName,
          ass_dt_fundacao: RndX.generateRandomDates(count: 1),
          ordem: ordersList[random.nextInt(ordersList.length)],
          ass_foto: RndX.getRandomAvatarUrl(email: orderName),
          ass_status: "active",
        ),
      );
    }

    return _listAssemblages;
  }

  static List<PackageTypeModel> getMockPackagesType() {
    if (_listPackagesTypes.isNotEmpty) {
      return _listPackagesTypes;
    }

    _listPackagesTypes.add(
      PackageTypeModel(
        tip_pac_uuid: RndX.genUUID(),
        tip_pac_nome: 'Iniciação',
      ),
    );
    _listPackagesTypes.add(
      PackageTypeModel(
        tip_pac_uuid: RndX.genUUID(),
        tip_pac_nome: 'Honraria 1',
      ),
    );
    _listPackagesTypes.add(
      PackageTypeModel(
        tip_pac_uuid: RndX.genUUID(),
        tip_pac_nome: 'Honraria 2',
      ),
    );

    return _listPackagesTypes;
  }

  static List<PackageModel> getMockPackages(int size) {
    if (_listPackageModel.isNotEmpty) {
      return _listPackageModel;
    }

    var packagesStatusList = ['waiting', 'approved', 'unapproved'];
    var packagesTypesList = getMockPackagesType();
    var assemblageList = getMockAssemblages(5);

    final random = Random();

    for (int i = 0; i < size; i++) {
      _listPackageModel.add(
        PackageModel(
            pac_uuid: RndX.genUUID(),
            pac_dt_evento: RndX.randomDateByAge(age: 0),
            assembleia: assemblageList[random.nextInt(assemblageList.length)],
            pac_status: "waiting",
            //packagesStatusList[random.nextInt(packagesStatusList.length)],
            tipo_pacote:
                packagesTypesList[random.nextInt(packagesTypesList.length)]),
      );
    }

    return _listPackageModel;
  }

  static _createUserAndProfile(String email) {
    UserModel user = UserModel(
      id: RndX.genUUID(),
      email: email,
    );
    final random = Random();

    UserProfileModel userProfile = UserProfileModel(
      id: RndX.genUUID(),
      name: RndX.generateName(),
      avatar_url:
          'https://robohash.org/${email.split('@')[0]}?set=set1&bgset=bg2&size=50x50',
      user_id: user.id,
    );
    _listUsersModel.add(user);
    _listUsersProfilesModel.add(userProfile);

    getMockAssemblages(3);
    AssemblageModel assemblage =
        _listAssemblages[random.nextInt(_listAssemblages.length)];

    _listFullUsersModel.add(
      UsersModel(
        usu_uuid: user.id,
        usu_email: user.email,
        usu_nome: '',
        perfil: UsersProfileModel(
          per_nome: userProfile.name,
        ),
        assembleia: user.email!.contains("0")
            ? null
            : AssemblageModel(
                ass_uuid: assemblage.ass_uuid,
                ass_nome: assemblage.ass_nome,
                ass_dt_fundacao: assemblage.ass_dt_fundacao,
                ordem: assemblage.ordem!,
                ass_foto: assemblage.ass_foto,
                ass_status: assemblage.ass_status,
              ),
      ),
    );
  }

  static List<UserModel> getMockUsers() {
    if (_listUsersModel.isNotEmpty) {
      return _listUsersModel;
    }

    _listAssemblages.clear();
    _listOrders.clear();
    _listFullUsersModel.clear();
    _listUsersProfilesModel.clear();

    for (var i = 0; i < 30; i++) {
      _createUserAndProfile("user$i@email.com");
    }

    return _listUsersModel;
  }

  static List<UserProfileModel> getMockUsersProfiles() {
    return _listUsersProfilesModel;
  }

  static List<UsersModel> getMockFullUsers() {
    return _listFullUsersModel;
  }

  static UsersModel insertUser(InsertUseAndProfileModel useAndProfileModel) {
    UserModel user = UserModel(
      id: RndX.genUUID(),
      email: useAndProfileModel.email,
    );
    final random = Random();

    UserProfileModel userProfile = UserProfileModel(
      id: RndX.genUUID(),
      name: useAndProfileModel.name,
      //avatar_url: RndX.getRandomAvatarUrl(email: user.email),
      user_id: user.id,
    );
    _listUsersModel.add(user);
    _listUsersProfilesModel.add(userProfile);

    getMockAssemblages(3);
    var index = _listAssemblages.indexWhere(
      (e) => e.ass_uuid == useAndProfileModel.assemblage_id,
    );
    AssemblageModel assemblage;
    if (index < 0) {
      assemblage = _listAssemblages[random.nextInt(_listAssemblages.length)];
    } else {
      assemblage = _listAssemblages[index];
    }

    UsersModel newUser = UsersModel(
      usu_uuid: user.id,
      usu_email: user.email,
      perfil: UsersProfileModel(
        per_nome: userProfile.name,
      ),
      assembleia: AssemblageModel(
        ass_uuid: assemblage.ass_uuid,
        ass_nome: assemblage.ass_nome,
        ass_dt_fundacao: assemblage.ass_dt_fundacao,
        ordem: assemblage.ordem!,
        ass_foto: assemblage.ass_foto,
        ass_status: assemblage.ass_status,
      ),
    );

    _listFullUsersModel.add(newUser);
    return newUser;
  }

  static PackageModel insertPackage({
    required PackageModel package,
    required UserModel authenticatedUser,
  }) {
    String packageId = RndX.genUUID();
    PackageModel newPackage = PackageModel(
        pac_uuid: packageId,
        pac_dt_evento: package.pac_dt_evento,
        tipo_pacote: package.tipo_pacote,
        pac_status: 'waiting',
        assembleia: package.assembleia,
        usuario_pacote_usu_id_criacao_fkTousuario:
            package.usuario_pacote_usu_id_criacao_fkTousuario,
        pac_dt_criacao: package.pac_dt_criacao,
        rel_pacote_usuario: package.rel_pacote_usuario!.map(
          (e) {
            return PackageUsersModel(
              rel_pac_usu_uuid: RndX.genUUID(),
              //package_id: packageId,
              usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario:
                  e.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario,
            );
          },
        ).toList());

    _listPackageModel.add(newPackage);

    return newPackage;
  }
}
