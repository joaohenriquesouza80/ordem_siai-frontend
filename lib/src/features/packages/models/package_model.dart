// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../assemblages/models/assemblage_mode.dart';
import '../../users/models/users_models.dart';
import 'package_type_model.dart';
import 'package_users_model.dart';

class PackageModel {
  int? pac_id;
  int? tip_pac_id_fk;
  int? ass_id_assembleia_fk;
  String? pac_uuid;
  DateTime? pac_dt_evento;
  DateTime? pac_dt_criacao;
  DateTime? pac_dt_aprovacao;
  String? pac_status;
  PackageTypeModel? tipo_pacote;
  AssemblageModel? assembleia;
  int? usu_id_aprovacao_fk;
  int? usu_id_criacao_fk;
  String? pac_comentario_aprovacao;
  DateTime? pac_dt_modificacao;
  UsersModel? usuario_pacote_usu_id_criacao_fkTousuario;
  UsersModel? usuario_pacote_usu_id_aprovacao_fkTousuario;
  List<PackageUsersModel>? rel_pacote_usuario;
  PackageModel({
    this.pac_id,
    this.tip_pac_id_fk,
    this.ass_id_assembleia_fk,
    this.pac_uuid,
    this.pac_dt_evento,
    this.pac_dt_criacao,
    this.pac_dt_aprovacao,
    this.pac_status,
    this.tipo_pacote,
    this.assembleia,
    this.usu_id_aprovacao_fk,
    this.usu_id_criacao_fk,
    this.pac_comentario_aprovacao,
    this.pac_dt_modificacao,
    this.usuario_pacote_usu_id_criacao_fkTousuario,
    this.usuario_pacote_usu_id_aprovacao_fkTousuario,
    this.rel_pacote_usuario,
  });

