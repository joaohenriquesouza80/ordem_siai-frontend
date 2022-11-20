import 'dart:io';
import 'package:flutter/material.dart';

import '../../../features/auth/providers/auth_provider.dart';
import 'implementations/client_http_dio.dart';

abstract class ClientHttpProvider {
  void setAuthHeader(
    bool withToken,
  );

  void setTimeZoneHeader();

  post({
    required String method,
    String? jsonData,
    bool withToken = true,
    Map<String, dynamic>? queryParameters,
    int timeout = 30000,
  });

  put({
    required String method,
    required String jsonData,
    bool withToken = true,
    int timeout = 30000,
  });

  patch({
    required String method,
    String? jsonData,
    bool withToken = true,
    Map<String, dynamic>? queryParameters,
    int timeout = 30000,
  });

  putFile({
    required String method,
    required File file,
    required String fileFormFieldName,
    bool withToken = true,
    int timeout = 30000,
  });

  get({
    required String method,
    bool withToken = true,
    Map<String, dynamic>? queryParameters,
    int timeout = 30000,
  });

  delete({
    required String method,
    String? jsonData,
    bool withToken = true,
    int timeout = 30000,
  });

  factory ClientHttpProvider(AuthProvider authProvider, BuildContext context) {
    return ClientHttpDio(authProvider, context);
  }
}
