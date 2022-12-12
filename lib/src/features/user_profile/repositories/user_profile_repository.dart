import 'dart:io';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../models/user_profile_model.dart';
import 'implementations/user_profile_repository_fake.dart';
//import 'implementations/user_profile_repository_impl.dart';

abstract class UserProfileRepository {
  Future<UserProfileModel> getUserProfile(String userId);

  Future<UserProfileModel> updateProfile(
    String? userName,
    String? document,
  );

  Future<UserProfileModel> saveProfile(
    String? userName,
    String? document,
  );

  Future<UserProfileModel> updateUserAvatar(
    File avatar,
  );

  Future<void> deleteUserAccount({
    required String password,
  });

  factory UserProfileRepository(ClientHttpProvider clientHttpProvider) {
    //return UserProfileRepositoryImpl(clientHttpProvider);
    return UserProfileRepositoryFake();
  }
}
