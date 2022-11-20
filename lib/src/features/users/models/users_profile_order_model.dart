import 'dart:convert';

class UsersProfileOrderModel {
  String? id;
  String? name;

  UsersProfileOrderModel({
    this.id,
    this.name,
  });

  UsersProfileOrderModel copyWith({
    String? id,
    String? name,
  }) {
    return UsersProfileOrderModel(
      id: id ?? this.id,
      name: name ?? this.name,
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

    return result;
  }

  factory UsersProfileOrderModel.fromMap(Map<String, dynamic> map) {
    return UsersProfileOrderModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersProfileOrderModel.fromJson(String source) =>
      UsersProfileOrderModel.fromMap(json.decode(source));

  @override
  String toString() => 'UsersProfileOrderModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersProfileOrderModel &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
