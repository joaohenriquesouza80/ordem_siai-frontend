import 'dart:io';

import '../../../shared/exceptions/http_response_exceptions.dart';
import '../../../shared/providers/client_http/client_http_provider.dart';
import '../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository {
  final ClientHttpProvider _client;

  UserProfileRepository(this._client);

  Future<UserProfileModel> getUserProfile(String userId) async {
    final method = '/users/$userId/profile';

    final ClientHttpResponseModel responseHttp = await _client.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      return UserProfileModel.fromJson(responseHttp.responseData);
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value();
  }

  Future<UserProfileModel> updateProfile(
    String? userName,
    String? document,
  ) async {
    //const method = '/users/profile';

    //final request = ProfileRequestDto(
    //  user_name: userName,
    //  document: document,
    //);

    // final ClientHttpResponseDTO responseHttp = await _client.put(
    //   method: method,
    //   jsonData: request.toJson(),
    //   withToken: true,
    // );

    // if (responseHttp.statusCode == 200) {
    //   final response = ProfileModel.fromJson(responseHttp.responseData);
    //   return response;
    // } else if ((responseHttp.statusCode == 400) &&
    //     responseHttp.responseData.contains('USER_PROFILE_NOT_FOUND')) {
    //   return this.saveProfile(userName, document);
    // }

    // HttpResponseExceptions(responseHttp).toString();
    return Future.value();
  }

  Future<UserProfileModel> saveProfile(
    String? userName,
    String? document,
  ) async {
    // const method = '/users/profile';

    // final request = ProfileRequestDto(
    //   user_name: userName,
    //   document: document,
    // );

    // final ClientHttpResponseDTO responseHttp = await _client.post(
    //   method: method,
    //   jsonData: request.toJson(),
    //   withToken: true,
    // );

    // if (responseHttp.statusCode == 200) {
    //   final response = ProfileModel.fromJson(responseHttp.responseData);
    //   return response;
    // }
    // HttpResponseExceptions(responseHttp).toString();
    return Future.value();
  }

  Future<UserProfileModel> updateUserAvatar(
    File avatar,
  ) async {
    // const method = "/users/profile/avatar";

    // final ClientHttpResponseDTO responseHttp = await _client.putFile(
    //   method: method,
    //   file: avatar,
    //   fileFormFieldName: 'user_avatar',
    //   withToken: true,
    // );

    // if (responseHttp.statusCode == 200) {
    //   final response = ProfileModel.fromJson(responseHttp.responseData);
    //   return response;
    // }

    // HttpResponseExceptions(responseHttp).toString();
    return Future.value();
  }

  Future<void> deleteUserAccount({
    required String password,
  }) async {
    // const method = '/users';

    // final request = DeleteUserAccountDTO(
    //   password: password,
    // );

    // final ClientHttpResponseDTO responseHttp = await _client.delete(
    //   method: method,
    //   jsonData: request.toJson(),
    //   withToken: true,
    // );

    // if (responseHttp.statusCode == 200) {
    //   return;
    // }

    // HttpResponseExceptions(responseHttp).toString();

    return Future.value();
  }
}
