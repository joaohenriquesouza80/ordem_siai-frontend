// ignore_for_file: null_argument_to_non_null_type

import 'dart:io';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/exceptions/http_response_model.dart';
import '../../../../shared/mocks/repositories_mock.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/user_profile_model.dart';
import '../user_profile_repository.dart';

class UserProfileRepositoryFake implements UserProfileRepository {
  UserProfileRepositoryFake();

  @override
  Future<UserProfileModel> getUserProfile(String userId) async {
    List<UserProfileModel> usersProfiles =
        RepositoriesMocks.getMockUsersProfiles();
    final index = usersProfiles.indexWhere(
      (u) => u.user_id == userId,
    );

    if (index >= 0) {
      return usersProfiles[index];
    }

    HttpResponseExceptions(
      ClientHttpResponseModel(
        statusCode: 204,
        responseData: HttpResponseModel().toJson(),
      ),
    ).toString();
    return Future.value(null);
  }

  @override
  Future<UserProfileModel> updateProfile(
    String? userName,
    String? document,
  ) async {
    return Future.value(null);
  }

  @override
  Future<UserProfileModel> saveProfile(
    String? userName,
    String? document,
  ) async {
    return Future.value();
  }

  @override
  Future<UserProfileModel> updateUserAvatar(
    File avatar,
  ) async {
    return Future.value();
  }

  @override
  Future<void> deleteUserAccount({
    required String password,
  }) async {
    return Future.value();
  }
}
