import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';

class DateCircle extends StatelessWidget {
  final DateModel dt;
  final String inDay;

  const DateCircle({
    super.key,
    required this.dt,
    required this.inDay,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Color colors = AppColors.bgTrans;
    int task = int.parse(dt.taskToday.toString());
    int finish = int.parse(dt.taskFinish.toString());
    // int pending = int.parse(dt.taskPendding.toString());
    if (finish > 0 ) {
      colors = AppColors.bgYellow;
    } else if (finish == 0 && task > 0) {
      colors = AppColors.bgBlue;
    } else {
      colors = AppColors.bgGrey;
    }
    String day = '';
    if (dt.date == now.day.toString()) {
      day = 'Today';
    } else {
      day = dt.day.toString();
    }
    
    return Container(
      width: 60,
      height: 70,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: inDay == dt.date ? AppColors.primary : Colors.transparent,
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: transTextstyle.copyWith(
              fontSize: 11,
              fontWeight: bold,
              color: inDay == dt.date ? AppColors.bgColor : AppColors.bgGrey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            dt.date.toString(),
            style: transTextstyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
              color: inDay == dt.date ? AppColors.bgColor : AppColors.bgBlack,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: colors,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}


class DateRechgel extends StatelessWidget {
  final DateModel dt;
  final String inDay;

  const DateRechgel({
    super.key,
    required this.dt,
    required this.inDay,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Color colors = AppColors.bgTrans;
    int task = int.parse(dt.taskToday.toString());
    int finish = int.parse(dt.taskFinish.toString());
    // int pending = int.parse(dt.taskPendding.toString());
    if (finish > 0 ) {
      colors = AppColors.bgYellow;
    } else if (finish == 0 && task > 0) {
      colors = AppColors.bgBlue;
    } else {
      colors = AppColors.bgGrey;
    }
    String day = '';
    if (dt.date == now.day.toString()) {
      day = 'Today';
    } else {
      day = dt.day.toString();
    }
    
    return Container(
      width: 60,
      height: 70,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: inDay == dt.date ? AppColors.primary : Colors.transparent,
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: inDay == dt.date ? AppColors.primary : AppColors.bgColor,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: transTextstyle.copyWith(
              fontSize: 11,
              fontWeight: bold,
              color: inDay == dt.date ? AppColors.bgColor : AppColors.bgGrey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            dt.date.toString(),
            style: transTextstyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
              color: inDay == dt.date ? AppColors.bgColor : AppColors.bgBlack,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: colors,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
