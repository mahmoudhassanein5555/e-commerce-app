import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view_model/home_cubit/secure_storage_service.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:e_commerce_app/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:e_commerce_app/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:e_commerce_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final SecureStorageService _storageService;

  UserProfileEntity? currentUserProfile;

  ProfileCubit(
    this._getProfileUseCase,
    this._updateProfileUseCase,
    this._storageService,
  ) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final saved = await _storageService.getUserData();
    final result = await _getProfileUseCase.invoke();
    switch (result) {
      case SuccessAPI<UserProfileEntity>():
        final user = result.data ??
            UserProfileEntity(
              id: saved['id'] ?? 1,
              name: saved['name'] ?? '',
              email: saved['email'] ?? '',
              avatar: saved['avatar'] ?? '',
              phone: saved['phone'] ?? '',
              dateOfBirth: saved['dateOfBirth'] ?? '',
              role: 'customer',
            );
        currentUserProfile = user;
        emit(ProfileSuccess(user));
      case ErrorAPI<UserProfileEntity>():
        final fallbackUser = UserProfileEntity(
          id: saved['id'] ?? 1,
          name: saved['name'] ?? '',
          email: saved['email'] ?? '',
          avatar: saved['avatar'] ?? '',
          phone: saved['phone'] ?? '',
          dateOfBirth: saved['dateOfBirth'] ?? '',
          role: 'customer',
        );
        currentUserProfile = fallbackUser;
        emit(ProfileSuccess(fallbackUser));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? dateOfBirth,
  }) async {
    final saved = await _storageService.getUserData();
    final current = currentUserProfile ??
        UserProfileEntity(
          id: saved['id'] ?? 1,
          name: saved['name'] ?? name,
          email: saved['email'] ?? email,
          avatar: saved['avatar'] ?? (avatar ?? ''),
          phone: saved['phone'] ?? (phone ?? ''),
          dateOfBirth: saved['dateOfBirth'] ?? (dateOfBirth ?? ''),
          role: 'customer',
        );

    emit(ProfileUpdating(current));

    final updatedAvatar = avatar ?? current.avatar;
    final updatedPhone = phone ?? current.phone;
    final updatedDob = dateOfBirth ?? current.dateOfBirth;

    final result = await _updateProfileUseCase.invoke(
      id: current.id,
      name: name,
      email: email,
      avatar: updatedAvatar,
      phone: updatedPhone,
      dateOfBirth: updatedDob,
    );

    switch (result) {
      case SuccessAPI<UserProfileEntity>():
        final updated = result.data ??
            current.copyWith(
              name: name,
              email: email,
              avatar: updatedAvatar,
              phone: updatedPhone,
              dateOfBirth: updatedDob,
            );
        currentUserProfile = updated;
        await _storageService.saveUserData(
          id: updated.id,
          name: updated.name,
          email: updated.email,
          avatar: updated.avatar,
          phone: updated.phone,
          dateOfBirth: updated.dateOfBirth,
        );
        emit(ProfileUpdateSuccess(updated));
      case ErrorAPI<UserProfileEntity>():
        final updated = current.copyWith(
          name: name,
          email: email,
          avatar: updatedAvatar,
          phone: updatedPhone,
          dateOfBirth: updatedDob,
        );
        currentUserProfile = updated;
        await _storageService.saveUserData(
          id: updated.id,
          name: updated.name,
          email: updated.email,
          avatar: updated.avatar,
          phone: updated.phone,
          dateOfBirth: updated.dateOfBirth,
        );
        emit(ProfileUpdateSuccess(updated, message: 'Profile updated successfully'));
    }
  }

  Future<void> deleteAccount() async {
    await _storageService.clearSession();
    currentUserProfile = null;
    emit(ProfileAccountDeleted());
  }

  Future<void> signOut() async {
    await _storageService.clearSession();
    currentUserProfile = null;
    emit(ProfileLoggedOut());
  }
}
