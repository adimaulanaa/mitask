import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
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
            colorFilter: ColorFilter.mode(
              AppColors.primaryDark,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class BoxTypeAllFilter extends StatelessWidget {
  final String text;
  final bool active;
  final Function onTap;
  const BoxTypeAllFilter({
    super.key,
    required this.text,
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
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyle.body.copyWith(
              fontWeight: medium,
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ),
    );
  }
}

class ListIsEmpty extends StatelessWidget {
  const ListIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          MediaRes.logo,
          width: 100,
          height: 100,
          color: AppColors.primary,
        ),
        SizedBox(height: 20),
        Text(
          'Data tidak tersedia.',
          textAlign: TextAlign.center,
          style: AppTextStyle.body.copyWith(
            fontWeight: medium,
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }
}
