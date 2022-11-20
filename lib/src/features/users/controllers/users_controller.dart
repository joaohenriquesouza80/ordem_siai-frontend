import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users_provider.dart';

class UsersController {
  final BuildContext _context;

  UsersController(this._context);

  Future<void> loadUsers(BuildContext context) async {
    UsersProvider usersProvider = Provider.of(
      context,
      listen: false,
    );

    await usersProvider.loadUsers();
  }
}
