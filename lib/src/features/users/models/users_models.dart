// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:ordem_siai/src/features/assemblages/models/assemblage_mode.dart';

import 'users_profile_model.dart';

class UsersModel {
  String? usu_uuid;
  String? usu_email;
  String? usu_nome;
  String? usu_foto;
  UsersProfileModel? perfil;
  AssemblageModel? assembleia;

  UsersModel({
    this.usu_uuid,
    this.usu_email,
    this.usu_nome,
    this.usu_foto,
    this.perfil,
    this.assembleia,
  });

  UsersModel copyWith({
    String? usu_uuid,
    String? usu_email,
    String? usu_nome,
    String? usu_foto,
    UsersProfileModel? perfil,
    AssemblageModel? assembleia,
  }) {
    return UsersModel(
      usu_uuid: usu_uuid ?? this.usu_uuid,
      usu_email: usu_email ?? this.usu_email,
      usu_nome: usu_nome ?? this.usu_nome,
      usu_foto: usu_foto ?? this.usu_foto,
      perfil: perfil ?? this.perfil,
      assembleia: assembleia ?? this.assembleia,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (usu_uuid != null) {
      result.addAll({'usu_uuid': usu_uuid});
    }
    if (usu_email != null) {
      result.addAll({'usu_email': usu_email});
    }
    if (usu_nome != null) {
      result.addAll({'usu_nome': usu_nome});
    }
    if (usu_foto != null) {
      result.addAll({'usu_foto': usu_foto});
    }
    if (perfil != null) {
      result.addAll({'perfil': perfil!.toMap()});
    }
    if (assembleia != null) {
      result.addAll({'assembleia': assembleia!.toMap()});
    }

    return result;
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      usu_uuid: map['usu_uuid'],
      usu_email: map['usu_email'],
      usu_nome: map['usu_nome'],
      usu_foto: map['usu_foto'],
      perfil: map['perfil'] != null
          ? UsersProfileModel.fromMap(map['perfil'])
          : null,
      assembleia: map['assembleia'] != null
          ? AssemblageModel.fromMap(map['assembleia'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersModel.fromJson(String source) =>
      UsersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsersModel(usu_uuid: $usu_uuid, usu_email: $usu_email, usu_nome: $usu_nome, usu_foto: $usu_foto, perfil: $perfil, assembleia: $assembleia)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersModel &&
        other.usu_uuid == usu_uuid &&
        other.usu_email == usu_email &&
        other.usu_nome == usu_nome &&
        other.usu_foto == usu_foto &&
        other.perfil == perfil &&
        other.assembleia == assembleia;
  }

  @override
  int get hashCode {
    return usu_uuid.hashCode ^
        usu_email.hashCode ^
        usu_nome.hashCode ^
        usu_foto.hashCode ^
        perfil.hashCode ^
        assembleia.hashCode;
  }
}
