import 'dart:convert';

import 'package:ordem_siai/src/shared/providers/client_http/client_http_provider.dart';

import '../../../shared/exceptions/http_response_exceptions.dart';
import '../../../shared/providers/client_http/models/client_http_response_model.dart';
import '../models/users_models.dart';

class UsersRepository {
  final ClientHttpProvider clientHttpProvider;

  UsersRepository(this.clientHttpProvider);

  Future<List<UsersModel>> getUsers() async {
    const method = "/users";

    final ClientHttpResponseModel responseHttp = await clientHttpProvider.get(
      method: method,
      withToken: true,
    );

    if (responseHttp.statusCode == 200) {
      final list =
          jsonDecode(responseHttp.responseData).cast<Map<String, dynamic>>();
      return list.map<UsersModel>((item) => UsersModel.fromMap(item)).toList();
    }

    HttpResponseExceptions(responseHttp).toString();
    return Future.value([]);
  }
}
