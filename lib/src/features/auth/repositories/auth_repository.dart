import 'package:ordem_siai/src/shared/providers/client_http/client_http_no_auth_provider.dart';
import 'package:ordem_siai/src/shared/providers/client_http/models/client_http_response_model.dart';

import '../../../shared/exceptions/http_response_exceptions.dart';
import '../dtos/auth_request_dto.dart';
import '../models/authenticated_user_model.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ClientHttpNoAuthProvider _client;

  AuthRepository(this._client);

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
    return Future.value();
  }

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
    return Future.value();
  }
}
