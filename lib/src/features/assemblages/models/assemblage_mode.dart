// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../orders/models/order_model.dart';

class AssemblageModel {
  String? id;
  String? name;
  DateTime? foundation_date;
  String? picture;
  String? status;
  OrderModel? order;

  AssemblageModel({
    this.id,
    this.name,
    this.foundation_date,
    this.picture,
    this.status,
    this.order,
  });

  AssemblageModel copyWith({
    String? id,
    String? name,
    DateTime? foundation_date,
    String? picture,
    String? status,
    OrderModel? order,
  }) {
    return AssemblageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      foundation_date: foundation_date ?? this.foundation_date,
      picture: picture ?? this.picture,
      status: status ?? this.status,
      order: order ?? this.order,
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
      result
          .addAll({'foundation_date': foundation_date!.millisecondsSinceEpoch});
    }
    if (picture != null) {
      result.addAll({'picture': picture});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (order != null) {
      result.addAll({'order': order!.toMap()});
    }

    return result;
  }

  factory AssemblageModel.fromMap(Map<String, dynamic> map) {
    return AssemblageModel(
      id: map['id'],
      name: map['name'],
      foundation_date: map['foundation_date'] != null
          ? DateTime.tryParse(map['foundation_date'])
          : null,
      picture: map['picture'],
      status: map['status'],
      order: map['order'] != null ? OrderModel.fromMap(map['order']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssemblageModel.fromJson(String source) =>
      AssemblageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssemblageModel(id: $id, name: $name, foundation_date: $foundation_date, picture: $picture, status: $status, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssemblageModel &&
        other.id == id &&
        other.name == name &&
        other.foundation_date == foundation_date &&
        other.picture == picture &&
        other.status == status &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        foundation_date.hashCode ^
        picture.hashCode ^
        status.hashCode ^
        order.hashCode;
  }
}
