import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/report/data/models/report_model.dart';

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

Future<dynamic> changeDate(
  BuildContext context,
  Size size,
  DateTime? initialDate,
) {
  // Jika tidak ada custom, pakai DateTime.now()
  DateTime initDate = initialDate ?? DateTime.now();

  String defaultDay = initDate.day.toString().padLeft(2, '0');
  String defaultMonth = initDate.month.toString().padLeft(2, '0');
  String defaultYear = initDate.year.toString();

  // Buat controller dengan nilai default
  TextEditingController dayController = TextEditingController(text: defaultDay);
  TextEditingController monthController =
      TextEditingController(text: defaultMonth);
  TextEditingController yearController =
      TextEditingController(text: defaultYear);

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Hari
                      _buildDateInput(dayController, "DD", size.width * 0.25),
                      // Bulan
                      _buildDateInput(monthController, "MM", size.width * 0.25),
                      // Tahun
                      _buildDateInput(
                          yearController, "YYYY", size.width * 0.25),
                    ],
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      String day = dayController.text.padLeft(2, '0');
                      String month = monthController.text.padLeft(2, '0');
                      String year = yearController.text;

                      if (day.isNotEmpty &&
                          month.isNotEmpty &&
                          year.isNotEmpty) {
                        // Ambil waktu sekarang
                        DateTime now = DateTime.now();
                        String timeNow =
                            "${now.hour}:${now.minute}:${now.second}.${now.millisecond}";

                        // Gabungkan dengan tanggal input
                        String dateString = "$year-$month-$day $timeNow";
                        Navigator.pop(context, dateString);
                      }
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
}

// Widget untuk Input Text Date
Widget _buildDateInput(
    TextEditingController controller, String hint, double width) {
  return SizedBox(
    width: width,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: hint == "YYYY" ? 4 : 2,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counterText: "",
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.bgGreySecond, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.bgGreySecond, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.bgColor,
      ),
    ),
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
