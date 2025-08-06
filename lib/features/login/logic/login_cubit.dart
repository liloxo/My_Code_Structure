import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_code_structure/features/login/data/login_data.dart';
import 'package:flutter/material.dart';
import 'package:my_code_structure/features/login/domain/login_model.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginData) : super(LoginInitial());

  final LoginData loginData;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final response = await loginData.login(email, password);
    response.fold(
      (l) => emit(LoginFailure(l.message)),
      (r) => emit(LoginSuccess(r)),
    );
  }
}
