import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class UpdatePackageStatusDTO {
  String status;
  String approve_user_id;
  String approve_date;
  String? approve_comments;

  UpdatePackageStatusDTO({
    required this.status,
    required this.approve_user_id,
    required this.approve_date,
    this.approve_comments,
  });

  UpdatePackageStatusDTO copyWith({
    String? status,
    String? approve_user_id,
    String? approve_date,
    String? approve_comments,
  }) {
    return UpdatePackageStatusDTO(
      status: status ?? this.status,
      approve_user_id: approve_user_id ?? this.approve_user_id,
      approve_date: approve_date ?? this.approve_date,
      approve_comments: approve_comments ?? this.approve_comments,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'approve_user_id': approve_user_id});
    result.addAll({'approve_date': approve_date});
    if (approve_comments != null) {
      result.addAll({'approve_comments': approve_comments});
    }

    return result;
  }

  factory UpdatePackageStatusDTO.fromMap(Map<String, dynamic> map) {
    return UpdatePackageStatusDTO(
      status: map['status'] ?? '',
      approve_user_id: map['approve_user_id'] ?? '',
      approve_date: map['approve_date'] ?? '',
      approve_comments: map['approve_comments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatePackageStatusDTO.fromJson(String source) =>
      UpdatePackageStatusDTO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdatePackageStatusDTO(status: $status, approve_user_id: $approve_user_id, approve_date: $approve_date, approve_comments: $approve_comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatePackageStatusDTO &&
        other.status == status &&
        other.approve_user_id == approve_user_id &&
        other.approve_date == approve_date &&
        other.approve_comments == approve_comments;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        approve_user_id.hashCode ^
        approve_date.hashCode ^
        approve_comments.hashCode;
  }
}
