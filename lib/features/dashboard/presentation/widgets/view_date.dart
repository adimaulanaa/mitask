import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';

class DateCircle extends StatelessWidget {
  final String date;
  final String day;
  final String inDay;

  const DateCircle({
    super.key,
    required this.date,
    required this.day,
    required this.inDay,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: inDay == date ? AppColors.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: inDay == date ? AppColors.primary : AppColors.bgColor,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: transTextstyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
              color: inDay == date ? AppColors.bgColor : AppColors.bgBlack,
              height: 1.0,
            ),
          ),
          Text(
            day,
            style: transTextstyle.copyWith(
              fontSize: 11,
              fontWeight: bold,
              color: inDay == date ? AppColors.bgColor : AppColors.bgGrey,
            ),
          ),
        ],
      ),
    );
  }
}
