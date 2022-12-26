// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../assemblages/models/assemblage_mode.dart';
import '../../users/models/users_models.dart';
import 'package_type_model.dart';
import 'package_users_model.dart';

class PackageModel {
  String? id;
  DateTime? event_date_time;
  UsersModel? creator_user;
  DateTime? created_at;
  UsersModel? approve_user;
  DateTime? approve_date;
  PackageTypeModel? package_type;
  AssemblageModel? assemblage;
  String? status;
  List<PackageUsersModel>? package_users;

  PackageModel({
    this.id,
    this.event_date_time,
    this.creator_user,
    this.created_at,
    this.approve_user,
    this.approve_date,
    this.package_type,
    this.assemblage,
    this.status,
    this.package_users,
  });

  PackageModel copyWith({
    String? id,
    DateTime? event_date_time,
    UsersModel? creator_user,
    DateTime? created_at,
    UsersModel? approve_user,
    DateTime? approve_date,
    PackageTypeModel? package_type,
    AssemblageModel? assemblage,
    String? status,
    List<PackageUsersModel>? package_users,
  }) {
    return PackageModel(
      id: id ?? this.id,
      event_date_time: event_date_time ?? this.event_date_time,
      creator_user: creator_user ?? this.creator_user,
      created_at: created_at ?? this.created_at,
      approve_user: approve_user ?? this.approve_user,
      approve_date: approve_date ?? this.approve_date,
      package_type: package_type ?? this.package_type,
      assemblage: assemblage ?? this.assemblage,
      status: status ?? this.status,
      package_users: package_users ?? this.package_users,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (event_date_time != null) {
      result
          .addAll({'event_date_time': event_date_time!.millisecondsSinceEpoch});
    }
    if (creator_user != null) {
      result.addAll({'creator_user': creator_user!.toMap()});
    }
    if (created_at != null) {
      result.addAll({'created_at': created_at!.millisecondsSinceEpoch});
    }
    if (approve_user != null) {
      result.addAll({'approve_user': approve_user!.toMap()});
    }
    if (approve_date != null) {
      result.addAll({'approve_date': approve_date!.millisecondsSinceEpoch});
    }
    if (package_type != null) {
      result.addAll({'package_type': package_type!.toMap()});
    }
    if (assemblage != null) {
      result.addAll({'assemblage': assemblage!.toMap()});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (package_users != null) {
      result.addAll(
          {'package_users': package_users!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'],
      event_date_time: map['event_date_time'] != null
          ? DateTime.tryParse(map['event_date_time'])
          : null,
      creator_user: map['creator_user'] != null
          ? UsersModel.fromMap(map['creator_user'])
          : null,
      created_at: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      approve_user: map['approve_user'] != null
          ? UsersModel.fromMap(map['approve_user'])
          : null,
      approve_date: map['approve_date'] != null
          ? DateTime.tryParse(map['approve_date'])
          : null,
      package_type: map['package_type'] != null
          ? PackageTypeModel.fromMap(map['package_type'])
          : null,
      assemblage: map['assemblage'] != null
          ? AssemblageModel.fromMap(map['assemblage'])
          : null,
      status: map['status'],
      package_users: map['package_users'] != null
          ? List<PackageUsersModel>.from(
              map['package_users']?.map((x) => PackageUsersModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageModel(id: $id, event_date_time: $event_date_time, creator_user: $creator_user, created_at: $created_at, approve_user: $approve_user, approve_date: $approve_date, package_type: $package_type, assemblage: $assemblage, status: $status, package_users: $package_users)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageModel &&
        other.id == id &&
        other.event_date_time == event_date_time &&
        other.creator_user == creator_user &&
        other.created_at == created_at &&
        other.approve_user == approve_user &&
        other.approve_date == approve_date &&
        other.package_type == package_type &&
        other.assemblage == assemblage &&
        other.status == status &&
        listEquals(other.package_users, package_users);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        event_date_time.hashCode ^
        creator_user.hashCode ^
        created_at.hashCode ^
        approve_user.hashCode ^
        approve_date.hashCode ^
        package_type.hashCode ^
        assemblage.hashCode ^
        status.hashCode ^
        package_users.hashCode;
  }
}
