import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../shared/providers/client_http/client_http_no_auth_provider.dart';
import '../../../shared/providers/local_storage/local_storage_provider.dart';
import '../models/authenticated_user_model.dart';
import '../repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final LocalStorageProvider _localStorageProvider;
  final ClientHttpNoAuthProvider _clientHttp;

  late final AuthRepository _repository;

  AuthProvider(
    this._localStorageProvider,
    this._clientHttp,
  ) {
    _repository = AuthRepository(_clientHttp);
  }

  final String _authStorageKey = LocalStorageProvider.storageKey;
  static Timer? _logoutTimer;

  static AuthenticatedUserModel? _authUser;
  AuthenticatedUserModel? get authUser => _authUser;
  String getUserName({bool tryFromEmail = true}) {
    String userName = _authUser!.userName;
    if (userName.isEmpty && tryFromEmail) {
      userName = _authUser!.user.email!.split('@').first;
    }
    return userName;
  }

  bool get isAuth {
    return (_authUser != null) && (_authUser!.token.isNotEmpty);
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    _authUser = null;
    final result = await _repository.authenticateUser(
      email,
      password,
    );

    await _localStorageProvider.writeStorage(
      key: _authStorageKey,
      value: result.toJson(),
    );

    _authUser = result;
    _autoLogout();
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _authUser = null;
    final result = await _repository.signUpUser(
      email,
      password,
    );

    await _localStorageProvider.writeStorage(
      key: _authStorageKey,
      value: result.toJson(),
    );

    notifyListeners();
  }

  Future<void> logout() async {
    print('logout');
    _authUser = null;
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
      _logoutTimer = null;
    }
    await _localStorageProvider.deleteStorage(key: _authStorageKey);
    notifyListeners();
  }

  void _autoLogout() {
    print('auto-logout');
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
    }
    if (isAuth) {
      DateTime expirationDate = JwtDecoder.getExpirationDate(_authUser!.token);

      final timeToLogout = expirationDate.difference(DateTime.now()).inSeconds;
      _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    try {
      _authUser = null;

      final result = await _localStorageProvider.readStorage(
        key: _authStorageKey,
      );

      if (result.isEmpty) return;

      final tempAuth = AuthenticatedUserModel.fromJson(result);
      bool hasExpired = JwtDecoder.isExpired(tempAuth.token);

      if (hasExpired) {
        await _localStorageProvider.deleteStorage(
          key: _authStorageKey,
        );
        return;
      }

      _authUser = tempAuth;
    } catch (e) {
      print(e);
      return Future.value();
    }

    _autoLogout();
    notifyListeners();
    return Future.value();
  }
}
