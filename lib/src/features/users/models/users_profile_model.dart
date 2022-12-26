// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'users_profile_assemblage_model.dart';
import 'users_profile_order_model.dart';

class UsersProfileModel {
  String? id;
  String? name;
  String? user_avatar_url;
  UsersProfileAssemblageModel? assemblage;
  UsersProfileOrderModel? order;

  UsersProfileModel({
    this.id,
    this.name,
    this.user_avatar_url,
    this.assemblage,
    this.order,
  });

  UsersProfileModel copyWith({
    String? id,
    String? name,
    String? user_avatar_url,
    UsersProfileAssemblageModel? assemblage,
    UsersProfileOrderModel? order,
  }) {
    return UsersProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      user_avatar_url: user_avatar_url ?? this.user_avatar_url,
      assemblage: assemblage ?? this.assemblage,
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
    if (user_avatar_url != null) {
      result.addAll({'user_avatar_url': user_avatar_url});
    }
    if (assemblage != null) {
      result.addAll({'assemblage': assemblage!.toMap()});
    }
    if (order != null) {
      result.addAll({'order': order!.toMap()});
    }

    return result;
  }

  factory UsersProfileModel.fromMap(Map<String, dynamic> map) {
    return UsersProfileModel(
      id: map['id'],
      name: map['name'],
      user_avatar_url: map['user_avatar_url'],
      assemblage: map['assemblage'] != null
          ? UsersProfileAssemblageModel.fromMap(map['assemblage'])
          : null,
      order: map['order'] != null
          ? UsersProfileOrderModel.fromMap(map['order'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersProfileModel.fromJson(String source) =>
      UsersProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsersProfileModel(id: $id, name: $name, user_avatar_url: $user_avatar_url, assemblage: $assemblage, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersProfileModel &&
        other.id == id &&
        other.name == name &&
        other.user_avatar_url == user_avatar_url &&
        other.assemblage == assemblage &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        user_avatar_url.hashCode ^
        assemblage.hashCode ^
        order.hashCode;
  }
}
