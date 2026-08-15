import 'package:e_commerce_app/feature/app_section/main_tab_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view/product_favorite_screen.dart';
import 'package:e_commerce_app/feature/home/presentation/view/home_screen.dart';
import 'package:e_commerce_app/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AppSection extends StatefulWidget {
  static const String routeName = 'InitApp';
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  List<Widget> widgetList = [
    HomeScreen(),
    // const CartScreen(),
    FavoriteScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainTabCubit, int>(
      builder: (context, index) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedFontSize: 13,
            selectedFontSize: 14,
            selectedItemColor: const Color(0xff212121),
            unselectedItemColor: const Color(0xff5C5C5C),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xff212121),
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff5C5C5C),
            ),
            currentIndex: index,
            onTap: (selectedIndex) {
              context.read<MainTabCubit>().selectTab(selectedIndex);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/icon-home.svg',
                  height: 23,
                  width: 23,
                  fit: BoxFit.cover,
                  color: index == 0
                      ? const Color(0xff212121)
                      : const Color(0xff5C5C5C),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/icon-favourite.svg',
                  height: 23,
                  width: 23,
                  fit: BoxFit.cover,
                  color: index == 2
                      ? const Color(0xff212121)
                      : const Color(0xff5C5C5C),
                ),
                label: ' Favorite',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/icon-profile.svg',
                  height: 23,
                  width: 23,
                  fit: BoxFit.cover,
                  color: index == 3
                      ? const Color(0xff212121)
                      : const Color(0xff5C5C5C),
                ),
                label: 'Profile',
              ),
            ],
          ),
          body: SafeArea(child: widgetList[index]),
        );
      },
    );
  }
}

class _CartNavIcon extends StatelessWidget {
  const _CartNavIcon({
    required this.selected,
    required this.badgeCount,
  });

  final bool selected;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xff212121) : const Color(0xff5C5C5C);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/icons/icon-cart.svg',
          height: 23,
          width: 23,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        if (badgeCount > 0)
          Positioned(
            right: -10,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 171, 18, 7),
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                badgeCount > 99 ? '99+' : '$badgeCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
