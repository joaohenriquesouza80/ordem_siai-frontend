import 'package:ordem_siai/src/features/auth/repositories/implementations/auth_repository_fake.dart';

import '../../../shared/providers/client_http/client_http_no_auth_provider.dart';
import '../models/authenticated_user_model.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  bool isMock();

  Future<AuthenticatedUserModel> authenticateUser(
    String email,
    String password,
  );

  Future<UserModel> signUpUser(String email, String password);

  factory AuthRepository(ClientHttpNoAuthProvider clientHttpNoAuthProvider) {
    //return AuthRepositoryImpl(clientHttpNoAuthProvider);
    return AuthRepositoryFake();
  }
}
