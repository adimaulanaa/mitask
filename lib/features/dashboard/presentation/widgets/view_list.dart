import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';

class ViewList extends StatelessWidget {
  final TaskModel dt;
  final Size size;
  final VoidCallback onTapCheckBox;
  final VoidCallback onDelete;
  final VoidCallback onInfo;
  const ViewList({
    super.key,
    required this.dt,
    required this.size,
    required this.onTapCheckBox,
    required this.onDelete,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatdate = '';
    DateFormat timeFormat = DateFormat('HH:mm:ss'); // Format jam:menit
    DateFormat fullDateFormat = DateFormat('dd MMM yyyy HH:mm:ss');

    bool status = dt.isStatus == 'true' ? true : false;
    if (DateFormat('yyyy-MM-dd').format(dt.dateOn!) ==
        DateFormat('yyyy-MM-dd').format(now)) {
      formatdate = "Today, ${timeFormat.format(dt.updatedOn!)}";
    } else {
      formatdate = fullDateFormat.format(dt.updatedOn!);
    }

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: AppColors.bgColor,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.74,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dt.title.toString(),
                      style: transTextstyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                        color: status ? AppColors.bgGrey : AppColors.bgBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dt.subtitle.toString(),
                      style: transTextstyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                        color: status ? AppColors.bgGrey : AppColors.bgBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => onTapCheckBox(),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: status ? AppColors.primary : AppColors.bgColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                  child: SvgPicture.asset(
                    MediaRes.checklist,
                    fit: BoxFit.contain,
                    width: 20,
                    // ignore: deprecated_member_use
                    color: status ? AppColors.bgColor : AppColors.primary,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: AppColors.bgGrey,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatdate,
                style: transTextstyle.copyWith(
                  fontSize: 13,
                  fontWeight: medium,
                  color: status ? AppColors.bgGrey : AppColors.bgBlack,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => onDelete(),
                    child: SvgPicture.asset(
                      MediaRes.deleted,
                      fit: BoxFit.contain,
                      width: 20,
                      // ignore: deprecated_member_use
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => onInfo(),
                    child: SvgPicture.asset(
                      MediaRes.information,
                      fit: BoxFit.contain,
                      width: 23,
                      // ignore: deprecated_member_use
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
