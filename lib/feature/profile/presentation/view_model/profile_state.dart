import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileEntity userProfile;
  ProfileSuccess(this.userProfile);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileUpdating extends ProfileState {
  final UserProfileEntity currentProfile;
  ProfileUpdating(this.currentProfile);
}

class ProfileUpdateSuccess extends ProfileState {
  final UserProfileEntity updatedProfile;
  final String message;
  ProfileUpdateSuccess(this.updatedProfile, {this.message = 'Profile updated successfully'});
}

class ProfileLoggedOut extends ProfileState {}

class ProfileAccountDeleted extends ProfileState {}
