import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onBackTap;
  final VoidCallback? onOptionsTap;
  final String hintText;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.onBackTap,
    this.onOptionsTap,
    this.hintText = 'Search the maison...',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Oval / Circular Back Button
        GestureDetector(
          onTap: () {
            if (onBackTap != null) {
              onBackTap!();
            } else if (context.canPop()) {
              context.pop();
            }
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              size: 22,
              color: Color(0xFF2D382E),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Rounded Capsule Search Bar
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: const Color(0xFFE0ECE0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: Color(0xFF8DA090),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2B382D),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Color(0xFF9AA99C),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Three Dots Options Icon
        GestureDetector(
          onTap: onOptionsTap,
          child: Container(
            padding: const EdgeInsets.all(4),
            child: const Icon(
              Icons.more_horiz_rounded,
              size: 22,
              color: Color(0xFF5A695B),
            ),
          ),
        ),
      ],
    );
  }
}

