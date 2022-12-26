// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

class InsertPackageModel {
  String package_type_id;
  String event_date_time;
  String assemblage_id;
  List<String> package_users;

  InsertPackageModel({
    required this.package_type_id,
    required this.event_date_time,
    required this.assemblage_id,
    required this.package_users,
  });

  InsertPackageModel copyWith({
    String? package_type_id,
    String? event_date_time,
    String? assemblage_id,
    List<String>? package_users,
  }) {
    return InsertPackageModel(
      package_type_id: package_type_id ?? this.package_type_id,
      event_date_time: event_date_time ?? this.event_date_time,
      assemblage_id: assemblage_id ?? this.assemblage_id,
      package_users: package_users ?? this.package_users,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'package_type_id': package_type_id});
    result.addAll({'event_date_time': event_date_time});
    result.addAll({'assemblage_id': assemblage_id});
    result.addAll({'package_users': package_users});

    return result;
  }

  factory InsertPackageModel.fromMap(Map<String, dynamic> map) {
    return InsertPackageModel(
      package_type_id: map['package_type_id'] ?? '',
      event_date_time: map['event_date_time'] ?? '',
      assemblage_id: map['assemblage_id'] ?? '',
      package_users: List<String>.from(map['package_users']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InsertPackageModel.fromJson(String source) =>
      InsertPackageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InsertPackageModel(package_type_id: $package_type_id, event_date_time: $event_date_time, assemblage_id: $assemblage_id, package_users: $package_users)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InsertPackageModel &&
        other.package_type_id == package_type_id &&
        other.event_date_time == event_date_time &&
        other.assemblage_id == assemblage_id &&
        listEquals(other.package_users, package_users);
  }

  @override
  int get hashCode {
    return package_type_id.hashCode ^
        event_date_time.hashCode ^
        assemblage_id.hashCode ^
        package_users.hashCode;
  }
}
