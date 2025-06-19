class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  /// Factory untuk parsing dari JSON (misal respons dari API)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      name: json['username'],
      email: json['email'],
      role: json['role'].toString().toLowerCase(),
    );
  }

  /// Ubah ke JSON (misal untuk disimpan ke SharedPreferences)
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'role': role};
  }

  /// Untuk update sebagian field
  UserModel copyWith({int? id, String? name, String? email, String? role}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
