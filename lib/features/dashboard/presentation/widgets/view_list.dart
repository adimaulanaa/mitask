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
  const ViewList({
    super.key,
    required this.dt,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatdate = '';
    DateFormat timeFormat = DateFormat('HH:mm'); // Format jam:menit
    DateFormat fullDateFormat = DateFormat('dd MMM yyyy HH:mm');

    bool status = dt.isStatus == 'true' ? true : false;
    if (DateFormat('yyyy-MM-dd').format(dt.updatedOn!) ==
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
                      style: blackTextstyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dt.subtitle.toString(),
                      style: blackTextstyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
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
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: AppColors.bgGrey,
          ),
          const SizedBox(height: 10),
          Text(
            formatdate,
            style: blackTextstyle.copyWith(
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
