import 'package:e_commerce_app/feature/auth/register/domain/entites/respons_entites/register_response_entity.dart';

sealed class RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponseEntity response;
  RegisterSuccess(this.response);
}

class RegisterError extends RegisterState {
  final String messageError;
  RegisterError(this.messageError);
}
