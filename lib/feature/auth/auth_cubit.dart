import 'package:e_commerce_app/core/network/auth_local_data_source.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class AuthUser {
  final String name;
  final String email;

  AuthUser({required this.name, required this.email});
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final AuthUser user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final AuthLocalDataSource _authLocalDataSource;
  final GetProfileUseCase _getProfileUseCase;

  AuthCubit(this._authLocalDataSource, this._getProfileUseCase) : super(AuthInitial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    emit(AuthLoading());
    final token = await _authLocalDataSource.getToken();
    if (token != null) {
      final userData = await _authLocalDataSource.getUserData();
      if (userData['email'] != null) {
        emit(Authenticated(AuthUser(
            name: userData['name'] ?? userData['email']!.split('@')[0],
            email: userData['email']!)));
      } else {
        // Data missing, fetch from API
        final result = await _getProfileUseCase.invoke();
        switch (result) {
          case SuccessAPI():
            final user = result.data!;
            await _authLocalDataSource.saveUserData(user.name, user.email);
            emit(Authenticated(AuthUser(name: user.name, email: user.email)));
          case ErrorAPI():
            emit(Unauthenticated());
        }
      }
    } else {
      emit(Unauthenticated());
    }
  }

  void login(String name, String email) {
    emit(Authenticated(AuthUser(name: name, email: email)));
  }

  Future<void> logout() async {
    await _authLocalDataSource.clearToken();
    emit(Unauthenticated());
  }
}
