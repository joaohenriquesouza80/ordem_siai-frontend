import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ordem_siai/src/shared/providers/client_http/client_http_no_auth_provider.dart';
import 'package:ordem_siai/src/shared/providers/client_http/models/client_http_response_model.dart';

import '../../../config/config.dart';

class ClientHttpNoAuthDio implements ClientHttpNoAuthProvider {
  final _client = Dio();

  ClientHttpNoAuthDio(BuildContext context) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Config.API_URL,
      connectTimeout: 30000,
      contentType: "application/json",
      responseType: ResponseType.plain,
      followRedirects: false,
      validateStatus: (status) {
        return ((status! < 500) && (status != 404));
      },
    );

    _client.options = baseOptions;
  }

  @override
  void setAuthHeader(bool withToken) {
    // TODO: implement setAuthHeader
  }

  @override
  void setTimeZoneHeader() {
    // TODO: implement setTimeZoneHeader
  }

  @override
  post(
      {required String method,
      required String jsonData,
      int timeout = 30000}) async {
    var path = _client.options.baseUrl + method;

    try {
      final response = await _client.post(
        path,
        data: jsonData,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      print(e);
      throw ("Erro interno");
    }
  }
}
