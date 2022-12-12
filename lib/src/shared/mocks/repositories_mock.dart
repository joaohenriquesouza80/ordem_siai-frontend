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
import '../../features/users/models/users_profile_assemblage_model.dart';
import '../../features/users/models/users_profile_model.dart';
import '../../features/users/models/users_profile_order_model.dart';

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
          id: RndX.genUUID(),
          name: RndX.generateRandomCity().toString().toUpperCase(),
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
          id: RndX.genUUID(),
          name: orderName,
          foundation_date: RndX.generateRandomDates(count: 1),
          order: ordersList[random.nextInt(ordersList.length)],
          picture: RndX.getRandomAvatarUrl(email: orderName),
          status: "active",
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
        id: RndX.genUUID(),
        package_name: 'Iniciação',
      ),
    );
    _listPackagesTypes.add(
      PackageTypeModel(
        id: RndX.genUUID(),
        package_name: 'Honraria 1',
      ),
    );
    _listPackagesTypes.add(
      PackageTypeModel(
        id: RndX.genUUID(),
        package_name: 'Honraria 2',
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
            id: RndX.genUUID(),
            event_date_time: RndX.randomDateByAge(age: 0),
            assemblage: assemblageList[random.nextInt(assemblageList.length)],
            status: "waiting",
            //packagesStatusList[random.nextInt(packagesStatusList.length)],
            package_type:
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
        id: user.id,
        email: user.email,
        UserProfile: UsersProfileModel(
          name: userProfile.name,
          user_avatar_url: userProfile.avatar_url,
          order: UsersProfileOrderModel(
            id: assemblage.order!.id,
            name: assemblage.order!.name,
          ),
          assemblage: user.email!.contains("0")
              ? null
              : UsersProfileAssemblageModel(
                  id: assemblage.id,
                  name: assemblage.name,
                  foundation_date: assemblage.foundation_date,
                  order_id: assemblage.order!.id,
                  picture: assemblage.picture,
                  status: assemblage.status,
                ),
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
      (e) => e.id == useAndProfileModel.assemblage_id,
    );
    AssemblageModel assemblage;
    if (index < 0) {
      assemblage = _listAssemblages[random.nextInt(_listAssemblages.length)];
    } else {
      assemblage = _listAssemblages[index];
    }

    UsersModel newUser = UsersModel(
      id: user.id,
      email: user.email,
      UserProfile: UsersProfileModel(
        name: userProfile.name,
        user_avatar_url: userProfile.avatar_url,
        order: UsersProfileOrderModel(
          id: assemblage.order!.id,
          name: assemblage.order!.name,
        ),
        assemblage: UsersProfileAssemblageModel(
          id: assemblage.id,
          name: assemblage.name,
          foundation_date: assemblage.foundation_date,
          order_id: assemblage.order!.id,
          picture: assemblage.picture,
          status: assemblage.status,
        ),
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
        id: packageId,
        event_date_time: package.event_date_time,
        package_type: package.package_type,
        status: 'waiting',
        assemblage: package.assemblage,
        creator_user: package.creator_user,
        created_at: package.created_at,
        package_users: package.package_users!.map(
          (e) {
            return PackageUsersModel(
              id: RndX.genUUID(),
              package_id: packageId,
              user: e.user,
            );
          },
        ).toList());

    _listPackageModel.add(newPackage);

    return newPackage;
  }
}
