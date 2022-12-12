import 'package:flutter/material.dart';
import 'package:ordem_siai/src/shared/providers/client_http/client_http_provider.dart';

import '../models/package_type_model.dart';
import '../repositories/packages_types_repository.dart';

class PackagesTypesProvider with ChangeNotifier {
  late PackagesTypesRepository repository;

  PackagesTypesProvider(ClientHttpProvider clientHttpProvider) {
    repository = PackagesTypesRepository(clientHttpProvider);
  }

  List<PackageTypeModel> _packagesTypes = [];
  List<PackageTypeModel> get packagesTypes => [..._packagesTypes];

  Future<void> loadAllPackagesTypes() async {
    _packagesTypes = [];

    _packagesTypes = await repository.getAllPackagesTypes();

    notifyListeners();
  }
}
