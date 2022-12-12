// ignore_for_file: null_argument_to_non_null_type
import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/exceptions/http_response_model.dart';
import '../../../../shared/mocks/repositories_mock.dart';

import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../../auth/models/user_model.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../models/insert_user_and_profile_model.dart';
import '../../models/users_models.dart';
import '../users_repository.dart';

class UsersRepositoryFake implements UsersRepository {
  AuthProvider authProvider;

  UsersRepositoryFake(
    this.authProvider,
  );

  @override
  Future<List<UsersModel>> getUsers() async {
    List<UsersModel> usersModel = RepositoriesMocks.getMockFullUsers();
    usersModel.sort(
      (a, b) => a.UserProfile!.name!
          .toUpperCase()
          .compareTo(b.UserProfile!.name!.toUpperCase()),
    );
    String userId = authProvider.authUser!.user.id!;

    final index = usersModel.indexWhere(
      (u) => u.id == userId,
    );

    if (index < 0) {
      return [];
    }

    UsersModel user = usersModel[index];
    if (user.UserProfile?.assemblage == null) {
      return usersModel
          .where((e) => e.UserProfile?.order?.id == user.UserProfile?.order?.id)
          .toList();
    }
    return usersModel
        .where((e) =>
            (e.UserProfile?.assemblage?.id ==
                user.UserProfile?.assemblage?.id) ||
            ((e.UserProfile?.assemblage == null) &&
                (e.UserProfile?.order?.id == user.UserProfile?.order?.id)))
        .toList();
  }

  @override
  Future<UsersModel> insertUser(
      InsertUseAndProfileModel useAndProfileModel) async {
    List<UsersModel> usersModel = RepositoriesMocks.getMockFullUsers();
    UserModel authenticatedUser = authProvider.authUser!.user;

    final index = usersModel.indexWhere(
      (u) => u.email == useAndProfileModel.email,
    );

    if (index >= 0) {
      HttpResponseExceptions(
        ClientHttpResponseModel(
          statusCode: 400,
          responseData: HttpResponseModel(
            status: "error",
            message: "Email already exists",
            message_enum: "EMAIL_ADDRESS_ALREADY_IN_USE",
          ).toJson(),
        ),
      ).toString();
      return Future.value(null);
    }

    UsersModel newUser = RepositoriesMocks.insertUser(useAndProfileModel);

    return Future.value(newUser);
  }

  @override
  Future<UsersModel> getUser(String userId) {
    List<UsersModel> usersModel = RepositoriesMocks.getMockFullUsers();

    final index = usersModel.indexWhere(
      (u) => u.id == userId,
    );

    if (index >= 0) {
      return Future.value(usersModel[index]);
    }

    return Future.value(null);
  }
}
