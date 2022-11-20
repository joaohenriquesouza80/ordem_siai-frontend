import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/users/models/users_models.dart';
import 'package:ordem_siai/src/shared/providers/client_http/client_http_provider.dart';

import '../repositories/users_repository.dart';

class UsersProvider with ChangeNotifier {
  late UsersRepository _repository;

  UsersProvider(ClientHttpProvider client) {
    _repository = UsersRepository(client);
  }

  List<UsersModel> _users = [];
  List<UsersModel> get users => [..._users];

  Future<void> loadUsers() async {
    _users = [];

    _users = await _repository.getUsers();

    notifyListeners();
  }
}
