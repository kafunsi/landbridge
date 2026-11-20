import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  const AppLogo({super.key, this.size = 64, this.showText = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.royalBlue, AppColors.emeraldTeal],
            ),
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: AppColors.royalBlue.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.landscape_rounded,
            color: AppColors.white,
            size: size * 0.55,
          ),
        ),
        if (showText) ...[
          const SizedBox(height: AppSizes.sm),
          Text(
            'Landbridge',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: isDark ? AppColors.white : AppColors.grey900,
            ),
          ),
          Text(
            'Land Complaints System',
            style: GoogleFonts.inter(
              fontSize: 11,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.grey300 : AppColors.grey500,
            ),
          ),
        ],
      ],
    );
  }
}
