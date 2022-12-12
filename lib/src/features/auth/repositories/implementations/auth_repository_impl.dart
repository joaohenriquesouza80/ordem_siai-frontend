// ignore_for_file: null_argument_to_non_null_type

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/providers/client_http/client_http_no_auth_provider.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../dtos/auth_request_dto.dart';
import '../../models/authenticated_user_model.dart';
import '../../models/user_model.dart';
import '../auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ClientHttpNoAuthProvider _client;

  AuthRepositoryImpl(this._client);

  @override
  bool isMock() {
    return false;
  }

  @override
  Future<AuthenticatedUserModel> authenticateUser(
    String email,
    String password,
  ) async {
    const method = "/auth";

    AuthRequestDTO authRequest = AuthRequestDTO(
      email: email,
      password: password,
    );

    final ClientHttpResponseModel responseHttp = await _client.post(
      method: method,
      jsonData: authRequest.toJson(),
    );

    if (responseHttp.statusCode == 200) {
      return AuthenticatedUserModel.fromJson(responseHttp.responseData);
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value(null);
  }

  @override
  Future<UserModel> signUpUser(String email, String password) async {
    /*const method = "/users";

    SignUpRequestDTO signUpRequestDTO = SignUpRequestDTO(
      email: email,
      password: password,
    );

    final ClientHttpResponseDTO responseHttp = await _client.post(
      method: method,
      jsonData: signUpRequestDTO.toJson(),
    );

    if (responseHttp.statusCode == 201) {
      return UserModel.fromJson(responseHttp.responseData);
    }

    HttpResponseExceptions(responseHttp).toString();*/
    return Future.value(null);
  }
}
