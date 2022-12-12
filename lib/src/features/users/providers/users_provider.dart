import 'package:flutter/material.dart';

import 'package:ordem_siai/src/features/users/models/insert_user_and_profile_model.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/users_models.dart';
import '../repositories/users_repository.dart';

class UsersProvider with ChangeNotifier {
  late UsersRepository _repository;

  UsersProvider(
    ClientHttpProvider client,
    AuthProvider authProvider,
  ) {
    _repository = UsersRepository(
      client,
      authProvider,
    );
  }

  List<UsersModel> _users = [];
  List<UsersModel> get users => [..._users];

  Future<void> loadUsers() async {
    _users = [];

    _users = await _repository.getUsers();

    notifyListeners();
  }

  Future<void> insertUserAndProfile(
    InsertUseAndProfileModel useAndProfileModel,
  ) async {
    await _repository.insertUser(useAndProfileModel);
    await loadUsers();
  }

  Future<UsersModel> getUser(String userId) async {
    return await _repository.getUser(userId);
  }
}
