import 'package:ordem_siai/src/features/user_profile/repositories/user_profile_repository.dart';
import 'package:ordem_siai/src/features/users/models/insert_user_and_profile_model.dart';
import 'package:ordem_siai/src/features/users/repositories/implementations/users_repository_fake.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/users_models.dart';
import 'implementations/users_repository_impl.dart';
//import 'implementations/users_repository_impl.dart';

abstract class UsersRepository {
  Future<List<UsersModel>> getUsers();
  Future<UsersModel> insertUser(InsertUseAndProfileModel useAndProfileModel);
  Future<UsersModel> getUser(String userId);

  factory UsersRepository(
    ClientHttpProvider clientHttpProvider,
    AuthProvider authProvider,
  ) {
    return UsersRepositoryImpl(clientHttpProvider, authProvider);
    //return UsersRepositoryFake(authProvider);
  }
}
