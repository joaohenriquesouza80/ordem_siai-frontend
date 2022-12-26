import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class UpdatePackageUserPresenceStatusDTO {
  bool is_presence;
  String presence_user_id;
  String presence_date;
  String? presence_comments;

  UpdatePackageUserPresenceStatusDTO({
    required this.is_presence,
    required this.presence_user_id,
    required this.presence_date,
    this.presence_comments,
  });

  UpdatePackageUserPresenceStatusDTO copyWith({
    bool? is_presence,
    String? presence_user_id,
    String? presence_date,
    String? presence_comments,
  }) {
    return UpdatePackageUserPresenceStatusDTO(
      is_presence: is_presence ?? this.is_presence,
      presence_user_id: presence_user_id ?? this.presence_user_id,
      presence_date: presence_date ?? this.presence_date,
      presence_comments: presence_comments ?? this.presence_comments,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'is_presence': is_presence});
    result.addAll({'presence_user_id': presence_user_id});
    result.addAll({'presence_date': presence_date});
    if (presence_comments != null) {
      result.addAll({'presence_comments': presence_comments});
    }

    return result;
  }

  factory UpdatePackageUserPresenceStatusDTO.fromMap(Map<String, dynamic> map) {
    return UpdatePackageUserPresenceStatusDTO(
      is_presence: map['is_presence'] ?? false,
      presence_user_id: map['presence_user_id'] ?? '',
      presence_date: map['presence_date'] ?? '',
      presence_comments: map['presence_comments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatePackageUserPresenceStatusDTO.fromJson(String source) =>
      UpdatePackageUserPresenceStatusDTO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdatePackageUserPresenceStatusDTO(is_presence: $is_presence, presence_user_id: $presence_user_id, presence_date: $presence_date, presence_comments: $presence_comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatePackageUserPresenceStatusDTO &&
        other.is_presence == is_presence &&
        other.presence_user_id == presence_user_id &&
        other.presence_date == presence_date &&
        other.presence_comments == presence_comments;
  }

  @override
  int get hashCode {
    return is_presence.hashCode ^
        presence_user_id.hashCode ^
        presence_date.hashCode ^
        presence_comments.hashCode;
  }
}
