import 'dart:convert';

class AuthRequestDTO {
  final String email;
  final String password;

  AuthRequestDTO({
    required this.email,
    required this.password,
  });

  AuthRequestDTO copyWith({
    String? email,
    String? password,
  }) {
    return AuthRequestDTO(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AuthRequestDTO.fromMap(Map<String, dynamic> map) {
    return AuthRequestDTO(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequestDTO.fromJson(String source) =>
      AuthRequestDTO.fromMap(json.decode(source));

  @override
  String toString() => 'AuthRequestDTO(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthRequestDTO &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
