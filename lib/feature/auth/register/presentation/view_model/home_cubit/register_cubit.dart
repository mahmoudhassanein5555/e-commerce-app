import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/reques_entites/register_request_entites.dart';
import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';
import 'package:e_commerce_app/feature/auth/register/domain/use_case/register_use_case.dart';
import 'package:e_commerce_app/feature/auth/register/presentation/view_model/home_cubit/register_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());
  RegisterUseCase _registerUseCase;
  Future<void> intent(ResiterIntent event) async {
    switch (event) {
      case RegisterUser():
        await _register(event.requist);
    }
  }

  Future<void> _register(RegisterRequestEntites requist) async {
    emit(RegisterLoading());
    final result = await _registerUseCase.invoke(requist);
    switch (result) {
      case SuccessAPI<RegisterResponseEntity>():
        emit(RegisterSuccess(result.data ?? RegisterResponseEntity()));
      case ErrorAPI<RegisterResponseEntity>():
        emit(RegisterError(result.messageError));
    }
  }
}

sealed class ResiterIntent {}

class RegisterUser extends ResiterIntent {
  final RegisterRequestEntites requist;
  RegisterUser({required this.requist});
}
