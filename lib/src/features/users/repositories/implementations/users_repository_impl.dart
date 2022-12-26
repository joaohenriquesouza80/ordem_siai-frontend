import 'dart:convert';

import 'package:ordem_siai/src/features/auth/providers/auth_provider.dart';
import 'package:ordem_siai/src/shared/providers/client_http/client_http_provider.dart';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/insert_user_and_profile_model.dart';
import '../../models/users_models.dart';
import '../users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final ClientHttpProvider clientHttpProvider;
  final AuthProvider authProvider;

  UsersRepositoryImpl(
    this.clientHttpProvider,
    this.authProvider,
  );

  @override
  Future<List<UsersModel>> getUsers() async {
    const method = "/users";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      final list =
          jsonDecode(responseHttp.responseData).cast<Map<String, dynamic>>();
      return list.map<UsersModel>((item) => UsersModel.fromMap(item)).toList();
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value([]);
  }

  @override
  Future<UsersModel> insertUser(
      InsertUseAndProfileModel useAndProfileModel) async {
    const method = "/users";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.post(
      method: method,
      withToken: true,
      jsonData: useAndProfileModel.toJson(),
    );

    if (responseHttp.statusCode == 201) {
      return UsersModel.fromJson(responseHttp.responseData);
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value(null);
  }

  @override
  Future<UsersModel> getUser(String userId) async {
    var method = "/users/$userId";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      return UsersModel.fromJson(responseHttp.responseData);
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value(null);
  }
}
