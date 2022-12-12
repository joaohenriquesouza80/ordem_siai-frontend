import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../features/auth/providers/auth_provider.dart';
import '../../../config/config.dart';
import '../../../exceptions/http_response_model.dart';
import '../../time_zone/timezone_provider.dart';
import '../client_http_provider.dart';
import '../models/client_http_response_model.dart';

class ClientHttpDio implements ClientHttpProvider {
  final _client = Dio();
  final AuthProvider _authProvider;
  String _timezone = "";
  final BuildContext _context;

  ClientHttpDio(
    this._authProvider,
    this._context,
  ) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Config.API_URL,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      //headers: {"Content-Type": "application/json"},
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
  Future<void> setTimeZoneHeader() async {
    if (_timezone.isEmpty) {
      final timeZone = Provider.of<TimeZoneProvider>(_context, listen: false);
      _timezone = await timeZone.getLocalTimeZone();
      print('TimeZone Recovered: $_timezone');
    }

    _client.options.headers["time_zone"] = _timezone;
  }

  @override
  void setAuthHeader(bool withToken) {
    if (withToken) {
      var user = _authProvider.authUser;

      _client.options.headers["Authorization"] = '';
      if ((user != null) && (user.token.isNotEmpty)) {
        var token = user.token;
        var headerAuth = "Bearer $token";
        _client.options.headers["Authorization"] = headerAuth;
      }
    }
  }

  ClientHttpResponseModel _handleDioError(DioError e) {
    print(e);
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return ClientHttpResponseModel(
          statusCode: 408,
          responseData: HttpResponseModel(
            status: '408',
            message: e.message,
            message_enum: 'REQUEST_TIMEOUT',
          ).toJson(),
        );
      default:
        throw Exception("Erro interno");
    }
  }

  @override
  post({
    required String method,
    String? jsonData,
    bool withToken = true,
    Map<String, dynamic>? queryParameters,
    int timeout = 30000,
  }) async {
    final path = _client.options.baseUrl + method;

    _client.options.receiveTimeout = timeout;
    _client.options.connectTimeout = timeout;
    _client.options.sendTimeout = timeout;

    setAuthHeader(withToken);
    await setTimeZoneHeader();

    try {
      final response = await _client.post(
        path,
        data: jsonData,
        queryParameters: queryParameters,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  put({
    required String method,
    required String jsonData,
    bool withToken = true,
    int timeout = 30000,
  }) async {
    final path = _client.options.baseUrl + method;

    _client.options.receiveTimeout = timeout;
    _client.options.connectTimeout = timeout;
    _client.options.sendTimeout = timeout;

    setAuthHeader(withToken);
    await setTimeZoneHeader();

    try {
      final response = await _client.put(
        path,
        data: jsonData,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ClientHttpResponseModel> putFile({
    required String method,
    required File file,
    required String fileFormFieldName,
    bool withToken = true,
    int timeout = 30000,
  }) async {
    final path = _client.options.baseUrl + method;

    _client.options.receiveTimeout = timeout;
    _client.options.connectTimeout = timeout;
    _client.options.sendTimeout = timeout;

    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      fileFormFieldName: await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    setAuthHeader(withToken);
    await setTimeZoneHeader();

    try {
      final response = await _client.put(
        path,
        data: formData,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  get({
    required String method,
    bool withToken = true,
    Map<String, dynamic>? queryParameters,
    int timeout = 30000,
  }) async {
    final path = _client.options.baseUrl + method;

    _client.options.receiveTimeout = timeout;
    _client.options.connectTimeout = timeout;
    _client.options.sendTimeout = timeout;

    setAuthHeader(withToken);
    await setTimeZoneHeader();

    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ClientHttpResponseModel> delete({
    required String method,
    String? jsonData,
    bool withToken = true,
    int timeout = 30000,
  }) async {
    final path = _client.options.baseUrl + method;

    _client.options.receiveTimeout = timeout;
    _client.options.connectTimeout = timeout;
    _client.options.sendTimeout = timeout;

    setAuthHeader(withToken);
    await setTimeZoneHeader();

    try {
      final response = await _client.delete(
        path,
        data: jsonData,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ClientHttpResponseModel> patch({
    required String method,
    String? jsonData,
    bool withToken = true,
    Map<String, dynamic>? queryParameters,
    int timeout = 30000,
  }) async {
    final path = _client.options.baseUrl + method;

    _client.options.receiveTimeout = timeout;
    _client.options.connectTimeout = timeout;
    _client.options.sendTimeout = timeout;

    setAuthHeader(withToken);
    await setTimeZoneHeader();

    try {
      final response = await _client.patch(
        path,
        data: jsonData,
      );

      return ClientHttpResponseModel(
        statusCode: response.statusCode ?? 400,
        responseData: response.data,
      );
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }
}
