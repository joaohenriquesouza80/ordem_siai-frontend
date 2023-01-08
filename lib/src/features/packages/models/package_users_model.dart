// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:ordem_siai/src/features/packages/models/package_model.dart';

import '../../users/models/users_models.dart';

class PackageUsersModel {
  String? rel_pac_usu_uuid;
  PackageModel? pacote;
  bool? rel_pac_usu_presenca;
  DateTime? rel_pac_usu_dt_presenca;
  String? rel_pac_usu_comentario;
  UsersModel? usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario;
  UsersModel? usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario;

  PackageUsersModel({
    this.rel_pac_usu_uuid,
    this.pacote,
    this.rel_pac_usu_presenca,
    this.rel_pac_usu_dt_presenca,
    this.rel_pac_usu_comentario,
    this.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario,
    this.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario,
  });

  PackageUsersModel copyWith({
    String? rel_pac_usu_uuid,
    PackageModel? pacote,
    bool? rel_pac_usu_presenca,
    DateTime? rel_pac_usu_dt_presenca,
    String? rel_pac_usu_comentario,
    UsersModel? usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario,
    UsersModel? usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario,
  }) {
    return PackageUsersModel(
      rel_pac_usu_uuid: rel_pac_usu_uuid ?? this.rel_pac_usu_uuid,
      pacote: pacote ?? this.pacote,
      rel_pac_usu_presenca: rel_pac_usu_presenca ?? this.rel_pac_usu_presenca,
      rel_pac_usu_dt_presenca:
          rel_pac_usu_dt_presenca ?? this.rel_pac_usu_dt_presenca,
      rel_pac_usu_comentario:
          rel_pac_usu_comentario ?? this.rel_pac_usu_comentario,
      usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario:
          usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario ??
              this.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario,
      usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario:
          usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario ??
              this.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (rel_pac_usu_uuid != null) {
      result.addAll({'rel_pac_usu_uuid': rel_pac_usu_uuid});
    }
    if (pacote != null) {
      result.addAll({'pacote': pacote!.toMap()});
    }
    if (rel_pac_usu_presenca != null) {
      result.addAll({'rel_pac_usu_presenca': rel_pac_usu_presenca});
    }
    if (rel_pac_usu_dt_presenca != null) {
      result.addAll({
        'rel_pac_usu_dt_presenca':
            rel_pac_usu_dt_presenca!.millisecondsSinceEpoch
      });
    }
    if (rel_pac_usu_comentario != null) {
      result.addAll({'rel_pac_usu_comentario': rel_pac_usu_comentario});
    }
    if (usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario != null) {
      result.addAll({
        'usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario':
            usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!.toMap()
      });
    }
    if (usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario != null) {
      result.addAll({
        'usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario':
            usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario!.toMap()
      });
    }

    return result;
  }

  factory PackageUsersModel.fromMap(Map<String, dynamic> map) {
    return PackageUsersModel(
      rel_pac_usu_uuid: map['rel_pac_usu_uuid'],
      pacote:
          map['pacote'] != null ? PackageModel.fromMap(map['pacote']) : null,
      rel_pac_usu_presenca: map['rel_pac_usu_presenca'],
      rel_pac_usu_dt_presenca: map['rel_pac_usu_dt_presenca'] != null
          ? DateTime.tryParse(map['rel_pac_usu_dt_presenca'])
          : null,
      rel_pac_usu_comentario: map['rel_pac_usu_comentario'],
      usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario:
          map['usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario'] != null
              ? UsersModel.fromMap(
                  map['usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario'])
              : null,
      usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario:
          map['usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario'] != null
              ? UsersModel.fromMap(
                  map['usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario'])
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageUsersModel.fromJson(String source) =>
      PackageUsersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageUsersModel(rel_pac_usu_uuid: $rel_pac_usu_uuid, pacote: $pacote, rel_pac_usu_presenca: $rel_pac_usu_presenca, rel_pac_usu_dt_presenca: $rel_pac_usu_dt_presenca, rel_pac_usu_comentario: $rel_pac_usu_comentario, usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario: $usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario, usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario: $usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageUsersModel &&
        other.rel_pac_usu_uuid == rel_pac_usu_uuid &&
        other.pacote == pacote &&
        other.rel_pac_usu_presenca == rel_pac_usu_presenca &&
        other.rel_pac_usu_dt_presenca == rel_pac_usu_dt_presenca &&
        other.rel_pac_usu_comentario == rel_pac_usu_comentario &&
        other.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario ==
            usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario &&
        other.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario ==
            usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario;
  }

  @override
  int get hashCode {
    return rel_pac_usu_uuid.hashCode ^
        pacote.hashCode ^
        rel_pac_usu_presenca.hashCode ^
        rel_pac_usu_dt_presenca.hashCode ^
        rel_pac_usu_comentario.hashCode ^
        usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario.hashCode ^
        usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario.hashCode;
  }
}
