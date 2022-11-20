// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'users_profile_model.dart';

class UsersModel {
  String? id;
  String? email;
  UsersProfileModel? UserProfile;

  UsersModel({
    this.id,
    this.email,
    this.UserProfile,
  });

  UsersModel copyWith({
    String? id,
    String? email,
    UsersProfileModel? UserProfile,
  }) {
    return UsersModel(
      id: id ?? this.id,
      email: email ?? this.email,
      UserProfile: UserProfile ?? this.UserProfile,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (UserProfile != null) {
      result.addAll({'UserProfile': UserProfile!.toMap()});
    }

    return result;
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      email: map['email'],
      UserProfile: map['UserProfile'] != null
          ? UsersProfileModel.fromMap(map['UserProfile'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersModel.fromJson(String source) =>
      UsersModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UsersModel(id: $id, email: $email, UserProfile: $UserProfile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersModel &&
        other.id == id &&
        other.email == email &&
        other.UserProfile == UserProfile;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ UserProfile.hashCode;
}
