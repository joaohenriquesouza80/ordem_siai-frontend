import 'dart:convert';

import '../../../../shared/exceptions/http_response_exceptions.dart';
import '../../../../shared/providers/client_http/client_http_provider.dart';
import '../../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../../models/assemblage_mode.dart';
import '../assemblages_repository.dart';

class AssemblagesRepositoryImpl implements AssemblagesRepository {
  final ClientHttpProvider clientHttpProvider;

  AssemblagesRepositoryImpl(this.clientHttpProvider);

  @override
  Future<List<AssemblageModel>> getAllAssemblages(String orderId) async {
    var method = "/orders/$orderId/assemblages";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      final list =
          jsonDecode(responseHttp.responseData).cast<Map<String, dynamic>>();
      return list
          .map<AssemblageModel>((item) => AssemblageModel.fromMap(item))
          .toList();
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value([]);
  }
}
