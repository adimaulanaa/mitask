import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';

class BoxTypeFilter extends StatelessWidget {
  final String icons;
  final bool active;
  final Function onTap;
  const BoxTypeFilter({
    super.key,
    required this.icons,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomInkWell(
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: active ? AppColors.border : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: AppColors.border),
          ),
          child: SvgPicture.asset(
            icons,
            colorFilter: ColorFilter.mode(AppColors.primaryDark, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
