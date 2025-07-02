import 'package:dependencies/json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String username;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.username == username &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    username.hashCode ^
    role.hashCode;
  }
}