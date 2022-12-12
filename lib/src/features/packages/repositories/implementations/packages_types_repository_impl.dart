import 'dart:convert';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/providers/client_http/client_http_provider.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/package_type_model.dart';
import '../packages_types_repository.dart';

class PackagesTypesRepositoryImpl implements PackagesTypesRepository {
  final ClientHttpProvider clientHttpProvider;

  PackagesTypesRepositoryImpl(this.clientHttpProvider);

  @override
  Future<List<PackageTypeModel>> getAllPackagesTypes() async {
    const method = "/packages_types";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      final list =
          jsonDecode(responseHttp.responseData).cast<Map<String, dynamic>>();
      return list
          .map<PackageTypeModel>((item) => PackageTypeModel.fromMap(item))
          .toList();
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value([]);
  }
}
