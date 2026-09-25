import 'dart:io';
import 'package:e_commerce_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/validator_functions.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final UserProfileEntity? currentProfile;
  final Function(
    String name,
    String email,
    String? avatarPath,
    String? phone,
    String? dateOfBirth,
  ) onSave;
  final VoidCallback onDeleteAccount;

  const EditProfileBottomSheet({
    super.key,
    this.currentProfile,
    required this.onSave,
    required this.onDeleteAccount,
  });

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  String? _selectedAvatarPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.currentProfile?.name ?? '',
    );
    _emailController = TextEditingController(
      text: widget.currentProfile?.email ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.currentProfile?.phone ?? '',
    );
    _dobController = TextEditingController(
      text: widget.currentProfile?.dateOfBirth ?? '',
    );
    _selectedAvatarPath = widget.currentProfile?.avatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (image != null && mounted) {
        setState(() {
          _selectedAvatarPath = image.path;
        });
      }
    } catch (e) {
      // Gracefully handle image selection cancellation or errors
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.darkBackground,
              onPrimary: AppColors.white,
              onSurface: AppColors.textHeader,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 8.w),
              Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeader,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete your account? This action is permanent and all your stored profile data will be erased.',
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
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
                widget.onDeleteAccount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Delete Account',
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

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '';
  }

  ImageProvider? _getImageProvider(String? avatar) {
    if (avatar == null || avatar.trim().isEmpty) return null;
    final trimmed = avatar.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return NetworkImage(trimmed);
    }
    final file = File(trimmed);
    if (file.existsSync()) {
      return FileImage(file);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentName = _nameController.text.isNotEmpty
        ? _nameController.text
        : (widget.currentProfile?.name ?? '');
    final initials = _getInitials(currentName);
    final imageProvider = _getImageProvider(_selectedAvatarPath);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 24.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28.r),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header handle
              Center(
                child: Container(
                  width: 38.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.bannerBorder,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Title
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: AppColors.textHeader,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Update your personal information below',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 20.h),

              // Profile Photo Selector Section
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 84.r,
                            height: 84.r,
                            padding: EdgeInsets.all(3.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.goldAccent.withValues(alpha: 0.5),
                                width: 1.5.r,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 39.r,
                              backgroundColor: AppColors.bannerBackground,
                              backgroundImage: imageProvider,
                              child: imageProvider == null
                                  ? Text(
                                      initials,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryGoldStart,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 2.r,
                            right: 2.r,
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: AppColors.darkBackground,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 1.5.r,
                                ),
                              ),
                              child: Icon(
                                Icons.photo_camera_rounded,
                                size: 15.r,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Text(
                        'Choose Photo from Gallery',
                        style: TextStyle(
                          color: AppColors.primaryGoldStart,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              // 1. Name Input Field
              Text(
                'Full Name',
                style: TextStyle(
                  color: AppColors.textHeader,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextFormField(
                controller: _nameController,
                hintText: 'Enter your name',
                validator: Validator.validateName,
              ),

              SizedBox(height: 16.h),

              // 2. Read-Only Email Address Field
              Row(
                children: [
                  Text(
                    'Email Address',
                    style: TextStyle(
                      color: AppColors.textHeader,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '(cannot be changed)',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              AbsorbPointer(
                child: CustomTextFormField(
                  controller: _emailController,
                  hintText: widget.currentProfile?.email ?? 'No email available',
                  suffixWidget: Icon(
                    Icons.lock_outline_rounded,
                    size: 18.r,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // 3. Phone Number Field
              Text(
                'Phone Number',
                style: TextStyle(
                  color: AppColors.textHeader,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextFormField(
                controller: _phoneController,
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 16.h),

              // 4. Date of Birth Field
              Text(
                'Date of Birth',
                style: TextStyle(
                  color: AppColors.textHeader,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: _dobController,
                    hintText: 'YYYY-MM-DD',
                    suffixWidget: const Icon(Icons.calendar_today_rounded, size: 18),
                  ),
                ),
              ),

              SizedBox(height: 26.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSave(
                        _nameController.text.trim(),
                        _emailController.text.trim(),
                        _selectedAvatarPath,
                        _phoneController.text.trim(),
                        _dobController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Delete Account Action Button (Destructive action)
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: OutlinedButton.icon(
                  onPressed: () => _showDeleteAccountConfirmation(context),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                    size: 18.r,
                  ),
                  label: Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent, width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
