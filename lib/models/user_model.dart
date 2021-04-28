import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String user;
  UserModel({
    this.id,
    this.name,
    this.user,
  });

  UserModel copyWith({
    String id,
    String name,
    String user,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user': user,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, name: $name, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.user == user;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ user.hashCode;
}
