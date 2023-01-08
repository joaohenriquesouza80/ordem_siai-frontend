// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class OrderModel {
  String? ord_uuid;
  String? ord_name;

  OrderModel({
    this.ord_uuid,
    this.ord_name,
  });

  OrderModel copyWith({
    String? ord_uuid,
    String? ord_name,
  }) {
    return OrderModel(
      ord_uuid: ord_uuid ?? this.ord_uuid,
      ord_name: ord_name ?? this.ord_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (ord_uuid != null) {
      result.addAll({'ord_uuid': ord_uuid});
    }
    if (ord_name != null) {
      result.addAll({'ord_name': ord_name});
    }

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      ord_uuid: map['ord_uuid'],
      ord_name: map['ord_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() => 'OrderModel(ord_uuid: $ord_uuid, ord_name: $ord_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.ord_uuid == ord_uuid &&
        other.ord_name == ord_name;
  }

  @override
  int get hashCode => ord_uuid.hashCode ^ ord_name.hashCode;
}
