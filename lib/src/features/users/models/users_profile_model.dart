// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UsersProfileModel {
  String? per_uuid;
  String? per_nome;

  UsersProfileModel({
    this.per_uuid,
    this.per_nome,
  });

  UsersProfileModel copyWith({
    String? per_uuid,
    String? per_nome,
  }) {
    return UsersProfileModel(
      per_uuid: per_uuid ?? this.per_uuid,
      per_nome: per_nome ?? this.per_nome,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (per_uuid != null) {
      result.addAll({'per_uuid': per_uuid});
    }
    if (per_nome != null) {
      result.addAll({'per_nome': per_nome});
    }

    return result;
  }

  factory UsersProfileModel.fromMap(Map<String, dynamic> map) {
    return UsersProfileModel(
      per_uuid: map['per_uuid'],
      per_nome: map['per_nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersProfileModel.fromJson(String source) =>
      UsersProfileModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UsersProfileModel(per_uuid: $per_uuid, per_nome: $per_nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersProfileModel &&
        other.per_uuid == per_uuid &&
        other.per_nome == per_nome;
  }

  @override
  int get hashCode => per_uuid.hashCode ^ per_nome.hashCode;
}
