import 'package:dependencies/json_annotation/json_annotation.dart';
import 'package:pos/data/models/user.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  final bool success;
  final User user;
  final String token;

  LoginResult({
    required this.success,
    required this.user,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResult &&
        other.success == success &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode {
    return success.hashCode ^ user.hashCode ^ token.hashCode;
  }
}
