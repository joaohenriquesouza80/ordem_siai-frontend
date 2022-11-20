import 'package:flutter/material.dart';

import 'implementations/client_http_no_auth_dio.dart';

abstract class ClientHttpNoAuthProvider {
  void setAuthHeader(
    bool withToken,
  );

  void setTimeZoneHeader();

  post({
    required String method,
    required String jsonData,
    int timeout = 30000,
  });

  factory ClientHttpNoAuthProvider(BuildContext context) {
    return ClientHttpNoAuthDio(context);
  }
}
