sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String email;
  final String password;
  LoginSuccess(this.email, this.password);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginLoading extends LoginState {}
