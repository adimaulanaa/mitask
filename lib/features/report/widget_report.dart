import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';

class SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;
  final Color? iconBg;
  final Color? iconColor;
  const SummaryItem({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
    this.iconBg,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 🔹 Icon Box
        Container(
          height: 36,
          width: 36,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg ?? AppColors.border,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(
              iconColor ?? AppColors.primaryDark,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // 🔹 Label & Value (teks)
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.caption.copyWith(fontWeight: medium),
              ),
              Text(
                value,
                style: AppTextStyle.caption.copyWith(fontWeight: semiBold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgressItems extends StatelessWidget {
  final String title;
  final double value;
  const ProgressItems({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🔹 Lebar tetap untuk label hari biar sejajar
        SizedBox(
          width: 40,
          child: Text(
            title,
            style: AppTextStyle.caption.copyWith(fontWeight: medium),
          ),
        ),

        // 🔹 Garis pemisah tengah
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '|',
            style: AppTextStyle.caption.copyWith(
              fontWeight: medium,
            ),
          ),
        ),

        // 🔹 Progress bar fleksibel mengikuti lebar layar
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.border.withValues(alpha: 0.7),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
}
