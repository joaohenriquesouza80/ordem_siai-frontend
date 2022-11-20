// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UsersProfileAssemblageModel {
  String? id;
  String? name;
  DateTime? foundation_date;
  String? status;
  String? picture;
  String? order_id;

  UsersProfileAssemblageModel({
    this.id,
    this.name,
    this.foundation_date,
    this.status,
    this.picture,
    this.order_id,
  });

  UsersProfileAssemblageModel copyWith({
    String? id,
    String? name,
    DateTime? foundation_date,
    String? status,
    String? picture,
    String? order_id,
  }) {
    return UsersProfileAssemblageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      foundation_date: foundation_date ?? this.foundation_date,
      status: status ?? this.status,
      picture: picture ?? this.picture,
      order_id: order_id ?? this.order_id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (foundation_date != null) {
      result.addAll({'foundation_date': foundation_date!.toIso8601String()});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (picture != null) {
      result.addAll({'picture': picture});
    }
    if (order_id != null) {
      result.addAll({'order_id': order_id});
    }

    return result;
  }

  factory UsersProfileAssemblageModel.fromMap(Map<String, dynamic> map) {
    return UsersProfileAssemblageModel(
      id: map['id'],
      name: map['name'],
      foundation_date: DateTime.tryParse(map['foundation_date'] ?? 'x'),
      status: map['status'],
      picture: map['picture'],
      order_id: map['order_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersProfileAssemblageModel.fromJson(String source) =>
      UsersProfileAssemblageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsersProfileAssemblageModel(id: $id, name: $name, foundation_date: $foundation_date, status: $status, picture: $picture, order_id: $order_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersProfileAssemblageModel &&
        other.id == id &&
        other.name == name &&
        other.foundation_date == foundation_date &&
        other.status == status &&
        other.picture == picture &&
        other.order_id == order_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        foundation_date.hashCode ^
        status.hashCode ^
        picture.hashCode ^
        order_id.hashCode;
  }
}
