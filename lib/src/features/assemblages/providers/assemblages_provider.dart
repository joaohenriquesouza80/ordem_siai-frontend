import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/assemblages/models/assemblage_mode.dart';
import 'package:ordem_siai/src/features/assemblages/repositories/assemblages_repository.dart';
import 'package:ordem_siai/src/features/auth/providers/auth_provider.dart';
import 'package:ordem_siai/src/shared/providers/client_http/client_http_provider.dart';

class AssemblagesProvider with ChangeNotifier {
  late AssemblagesRepository repository;

  AssemblagesProvider(
      ClientHttpProvider clientHttpProvider, AuthProvider authProvider) {
    repository = AssemblagesRepository(clientHttpProvider, authProvider);
  }

  List<AssemblageModel> _assemblages = [];
  List<AssemblageModel> get assemblages => [..._assemblages];

  Future<void> loadAllAssemblages() async {
    _assemblages = [];

    _assemblages = await repository.getAllAssemblages();

    notifyListeners();
  }
}
