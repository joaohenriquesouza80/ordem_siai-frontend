import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

import 'user_model.dart';

class AuthenticatedUserModel {
  final UserModel user;
  final String token;

  AuthenticatedUserModel({
    required this.user,
    required this.token,
  });

  AuthenticatedUserModel copyWith({
    UserModel? user,
    String? token,
  }) {
    return AuthenticatedUserModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'token': token,
    };
  }

  factory AuthenticatedUserModel.fromMap(Map<String, dynamic> map) {
    return AuthenticatedUserModel(
      user: UserModel.fromMap(map['user']),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticatedUserModel.fromJson(String source) =>
      AuthenticatedUserModel.fromMap(json.decode(source));

  @override
  String toString() => 'AuthenticatedUserModel(user: $user, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthenticatedUserModel &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;

  String get userName => JwtDecoder.tryDecode(token)?['user_name'];
  String get userAvatarUrl => JwtDecoder.tryDecode(token)?['user_avatar_url'];
}
