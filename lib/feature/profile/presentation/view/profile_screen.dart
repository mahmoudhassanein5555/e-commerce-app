import 'dart:io';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/dialogs/app_toasts.dart';
import 'package:e_commerce_app/core/routes/routes_names.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:e_commerce_app/feature/profile/presentation/view_model/profile_cubit.dart';
import 'package:e_commerce_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:e_commerce_app/feature/profile/presentation/widgets/edit_profile_bottom_sheet.dart';
import 'package:e_commerce_app/feature/profile/presentation/widgets/profile_header_card.dart';
import 'package:e_commerce_app/feature/profile/presentation/widgets/profile_options_card.dart';
import 'package:e_commerce_app/feature/profile/presentation/widgets/profile_stats_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = getIt<ProfileCubit>();
    _profileCubit.loadProfile();
  }

  @override
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  void _openPhotoViewer(BuildContext context, UserProfileEntity? profile) {
    final avatar = profile?.avatar ?? '';
    final name = profile?.name ?? 'Profile Photo';

    ImageProvider? imageProvider;
    if (avatar.isNotEmpty) {
      final trimmed = avatar.trim();
      if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
        imageProvider = NetworkImage(trimmed);
      } else {
        final file = File(trimmed);
        if (file.existsSync()) {
          imageProvider = FileImage(file);
        }
      }
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.95),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                name.isNotEmpty ? name : 'Profile Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Center(
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.0,
                child: imageProvider != null
                    ? Image(
                        image: imageProvider,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        width: 200.r,
                        height: 200.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bannerBackground,
                          border: Border.all(
                            color: AppColors.goldAccent,
                            width: 2.r,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _getInitials(name),
                            style: TextStyle(
                              fontSize: 56.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryGoldStart,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'U';
  }

  void _openEditProfileSheet(UserProfileEntity? profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditProfileBottomSheet(
        currentProfile: profile,
        onSave: (name, email, avatar, phone, dateOfBirth) {
          _profileCubit.updateProfile(
            name: name,
            email: email,
            avatar: avatar,
            phone: phone,
            dateOfBirth: dateOfBirth,
          );
        },
        onDeleteAccount: () {
          _profileCubit.deleteAccount();
        },
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textHeader,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out from your account?',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _profileCubit.signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE6F4E7),
                Color(0xFFF4F8F4),
                Color(0xFFF9F5E6),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Top Right Decorative Ambient Glow
              Positioned(
                top: -50.h,
                right: -50.w,
                child: Container(
                  width: 220.r,
                  height: 220.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFF8E7C5).withValues(alpha: 0.65),
                        const Color(0xFFD8EBD8).withValues(alpha: 0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  bloc: _profileCubit,
                  listener: (context, state) {
                    if (state is ProfileLoggedOut) {
                      AppToast.showToast(
                        context: context,
                        title: 'Signed Out',
                        description: 'You have been logged out successfully.',
                        type: ToastificationType.info,
                      );
                      context.goNamed(Routes.login);
                    } else if (state is ProfileAccountDeleted) {
                      AppToast.showToast(
                        context: context,
                        title: 'Account Deleted',
                        description: 'Your account has been deleted successfully.',
                        type: ToastificationType.info,
                      );
                      context.goNamed(Routes.login);
                    } else if (state is ProfileUpdateSuccess) {
                      AppToast.showToast(
                        context: context,
                        title: 'Success',
                        description: state.message,
                        type: ToastificationType.success,
                      );
                    } else if (state is ProfileError) {
                      AppToast.showToast(
                        context: context,
                        title: 'Error',
                        description: state.message,
                        type: ToastificationType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    UserProfileEntity? userProfile;
                    if (state is ProfileSuccess) {
                      userProfile = state.userProfile;
                    } else if (state is ProfileUpdateSuccess) {
                      userProfile = state.updatedProfile;
                    } else if (state is ProfileUpdating) {
                      userProfile = state.currentProfile;
                    } else {
                      userProfile = _profileCubit.currentUserProfile;
                    }

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 1. Top Bar Title Header
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'MEMBER',
                                  style: TextStyle(
                                    color: AppColors.goldTag,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: AppColors.textHeader,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'serif',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Loading state indicator or content
                          if (state is ProfileLoading && userProfile == null)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 60.h),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.goldAccent,
                                ),
                              ),
                            )
                          else ...[
                            // 2. Profile Header Card (Avatar + Centered Name)
                            ProfileHeaderCard(
                              userProfile: userProfile,
                              onEditTap: () => _openEditProfileSheet(userProfile),
                              onPhotoTap: () => _openPhotoViewer(context, userProfile),
                            ),

                            SizedBox(height: 16.h),

                            // 3. Middle Statistics Row (SAVED | BAG | ORDERS)
                            const ProfileStatsRow(),

                            SizedBox(height: 16.h),

                            // 4. Options Card & Sign Out Action
                            ProfileOptionsCard(
                              onSignOutTap: _showSignOutDialog,
                            ),

                            SizedBox(height: 110.h),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
