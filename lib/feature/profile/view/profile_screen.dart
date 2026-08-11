import 'dart:io';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/feature/auth/auth_cubit.dart';
import 'package:e_commerce_app/feature/auth/login/presentation/view/login_screen.dart';
import 'package:e_commerce_app/feature/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Color(0xFF1F1F1F),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      _buildAvatarSection(context),
                      const SizedBox(height: 16),
                      _buildUserInfo(authState.user),
                      const SizedBox(height: 32),
                      _buildMenuSection('PERSONAL INFORMATION', [
                        _buildMenuItem(Icons.shopping_bag_outlined, 'My Orders'),
                        _buildMenuItem(Icons.location_on_outlined, 'Shipping Address'),
                        _buildMenuItem(Icons.credit_card_outlined, 'Payment Methods'),
                      ]),
                      const SizedBox(height: 24),
                      _buildMenuSection('ACCOUNT SETTINGS', [
                        _buildMenuItem(Icons.notifications_none_outlined, 'Notifications'),
                        _buildMenuItem(Icons.lock_outline, 'Privacy'),
                        _buildMenuItem(Icons.shield_outlined, 'Security'),
                      ]),
                      const SizedBox(height: 32),
                      _buildLogoutButton(context),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    return BlocBuilder<ProfileCubit, String?>(
      builder: (context, imagePath) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFEEEEEE),
                backgroundImage: imagePath != null ? FileImage(File(imagePath)) : null,
                child: imagePath == null
                    ? const Icon(Icons.person, size: 60, color: Color(0xFF9E9E9E))
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 4,
              child: GestureDetector(
                onTap: () => context.read<ProfileCubit>().pickImage(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2F50C1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserInfo(AuthUser user) {
    return Column(
      children: [
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F1F),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF7D7D7D),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8E8E93),
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2F50C1)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1F1F1F),
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFFC7C7CC)),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          context.read<AuthCubit>().logout();
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFFFF3B30),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
