import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';

class PrioritySelector extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int> onChanged;

  const PrioritySelector({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final priorities = ['Low', 'Medium', 'High'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Priority', style: AppTextStyle.body.copyWith(fontWeight: medium)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(priorities.length, (index) {
            return _PriorityItem(
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

class _PriorityItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedValue;
  final VoidCallback onTap;

  const _PriorityItem({
    required this.title,
    required this.index,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedValue;

    return Row(
      children: [
        CustomInkWell(
          onTap: onTap,
          child: Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.border : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 2.0),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: isSelected ? AppColors.primary : AppColors.disabledText,
                size: 20,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: AppTextStyle.body.copyWith(fontWeight: regular)),
      ],
    );
  }
}

class CustomOneSelector extends StatelessWidget {
  final String title;
  final String hint;
  final bool isSelected;
  final VoidCallback onTap;
  const CustomOneSelector({
    super.key,
    required this.title,
    required this.hint,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.body.copyWith(fontWeight: medium)),
        const SizedBox(height: 10),
        Row(
          children: [
            CustomInkWell(
              onTap: onTap,
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.border : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, width: 2.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.disabledText,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(hint, style: AppTextStyle.body.copyWith(fontWeight: regular)),
          ],
        ),
      ],
    );
  }
}
