import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';

class ListIsEmpty extends StatelessWidget {
  final String message;
  const ListIsEmpty({super.key, this.message = 'Data tidak tersedia.'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Image.asset(
          MediaRes.emptyList,
          width: 80,
          height: 80,
          color: AppColors.primary,
        ),
        SizedBox(height: 20),
        Text(
          message,
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
