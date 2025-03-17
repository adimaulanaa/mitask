import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/report/data/models/report_model.dart';
import 'package:table_calendar/table_calendar.dart';

Future<dynamic> informationTaskDash(
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
      return DraggableScrollableSheet(  // Tambahkan ini untuk scroll otomatis
        initialChildSize: 0.5, // Modal terbuka setengah layar dulu
        minChildSize: 0.3, // Minimal 30% layar
        maxChildSize: 0.9, // Bisa discroll sampai 90% layar
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView( // Tambahkan ini
              controller: scrollController, // Supaya scrollnya ngikut DraggableScrollableSheet
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                      '$formatdate - ${dt.isType}',
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
                      style: greyTextstyle.copyWith(
                        fontSize: 13,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dt.title.toString(),
                      style: blackTextstyle.copyWith(
                        fontSize: 15,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Sub Title
                    Text(
                      "Subtitle",
                      style: greyTextstyle.copyWith(
                        fontSize: 13,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dt.subtitle.toString(),
                      style: blackTextstyle.copyWith(
                        fontSize: 15,
                        fontWeight: medium,
                      ),
                    ),
                    // Notes (Jika Ada)
                    if (dt.notes!.isNotEmpty) ...[
                      const SizedBox(height: 15),
                      Text(
                        "Notes",
                        style: greyTextstyle.copyWith(
                          fontSize: 13,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        dt.notes.toString(),
                        style: blackTextstyle.copyWith(
                          fontSize: 15,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<dynamic> changeDate(
  BuildContext context,
  Size size,
  DateTime? initialDate,
) {
  DateTime selectedDate = initialDate ?? DateTime.now();

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
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Date Task",
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
                      const SizedBox(height: 20),
                      // Calendar
                      TableCalendar(
                        firstDay: DateTime.utc(2025, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: selectedDate,
                        selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronIcon: SizedBox.shrink(),
                          rightChevronIcon: SizedBox.shrink(),
                        ),
                        calendarStyle: const CalendarStyle(
                          isTodayHighlighted: false,
                          selectedDecoration: BoxDecoration(),
                        ),
                        availableGestures: AvailableGestures.none,
                        calendarBuilders: CalendarBuilders(
                          selectedBuilder: (context, date, _) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.bgMain, width: 2),
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.bgMain.withOpacity(0.1),
                              ),
                              child: Text(
                                '${date.day}',
                                style: blackTextstyle.copyWith(
                                  fontWeight: bold,
                                ),
                              ),
                            );
                          },
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            selectedDate = selectedDay;
                          });
                        },
                      ),
                      const SizedBox(height: 30),

                      // Tombol Simpan
                      InkWell(
                        onTap: () {
                          DateTime now = DateTime.now();
                          DateTime finalDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            now.hour,
                            now.minute,
                            now.second,
                            now.millisecond,
                            now.microsecond,
                          );
                          String dateString = finalDateTime.toString();
                          Navigator.pop(context, dateString);
                        },
                        child: Container(
                          width: size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              'Simpan',
                              style: whiteTextstyle.copyWith(
                                fontSize: 19,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


Future<dynamic> inforTaskRep(
  BuildContext context,
  Size size,
  final ReportModel dt,
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
      String formatdate = fullDateFormat.format(dt.createdOn!);
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
                mainAxisSize: MainAxisSize.min,
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
                    '$formatdate - ${dt.isType}',
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
                    style: greyTextstyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dt.title.toString(),
                    style: blackTextstyle.copyWith(
                      fontSize: 15,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Sub Title
                  Text(
                    "Subtitle",
                    style: greyTextstyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dt.subtitle.toString(),
                    style: blackTextstyle.copyWith(
                      fontSize: 15,
                      fontWeight: medium,
                    ),
                  ),

                  // Notes (Jika Ada)
                  if (dt.notes!.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    Text(
                      "Notes",
                      style: greyTextstyle.copyWith(
                        fontSize: 13,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dt.notes.toString(),
                      style: blackTextstyle.copyWith(
                        fontSize: 15,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                  const SizedBox(height: 45),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
