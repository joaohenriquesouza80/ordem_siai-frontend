// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../users/models/users_models.dart';

class PackageUsersModel {
  String? id;
  String? package_id;
  UsersModel? user;
  bool? is_presence;
  UsersModel? presence_user;
  DateTime? presence_date;
  String? presence_comments;

  PackageUsersModel({
    this.id,
    this.package_id,
    this.user,
    this.is_presence,
    this.presence_user,
    this.presence_date,
    this.presence_comments,
  });

  PackageUsersModel copyWith({
    String? id,
    String? package_id,
    UsersModel? user,
    bool? is_presence,
    UsersModel? presence_user,
    DateTime? presence_date,
    String? presence_comments,
  }) {
    return PackageUsersModel(
      id: id ?? this.id,
      package_id: package_id ?? this.package_id,
      user: user ?? this.user,
      is_presence: is_presence ?? this.is_presence,
      presence_user: presence_user ?? this.presence_user,
      presence_date: presence_date ?? this.presence_date,
      presence_comments: presence_comments ?? this.presence_comments,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (package_id != null) {
      result.addAll({'package_id': package_id});
    }
    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }
    if (is_presence != null) {
      result.addAll({'is_presence': is_presence});
    }
    if (presence_user != null) {
      result.addAll({'presence_user': presence_user!.toMap()});
    }
    if (presence_date != null) {
      result.addAll({'presence_date': presence_date!.millisecondsSinceEpoch});
    }
    if (presence_comments != null) {
      result.addAll({'presence_comments': presence_comments});
    }

    return result;
  }

  factory PackageUsersModel.fromMap(Map<String, dynamic> map) {
    return PackageUsersModel(
      id: map['id'],
      package_id: map['package_id'],
      user: map['user'] != null ? UsersModel.fromMap(map['user']) : null,
      is_presence: map['is_presence'],
      presence_user: map['presence_user'] != null
          ? UsersModel.fromMap(map['presence_user'])
          : null,
      presence_date: map['presence_date'] != null
          ? DateTime.tryParse(map['presence_date'])
          : null,
      presence_comments: map['presence_comments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageUsersModel.fromJson(String source) =>
      PackageUsersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageUsersModel(id: $id, package_id: $package_id, user: $user, is_presence: $is_presence, presence_user: $presence_user, presence_date: $presence_date, presence_comments: $presence_comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageUsersModel &&
        other.id == id &&
        other.package_id == package_id &&
        other.user == user &&
        other.is_presence == is_presence &&
        other.presence_user == presence_user &&
        other.presence_date == presence_date &&
        other.presence_comments == presence_comments;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        package_id.hashCode ^
        user.hashCode ^
        is_presence.hashCode ^
        presence_user.hashCode ^
        presence_date.hashCode ^
        presence_comments.hashCode;
  }
}
