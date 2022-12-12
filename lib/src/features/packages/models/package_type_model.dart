import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class PackageTypeModel {
  String? id;
  String? package_name;

  PackageTypeModel({
    this.id,
    this.package_name,
  });

  PackageTypeModel copyWith({
    String? id,
    String? package_name,
  }) {
    return PackageTypeModel(
      id: id ?? this.id,
      package_name: package_name ?? this.package_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (package_name != null) {
      result.addAll({'package_name': package_name});
    }

    return result;
  }

  factory PackageTypeModel.fromMap(Map<String, dynamic> map) {
    return PackageTypeModel(
      id: map['id'],
      package_name: map['package_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageTypeModel.fromJson(String source) =>
      PackageTypeModel.fromMap(json.decode(source));

  @override
  String toString() => 'PackageTypeModel(id: $id, package_name: $package_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageTypeModel &&
        other.id == id &&
        other.package_name == package_name;
  }

  @override
  int get hashCode => id.hashCode ^ package_name.hashCode;
}
