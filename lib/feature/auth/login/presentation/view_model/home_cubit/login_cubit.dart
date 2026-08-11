import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';
import 'package:e_commerce_app/feature/auth/login/domain/use_case/login_use_case.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/login_state.dart';
import 'package:injectable/injectable.dart';

import 'package:e_commerce_app/core/network/auth_local_data_source.dart';

import 'package:e_commerce_app/feature/auth/auth_cubit.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final AuthLocalDataSource _authLocalDataSource;
  final AuthCubit _authCubit;
  LoginCubit(this._loginUseCase, this._authLocalDataSource, this._authCubit) : super(LoginInitial());

  intent(LoginIntent event) async {
    switch (event) {
      case LoginUser():
        return await _login(event.email, event.password);
    }
  }

  Future<void> _login(String email, String password) async {
    emit(LoginLoading());
    var response = await _loginUseCase.invoke(email: email, password: password);
    switch (response) {
      case SuccessAPI<LoginResponseEntity>():
        if (response.data?.accessToken != null) {
          await _authLocalDataSource.saveToken(response.data!.accessToken);
          final String name = email.split('@')[0]; // Use email prefix as name for now
          await _authLocalDataSource.saveUserData(name, email);
          _authCubit.login(name, email);
        }
        emit(LoginSuccess(email, password));
      // emit(LoginSuccess(response.data));
      case ErrorAPI<LoginResponseEntity>():
        emit(LoginError(response.messageError));
    }
  }
}

sealed class LoginIntent {}

class LoginUser extends LoginIntent {
  final String email;
  final String password;
  LoginUser({required this.email, required this.password});
}
