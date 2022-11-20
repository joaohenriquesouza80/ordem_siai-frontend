import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class UserProfileModel {
  String? id;
  String? user_id;
  String? name;
  String? avatar_url;

  UserProfileModel({
    this.id,
    this.user_id,
    this.name,
    this.avatar_url,
  });

  UserProfileModel copyWith({
    String? id,
    String? user_id,
    String? name,
    String? avatar_url,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      avatar_url: avatar_url ?? this.avatar_url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (user_id != null) {
      result.addAll({'user_id': user_id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (avatar_url != null) {
      result.addAll({'avatar_url': avatar_url});
    }

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      user_id: map['user_id'],
      name: map['name'],
      avatar_url: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, user_id: $user_id, name: $name, avatar_url: $avatar_url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileModel &&
        other.id == id &&
        other.user_id == user_id &&
        other.name == name &&
        other.avatar_url == avatar_url;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user_id.hashCode ^ name.hashCode ^ avatar_url.hashCode;
  }
}
