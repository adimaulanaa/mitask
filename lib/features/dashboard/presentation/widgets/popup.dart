import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';

Future<dynamic> informationTask(
  BuildContext context,
  Size size,
  final TaskModel dt,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bgScreen,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      DateFormat fullDateFormat = DateFormat('dd MMM yyyy HH:mm:ss');
      String formatdate = fullDateFormat.format(dt.updatedOn!);
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          // Ganti dari Container ke Wrap agar tinggi menyesuaikan
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // Supaya tinggi menyesuaikan isi
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Detail Task",
                        style: blackTextstyle.copyWith(
                          fontSize: 17,
                          fontWeight: bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          MediaRes.close,
                          fit: BoxFit.contain,
                          width: 25,
                          // ignore: deprecated_member_use
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    formatdate,
                    style: transTextstyle.copyWith(
                      color: AppColors.bgGreyTree,
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    "Title",
                    style: blackTextstyle.copyWith(
                      fontSize: 15,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dt.title.toString(),
                    style: transTextstyle.copyWith(
                      color: AppColors.bgGreyTree,
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Sub Title
                  Text(
                    "Sub Title",
                    style: blackTextstyle.copyWith(
                      fontSize: 15,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dt.subtitle.toString(),
                    style: transTextstyle.copyWith(
                      color: AppColors.bgGreyTree,
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                  ),

                  // Notes (Jika Ada)
                  if (dt.notes!.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    Text(
                      "Notes",
                      style: blackTextstyle.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dt.notes.toString(),
                      style: transTextstyle.copyWith(
                        color: AppColors.bgGreyTree,
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
