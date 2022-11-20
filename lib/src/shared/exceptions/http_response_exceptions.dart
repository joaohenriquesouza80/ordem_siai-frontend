import '../providers/client_http/models/client_http_response_model.dart';
import 'http_response_model.dart';

class HttpResponseExceptions implements Exception {
  static const Map<String, String> _errors = {
    'AUTHENTICATION_REQUIRED': 'Usuário não esta autenticado',
    'EMAIL_ADDRESS_ALREADY_IN_USE': 'Email já esta sendo utilizado no APP',
    'ERROR_SENDING_EMAIL':
        'Erro ao enviar email com reset da senha.\nTente novamente mais tarde.',
    'INCORRECT_EMAIL_PASSWORD_COMBINATION': 'Email ou Senha inválidos',
    'PASSWORD_INCORRECT': 'Senha atual não esta correta',
    'REQUEST_TIMEOUT': '[ERRO INTERNO]:\nTempo limite de conexão atingido.',
    'TOO_MANY_REQUESTS':
        'Muitas requisições simultâneas. Aguarde para tentar novamente.',
    'USER_NOT_FOUND': 'Usuário não encontrado',
    'USER_NOT_ADMIN': 'Necessário um Usuário administrador',
    'USER_PROFILE_NOT_FOUND': 'Perfil de usuário não encontrado',
    'REQUEST_VALIDATION_ERROR':
        "Dados inválidos. Valide-os e tente novamente por favor.",
    'USER_PROFILE_WITHOUT_PRINCIPAL_DATA':
        'Usuário sem documento informado no perfil.',
  };

  final ClientHttpResponseModel httpResponse;

  HttpResponseExceptions(this.httpResponse);

  @override
  String toString({bool throwException = true}) {
    print(httpResponse.responseData);
    final httpResponseModel =
        HttpResponseModel.fromJson(httpResponse.responseData);

    String? messageError;
    if (httpResponseModel.message == "celebrate request validation failed") {
      messageError = _errors['REQUEST_VALIDATION_ERROR'];
    } else {
      final msgNotEnum =
          'Erro não esperado:\n${httpResponseModel.message_enum ?? httpResponseModel.message ?? ''}';
      messageError = _errors[httpResponseModel.message_enum] ?? msgNotEnum;
    }

    if (throwException) {
      throw (messageError ?? 'Erro');
    }

    return messageError ?? 'Erro';
  }
}
