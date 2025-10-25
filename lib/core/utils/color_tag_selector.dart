import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';

class TagColorsSelector extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int> onChanged;

  const TagColorsSelector({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final priorities = ['Mint Green', 'Sky Blue', 'Sunset Orange'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tag Colors',
          style: AppTextStyle.body.copyWith(fontWeight: medium),
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(priorities.length, (index) {
            return _TagColorsItem(
              title: priorities[index],
              index: index,
              selectedValue: selectedValue,
              onTap: () => onChanged(index),
            );
          }),
        ),
      ],
    );
  }
}

class _TagColorsItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedValue;
  final VoidCallback onTap;

  const _TagColorsItem({
    required this.title,
    required this.index,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedValue;
    Color color;
    if (index == 0) {
      color = AppColors.primary;
    } else if (index == 1) {
      color = AppColors.tagBlue;
    } else if (index == 2) {
      color = AppColors.tagOrange;
    } else {
      color = AppColors.primary;
    }
    final Color border = color.withValues(alpha: 0.2);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CustomInkWell(
            onTap: onTap,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: isSelected ? border : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : AppColors.border,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: isSelected ? color : AppColors.disabledText,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(title, style: AppTextStyle.body.copyWith(fontWeight: regular)),
        ],
      ),
    );
  }
}
