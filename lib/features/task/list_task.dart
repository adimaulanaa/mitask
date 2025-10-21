import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';

class ListTask extends StatelessWidget {
  const ListTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Title Task',
                  maxLines: 1, // Batasi 1 baris
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                ),
              ),
              SvgPicture.asset(
                MediaRes.pinned,
                width: 18,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryDark,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          Text(
            'your detail task your detail',
            maxLines: 1, // Batasi 1 baris
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.caption.copyWith(fontWeight: regular),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    MediaRes.calendar,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '2025-01-01',
                    style: AppTextStyle.textPrimary.copyWith(
                      fontWeight: regular,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Update: 13:00',
                    style: AppTextStyle.textPrimary.copyWith(
                      fontWeight: regular,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border,
                    width: 2.0, // Ketebalan border
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: AppColors.disabledText,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}