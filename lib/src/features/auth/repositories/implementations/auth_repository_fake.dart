// ignore_for_file: null_argument_to_non_null_type

import 'package:random_x/random_x.dart';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/exceptions/http_response_model.dart';
import '../../../../shared/mocks/repositories_mock.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/authenticated_user_model.dart';
import '../../models/user_model.dart';
import '../auth_repository.dart';

class AuthRepositoryFake implements AuthRepository {
  AuthRepositoryFake();

  @override
  bool isMock() {
    return true;
  }

  @override
  Future<AuthenticatedUserModel> authenticateUser(
    String email,
    String password,
  ) async {
    List<UserModel> users = RepositoriesMocks.getMockUsers();
    final index = users.indexWhere(
      (u) => u.email == email,
    );

    if ((index >= 0) && (password == '123456')) {
      return AuthenticatedUserModel(
        user: users[index],
        token: RndX.genUUID(),
      );
    }

    HttpResponseExceptions(
      ClientHttpResponseModel(
        statusCode: 401,
        responseData: HttpResponseModel(
          status: "error",
          message: "Incorrect email/password combination",
          message_enum: "INCORRECT_EMAIL_PASSWORD_COMBINATION",
        ).toJson(),
      ),
    ).toString();
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
