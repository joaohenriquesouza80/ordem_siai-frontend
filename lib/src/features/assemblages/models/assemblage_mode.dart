// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../orders/models/order_model.dart';

class AssemblageModel {
  String? ass_uuid;
  String? ass_nome;
  DateTime? ass_dt_fundacao;
  String? ass_foto;
  String? ass_status;
  OrderModel? ordem;

  AssemblageModel({
    this.ass_uuid,
    this.ass_nome,
    this.ass_dt_fundacao,
    this.ass_foto,
    this.ass_status,
    this.ordem,
  });

  AssemblageModel copyWith({
    String? ass_uuid,
    String? ass_nome,
    DateTime? ass_dt_fundacao,
    String? ass_foto,
    String? ass_status,
    OrderModel? ordem,
  }) {
    return AssemblageModel(
      ass_uuid: ass_uuid ?? this.ass_uuid,
      ass_nome: ass_nome ?? this.ass_nome,
      ass_dt_fundacao: ass_dt_fundacao ?? this.ass_dt_fundacao,
      ass_foto: ass_foto ?? this.ass_foto,
      ass_status: ass_status ?? this.ass_status,
      ordem: ordem ?? this.ordem,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (ass_uuid != null) {
      result.addAll({'ass_uuid': ass_uuid});
    }
    if (ass_nome != null) {
      result.addAll({'ass_nome': ass_nome});
    }
    if (ass_dt_fundacao != null) {
      result
          .addAll({'ass_dt_fundacao': ass_dt_fundacao!.millisecondsSinceEpoch});
    }
    if (ass_foto != null) {
      result.addAll({'ass_foto': ass_foto});
    }
    if (ass_status != null) {
      result.addAll({'ass_status': ass_status});
    }
    if (ordem != null) {
      result.addAll({'ordem': ordem!.toMap()});
    }

    return result;
  }

  factory AssemblageModel.fromMap(Map<String, dynamic> map) {
    return AssemblageModel(
      ass_uuid: map['ass_uuid'],
      ass_nome: map['ass_nome'],
      ass_dt_fundacao: map['ass_dt_fundacao'] != null
          ? DateTime.tryParse(map['ass_dt_fundacao'])
          : null,
      ass_foto: map['ass_foto'],
      ass_status: map['ass_status'],
      ordem: map['ordem'] != null ? OrderModel.fromMap(map['ordem']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssemblageModel.fromJson(String source) =>
      AssemblageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssemblageModel(ass_uuid: $ass_uuid, ass_nome: $ass_nome, ass_dt_fundacao: $ass_dt_fundacao, ass_foto: $ass_foto, ass_status: $ass_status, ordem: $ordem)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssemblageModel &&
        other.ass_uuid == ass_uuid &&
        other.ass_nome == ass_nome &&
        other.ass_dt_fundacao == ass_dt_fundacao &&
        other.ass_foto == ass_foto &&
        other.ass_status == ass_status &&
        other.ordem == ordem;
  }

  @override
  int get hashCode {
    return ass_uuid.hashCode ^
        ass_nome.hashCode ^
        ass_dt_fundacao.hashCode ^
        ass_foto.hashCode ^
        ass_status.hashCode ^
        ordem.hashCode;
  }
}
