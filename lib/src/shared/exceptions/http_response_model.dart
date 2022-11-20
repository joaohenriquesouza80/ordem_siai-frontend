// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class HttpResponseModel {
  final String? status;
  final String? message;
  final String? message_enum;
  final String? validation;

  HttpResponseModel({
    this.status,
    this.message,
    this.message_enum,
    this.validation,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'message_enum': message_enum,
      'validation': validation,
    };
  }

  factory HttpResponseModel.fromMap(Map<String, dynamic> map) {
    String? statusValue = map.containsKey('status')
        ? map['status']
        : map.containsKey('statusCode')
            ? map['statusCode'].toString()
            : null;
    String? validationValue =
        map.containsKey('validation') ? map['validation'].toString() : null;
    return HttpResponseModel(
      status: statusValue,
      message: map['message'],
      message_enum: map['message_enum'],
      validation: validationValue,
    );
  }

  String toJson() => json.encode(toMap());

  factory HttpResponseModel.fromJson(String source) =>
      HttpResponseModel.fromMap(json.decode(source));

  HttpResponseModel copyWith({
    String? status,
    String? message,
    String? message_enum,
    String? validation,
  }) {
    return HttpResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      message_enum: message_enum ?? this.message_enum,
      validation: validation ?? this.validation,
    );
  }

  @override
  String toString() {
    return 'HttpResponseModel(status: $status, message: $message, message_enum: $message_enum, validation: $validation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HttpResponseModel &&
        other.status == status &&
        other.message == message &&
        other.message_enum == message_enum &&
        other.validation == validation;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        message_enum.hashCode ^
        validation.hashCode;
  }
}
