import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/report/data/models/report_model.dart';

class ViewReport extends StatelessWidget {
  final ReportModel dt;
  final Size size;
  const ViewReport({super.key, required this.dt, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dt.title.toString(),
            style: blackTextstyle.copyWith(
              fontSize: 15,
              fontWeight: bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            dt.subtitle.toString(),
            style: greyTextstyle.copyWith(
              fontSize: 13,
              fontWeight: bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
