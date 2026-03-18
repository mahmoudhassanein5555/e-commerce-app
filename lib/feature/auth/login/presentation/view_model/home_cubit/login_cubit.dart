import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/domain/entites/respons_entites/login_response_entity.dart';
import 'package:e_commerce_app/feature/auth/login/domain/use_case/login_use_case.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitial());

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
