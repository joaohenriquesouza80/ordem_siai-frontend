import 'dart:convert';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/providers/client_http/client_http_provider.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/package_model.dart';
import '../packages_repository.dart';

class PackagesRepositoryImpl implements PackagesRepository {
  final ClientHttpProvider clientHttpProvider;

  PackagesRepositoryImpl(this.clientHttpProvider);

  @override
  Future<List<PackageModel>> getAllPackages() async {
    const method = "/packages";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      final list =
          jsonDecode(responseHttp.responseData).cast<Map<String, dynamic>>();
      return list
          .map<PackageModel>((item) => PackageModel.fromMap(item))
          .toList();
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value([]);
  }

  @override
  Future<PackageModel> insertPackage(PackageModel package) {
    // TODO: implement insertPackage
    throw UnimplementedError();
  }
}
