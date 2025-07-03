import 'package:auth/presentation/cubit/login/login_state.dart';
import 'package:common/extension/extension.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/domain/usecase/login_use_case.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase})
      : super(const LoginState(isPasswordObscured: true, loginResult: null));

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  void login(String username, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final result = await loginUseCase.execute(username, password);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (data) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.saveToken(data.token);
        emit(state.copyWith(loginResult: data, status: LoginStatus.success));
      },
    );
  }
}
