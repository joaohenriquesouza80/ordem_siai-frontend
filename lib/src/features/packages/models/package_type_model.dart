import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class PackageTypeModel {
  String? tip_pac_uuid;
  String? tip_pac_nome;

  PackageTypeModel({
    this.tip_pac_uuid,
    this.tip_pac_nome,
  });

  PackageTypeModel copyWith({
    String? tip_pac_uuid,
    String? tip_pac_nome,
  }) {
    return PackageTypeModel(
      tip_pac_uuid: tip_pac_uuid ?? this.tip_pac_uuid,
      tip_pac_nome: tip_pac_nome ?? this.tip_pac_nome,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (tip_pac_uuid != null) {
      result.addAll({'tip_pac_uuid': tip_pac_uuid});
    }
    if (tip_pac_nome != null) {
      result.addAll({'tip_pac_nome': tip_pac_nome});
    }

    return result;
  }

  factory PackageTypeModel.fromMap(Map<String, dynamic> map) {
    return PackageTypeModel(
      tip_pac_uuid: map['tip_pac_uuid'],
      tip_pac_nome: map['tip_pac_nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageTypeModel.fromJson(String source) =>
      PackageTypeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PackageTypeModel(tip_pac_uuid: $tip_pac_uuid, tip_pac_nome: $tip_pac_nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageTypeModel &&
        other.tip_pac_uuid == tip_pac_uuid &&
        other.tip_pac_nome == tip_pac_nome;
  }

  @override
  int get hashCode => tip_pac_uuid.hashCode ^ tip_pac_nome.hashCode;
}
