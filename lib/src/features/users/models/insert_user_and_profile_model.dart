// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class InsertUseAndProfileModel {
  final String email;
  final String name;
  final String assemblage_id;
  final String password;

  InsertUseAndProfileModel({
    required this.email,
    required this.name,
    required this.assemblage_id,
    required this.password,
  });

  InsertUseAndProfileModel copyWith({
    String? email,
    String? name,
    String? assemblage_id,
    String? password,
  }) {
    return InsertUseAndProfileModel(
      email: email ?? this.email,
      name: name ?? this.name,
      assemblage_id: assemblage_id ?? this.assemblage_id,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'assemblage_id': assemblage_id});
    result.addAll({'password': password});

    return result;
  }

  factory InsertUseAndProfileModel.fromMap(Map<String, dynamic> map) {
    return InsertUseAndProfileModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      assemblage_id: map['assemblage_id'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InsertUseAndProfileModel.fromJson(String source) =>
      InsertUseAndProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InsertUseAndProfileModel(email: $email, name: $name, assemblage_id: $assemblage_id, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InsertUseAndProfileModel &&
        other.email == email &&
        other.name == name &&
        other.assemblage_id == assemblage_id &&
        other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        assemblage_id.hashCode ^
        password.hashCode;
  }
}
