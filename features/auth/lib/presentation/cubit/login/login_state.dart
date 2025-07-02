import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/login_result.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final bool isPasswordObscured;
  final LoginResult? loginResult;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    required this.loginResult,
    this.status = LoginStatus.initial,
    this.isPasswordObscured = true,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginResult? loginResult,
    LoginStatus? status,
    bool? isPasswordObscured,
    String? errorMessage,
  }) {
    return LoginState(
      loginResult: loginResult ?? this.loginResult,
      status: status ?? this.status,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        loginResult,
        status,
        isPasswordObscured,
        errorMessage,
      ];
}
