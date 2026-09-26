import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/cart/presentation/view/product_cart_screen.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view/product_favorite_screen.dart';
import 'package:e_commerce_app/feature/home/presentation/view/home_screen.dart';
import 'package:e_commerce_app/feature/profile/presentation/view/profile_screen.dart';
import 'package:e_commerce_app/feature/search/presentation/view/search_screen.dart';
import 'package:e_commerce_app/feature/cart/presentation/view/cart_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class AppSection extends StatefulWidget {
  static const String routeName = 'InitApp';
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    // const CartScreen(),
    FavoriteScreen(),
    CartScreen(),

    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.bannerBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, -4),
              color: AppColors.darkBackground.withValues(alpha: 0.08),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: GNav(
              backgroundColor: AppColors.bannerBackground,
              rippleColor: AppColors.goldAccent.withValues(alpha: 0.18),
              hoverColor: AppColors.goldAccent.withValues(alpha: 0.08),
              gap: 8,
              activeColor: AppColors.white,
              iconSize: 22,
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              duration: const Duration(milliseconds: 350),
              tabBackgroundColor: AppColors.darkBackground,
              color: AppColors.textSecondary,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Cart',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                if (index == 2) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const CartBottomSheet(),
                  ).whenComplete(() {
                    // Re-render to ensure GNav snaps back to the actual _selectedIndex
                    setState(() {});
                  });
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
