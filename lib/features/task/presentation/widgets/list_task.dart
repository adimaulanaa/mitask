import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/core/utils/date_utils.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';

class ListTask extends StatelessWidget {
  final TaskEntity data;
  final Function onTap;
  final Function onTapCheck;
  const ListTask({
    super.key,
    required this.data,
    required this.onTap,
    required this.onTapCheck,
  });

  @override
  Widget build(BuildContext context) {
    final dateOn = timestampToDateString(data.dateOn);
    final updateOn = timestampToTimeString(data.updatedOn);
    bool status = data.isStatus == 1 ? true : false;
    bool isPin = data.isPinned == 1 ? true : false;
    bool isFav = data.isFavorite == 1 ? true : false;
    bool isArch = data.isArchived == 1 ? true : false;
    return CustomInkWell(
      onTap: () => onTap(),
      child: Container(
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
                    data.title ?? '',
                    maxLines: 1, // Batasi 1 baris
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                  ),
                ),
                if (isPin)
                  SvgPicture.asset(
                    MediaRes.pinned,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
                if (isFav)
                  SvgPicture.asset(
                    MediaRes.favorite,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
                if (isArch)
                  SvgPicture.asset(
                    MediaRes.archived,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
              ],
            ),
            Text(
              data.subtitle ?? '',
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
                      dateOn,
                      style: AppTextStyle.textPrimary.copyWith(
                        fontWeight: regular,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Update : $updateOn',
                      style: AppTextStyle.textPrimary.copyWith(
                        fontWeight: regular,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                CustomInkWell(
                  onTap: () => onTapCheck(),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: status ? AppColors.border : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: status ? AppColors.primary : AppColors.border,
                        width: 2.0, // Ketebalan border
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: status
                            ? AppColors.primary
                            : AppColors.disabledText,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