  PackageModel copyWith({
    int? pac_id,
    int? tip_pac_id_fk,
    int? ass_id_assembleia_fk,
    String? pac_uuid,
    DateTime? pac_dt_evento,
    DateTime? pac_dt_criacao,
    DateTime? pac_dt_aprovacao,
    String? pac_status,
    PackageTypeModel? tipo_pacote,
    AssemblageModel? assembleia,
    int? usu_id_aprovacao_fk,
    int? usu_id_criacao_fk,
    String? pac_comentario_aprovacao,
    DateTime? pac_dt_modificacao,
    UsersModel? usuario_pacote_usu_id_criacao_fkTousuario,
    UsersModel? usuario_pacote_usu_id_aprovacao_fkTousuario,
    List<PackageUsersModel>? rel_pacote_usuario,
  }) {
    return PackageModel(
      pac_id: pac_id ?? this.pac_id,
      tip_pac_id_fk: tip_pac_id_fk ?? this.tip_pac_id_fk,
      ass_id_assembleia_fk: ass_id_assembleia_fk ?? this.ass_id_assembleia_fk,
      pac_uuid: pac_uuid ?? this.pac_uuid,
      pac_dt_evento: pac_dt_evento ?? this.pac_dt_evento,
      pac_dt_criacao: pac_dt_criacao ?? this.pac_dt_criacao,
      pac_dt_aprovacao: pac_dt_aprovacao ?? this.pac_dt_aprovacao,
      pac_status: pac_status ?? this.pac_status,
      tipo_pacote: tipo_pacote ?? this.tipo_pacote,
      assembleia: assembleia ?? this.assembleia,
      usu_id_aprovacao_fk: usu_id_aprovacao_fk ?? this.usu_id_aprovacao_fk,
      usu_id_criacao_fk: usu_id_criacao_fk ?? this.usu_id_criacao_fk,
      pac_comentario_aprovacao:
          pac_comentario_aprovacao ?? this.pac_comentario_aprovacao,
      pac_dt_modificacao: pac_dt_modificacao ?? this.pac_dt_modificacao,
      usuario_pacote_usu_id_criacao_fkTousuario:
          usuario_pacote_usu_id_criacao_fkTousuario ??
              this.usuario_pacote_usu_id_criacao_fkTousuario,
      usuario_pacote_usu_id_aprovacao_fkTousuario:
          usuario_pacote_usu_id_aprovacao_fkTousuario ??
              this.usuario_pacote_usu_id_aprovacao_fkTousuario,
      rel_pacote_usuario: rel_pacote_usuario ?? this.rel_pacote_usuario,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (pac_id != null) {
      result.addAll({'pac_id': pac_id});
    }
    if (tip_pac_id_fk != null) {
      result.addAll({'tip_pac_id_fk': tip_pac_id_fk});
    }
    if (ass_id_assembleia_fk != null) {
      result.addAll({'ass_id_assembleia_fk': ass_id_assembleia_fk});
    }
    if (pac_uuid != null) {
      result.addAll({'pac_uuid': pac_uuid});
    }
    if (pac_dt_evento != null) {
      result.addAll({'pac_dt_evento': pac_dt_evento!.millisecondsSinceEpoch});
    }
    if (pac_dt_criacao != null) {
      result.addAll({'pac_dt_criacao': pac_dt_criacao!.millisecondsSinceEpoch});
    }
    if (pac_dt_aprovacao != null) {
      result.addAll(
          {'pac_dt_aprovacao': pac_dt_aprovacao!.millisecondsSinceEpoch});
    }
    if (pac_status != null) {
      result.addAll({'pac_status': pac_status});
    }
    if (tipo_pacote != null) {
      result.addAll({'tipo_pacote': tipo_pacote!.toMap()});
    }
    if (assembleia != null) {
      result.addAll({'assembleia': assembleia!.toMap()});
    }
    if (usu_id_aprovacao_fk != null) {
      result.addAll({'usu_id_aprovacao_fk': usu_id_aprovacao_fk});
    }
    if (usu_id_criacao_fk != null) {
      result.addAll({'usu_id_criacao_fk': usu_id_criacao_fk});
    }
    if (pac_comentario_aprovacao != null) {
      result.addAll({'pac_comentario_aprovacao': pac_comentario_aprovacao});
    }
    if (pac_dt_modificacao != null) {
      result.addAll(
          {'pac_dt_modificacao': pac_dt_modificacao!.millisecondsSinceEpoch});
    }
    if (usuario_pacote_usu_id_criacao_fkTousuario != null) {
      result.addAll({
        'usuario_pacote_usu_id_criacao_fkTousuario':
            usuario_pacote_usu_id_criacao_fkTousuario!.toMap()
      });
    }
    if (usuario_pacote_usu_id_aprovacao_fkTousuario != null) {
      result.addAll({
        'usuario_pacote_usu_id_aprovacao_fkTousuario':
            usuario_pacote_usu_id_aprovacao_fkTousuario!.toMap()
      });
    }
    if (rel_pacote_usuario != null) {
      result.addAll({
        'rel_pacote_usuario':
            rel_pacote_usuario!.map((x) => x?.toMap()).toList()
      });
    }

    return result;
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      pac_id: map['pac_id']?.toInt(),
      tip_pac_id_fk: map['tip_pac_id_fk']?.toInt(),
      ass_id_assembleia_fk: map['ass_id_assembleia_fk']?.toInt(),
      pac_uuid: map['pac_uuid'],
      pac_dt_evento: map['pac_dt_evento'] != null
          ? DateTime.tryParse(map['pac_dt_evento'])
          : null,
      pac_dt_criacao: map['pac_dt_criacao'] != null
          ? DateTime.tryParse(map['pac_dt_criacao'])
          : null,
      pac_dt_aprovacao: map['pac_dt_aprovacao'] != null
          ? DateTime.tryParse(map['pac_dt_aprovacao'])
          : null,
      pac_status: map['pac_status'],
      tipo_pacote: map['tipo_pacote'] != null
          ? PackageTypeModel.fromMap(map['tipo_pacote'])
          : null,
      assembleia: map['assembleia'] != null
          ? AssemblageModel.fromMap(map['assembleia'])
          : null,
      usu_id_aprovacao_fk: map['usu_id_aprovacao_fk']?.toInt(),
      usu_id_criacao_fk: map['usu_id_criacao_fk']?.toInt(),
      pac_comentario_aprovacao: map['pac_comentario_aprovacao'],
      pac_dt_modificacao: map['pac_dt_modificacao'] != null
          ? DateTime.tryParse(map['pac_dt_modificacao'])
          : null,
      usuario_pacote_usu_id_criacao_fkTousuario:
          map['usuario_pacote_usu_id_criacao_fkTousuario'] != null
              ? UsersModel.fromMap(
                  map['usuario_pacote_usu_id_criacao_fkTousuario'])
              : null,
      usuario_pacote_usu_id_aprovacao_fkTousuario:
          map['usuario_pacote_usu_id_aprovacao_fkTousuario'] != null
              ? UsersModel.fromMap(
                  map['usuario_pacote_usu_id_aprovacao_fkTousuario'])
              : null,
      rel_pacote_usuario: map['rel_pacote_usuario'] != null
          ? List<PackageUsersModel>.from(map['rel_pacote_usuario']
              ?.map((x) => PackageUsersModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageModel(pac_id: $pac_id, tip_pac_id_fk: $tip_pac_id_fk, ass_id_assembleia_fk: $ass_id_assembleia_fk, pac_uuid: $pac_uuid, pac_dt_evento: $pac_dt_evento, pac_dt_criacao: $pac_dt_criacao, pac_dt_aprovacao: $pac_dt_aprovacao, pac_status: $pac_status, tipo_pacote: $tipo_pacote, assembleia: $assembleia, usu_id_aprovacao_fk: $usu_id_aprovacao_fk, usu_id_criacao_fk: $usu_id_criacao_fk, pac_comentario_aprovacao: $pac_comentario_aprovacao, pac_dt_modificacao: $pac_dt_modificacao, usuario_pacote_usu_id_criacao_fkTousuario: $usuario_pacote_usu_id_criacao_fkTousuario, usuario_pacote_usu_id_aprovacao_fkTousuario: $usuario_pacote_usu_id_aprovacao_fkTousuario, rel_pacote_usuario: $rel_pacote_usuario)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageModel &&
        other.pac_id == pac_id &&
        other.tip_pac_id_fk == tip_pac_id_fk &&
        other.ass_id_assembleia_fk == ass_id_assembleia_fk &&
        other.pac_uuid == pac_uuid &&
        other.pac_dt_evento == pac_dt_evento &&
        other.pac_dt_criacao == pac_dt_criacao &&
        other.pac_dt_aprovacao == pac_dt_aprovacao &&
        other.pac_status == pac_status &&
        other.tipo_pacote == tipo_pacote &&
        other.assembleia == assembleia &&
        other.usu_id_aprovacao_fk == usu_id_aprovacao_fk &&
        other.usu_id_criacao_fk == usu_id_criacao_fk &&
        other.pac_comentario_aprovacao == pac_comentario_aprovacao &&
        other.pac_dt_modificacao == pac_dt_modificacao &&
        other.usuario_pacote_usu_id_criacao_fkTousuario ==
            usuario_pacote_usu_id_criacao_fkTousuario &&
        other.usuario_pacote_usu_id_aprovacao_fkTousuario ==
            usuario_pacote_usu_id_aprovacao_fkTousuario &&
        listEquals(other.rel_pacote_usuario, rel_pacote_usuario);
  }

  @override
  int get hashCode {
    return pac_id.hashCode ^
        tip_pac_id_fk.hashCode ^
        ass_id_assembleia_fk.hashCode ^
        pac_uuid.hashCode ^
        pac_dt_evento.hashCode ^
        pac_dt_criacao.hashCode ^
        pac_dt_aprovacao.hashCode ^
        pac_status.hashCode ^
        tipo_pacote.hashCode ^
        assembleia.hashCode ^
        usu_id_aprovacao_fk.hashCode ^
        usu_id_criacao_fk.hashCode ^
        pac_comentario_aprovacao.hashCode ^
        pac_dt_modificacao.hashCode ^
        usuario_pacote_usu_id_criacao_fkTousuario.hashCode ^
        usuario_pacote_usu_id_aprovacao_fkTousuario.hashCode ^
        rel_pacote_usuario.hashCode;
  }
}
