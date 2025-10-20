import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';

class AppTextStyle {
  static const String _fontFamily = 'Josefin Sans';

  // Base Style
  static const TextStyle base = TextStyle(
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  // ✨ Color Variants — Sinkron dengan AppColors
  static final TextStyle primary = base.copyWith(color: AppColors.primary);
  static final TextStyle primaryDark = base.copyWith(
    color: AppColors.primaryDark,
  );
  static final TextStyle primaryLight = base.copyWith(
    color: AppColors.primaryLight,
  );

  static final TextStyle background = base.copyWith(
    color: AppColors.background,
  );
  static final TextStyle surface = base.copyWith(color: AppColors.surface);
  static final TextStyle surfaceVariant = base.copyWith(
    color: AppColors.surfaceVariant,
  );

  static final TextStyle textPrimary = base.copyWith(
    color: AppColors.textPrimary,
  );
  static final TextStyle textSecondary = base.copyWith(
    color: AppColors.textSecondary,
  );
  static final TextStyle textTertiary = base.copyWith(
    color: AppColors.textTertiary,
  );

  static final TextStyle success = base.copyWith(color: AppColors.success);
  static final TextStyle warning = base.copyWith(color: AppColors.warning);
  static final TextStyle error = base.copyWith(color: AppColors.error);
  static final TextStyle info = base.copyWith(color: AppColors.info);

  // 🪄 Size Variants
  static final TextStyle h1 = base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle h2 = base.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle h3 = base.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle body = base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle caption = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );
  static final TextStyle small = base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
}

// FontWeight Shortcut
const FontWeight thin = FontWeight.w100;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
