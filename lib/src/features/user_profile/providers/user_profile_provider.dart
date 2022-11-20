import 'dart:io';

import 'package:flutter/material.dart';

import '../../../shared/providers/client_http/client_http_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/user_profile_model.dart';
import '../repositories/user_profile_repository.dart';

class UserProfileProvider with ChangeNotifier {
  late UserProfileRepository _repository;
  late AuthProvider _authProvider;

  UserProfileProvider(
    ClientHttpProvider client,
    AuthProvider authProvider,
  ) {
    _repository = UserProfileRepository(client);
    _authProvider = authProvider;
  }

  UserProfileModel _profile = UserProfileModel();
  UserProfileModel get profile => _profile;

  bool _loaded = false;
  bool get loaded => _loaded;
  set loaded(bool isLoaded) => _loaded = isLoaded;

  Future<void> loadProfile() async {
    _loaded = false;
    _profile = UserProfileModel();

    _profile =
        await _repository.getUserProfile(_authProvider.authUser!.user.id!);

    _loaded = true;
    notifyListeners();
  }

  Future<void> saveUpdateProfile(UserProfileModel userProfileModel) async {
    //_profile = UserProfileModel();
    //_profile = await _repository.updateProfile(
    //  profileModel.user_name,
    //  profileModel.document,
    //);

    notifyListeners();
  }

  Future<void> saveUserAvatar(
    File fileAvatar,
    String userProfileId,
  ) async {
    // UserProfileModel profileUser = await _repository.updateUserAvatar(
    //   fileAvatar,
    //   //avatarFile,
    // );
    // if (profileUser.avatar_url == null ||
    //     profileUser.avatar_url!.isEmpty) {
    //   throw ('Erro ao salvar Avatar do Usuário. Tente Novamente.');
    // }

    // await loadProfile();
  }

  Future<void> deleteUserAccount(String password) async {
    // if (_profile.user_id == null) {
    //   throw ('Erro Interno ao Excluir a conta.\nPor favor, entre em contato com o nosso suporte através da opção "Ajuda".');
    // }

    // await _repository.deleteUserAccount(
    //   password: password,
    // );
  }
}
