import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/data_empty.dart';
import 'package:mitask/core/utils/loading_helpers.dart';
import 'package:mitask/core/utils/popup_information_task.dart';
import 'package:mitask/core/utils/snackbar_extension.dart';
import 'package:mitask/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:mitask/features/report/data/models/report_model.dart';
import 'package:mitask/features/report/presentation/bloc/report_bloc.dart';
import 'package:mitask/features/report/presentation/bloc/report_event.dart';
import 'package:mitask/features/report/presentation/bloc/report_state.dart';
import 'package:mitask/features/report/presentation/widgets/view_report.dart';
import 'package:table_calendar/table_calendar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<ReportModel> report = [];
  DateTime _selectedDate = DateTime.now(); // Tanggal default
  String startDate = '';
  String endDate = '';

  @override
  void initState() {
    super.initState();
    reportAll('', '');
  }

  void reportAll(String start, String end) {
    context.read<ReportBloc>().add(GetReport(start: start, end: end));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(
          StringResources.rTitle,
          style: blackTextstyle.copyWith(
            fontSize: 20,
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              MediaRes.arrowBack,
              // ignore: deprecated_member_use
              color: AppColors.bgBlack,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // body: _bodyData(size),
      body: BlocListener<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is ExportTaskError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is ReportError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is ReportLoaded) {
            if (state.data.isNotEmpty) {
              report = [];
              report = state.data;
            } else {
              report = [];
            }
          } else if (state is ExportTaskSuccess) {
            if (state.success != '') {
              context.showSuccesSnackBar(
                state.success,
                onNavigate: () {}, // bottom close
              );
            }
          }
        },
        child: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            return Stack(
              children: [
                _bodyData(context, size), // Latar belakang utama
                if (state is ExportTaskLoading) ...[
                  // Layar semi-transparan gelap
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  // Loading overlay
                  const UIDialogLoading(text: StringResources.loading),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bodyData(BuildContext context, Size size) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => showCalendarPopup(size, false),
                  child: Container(
                    width: size.width * 0.4,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        startDate == '' ? 'Tanggal Mulai' : startDate,
                        style: blackTextstyle.copyWith(
                          fontSize: 15,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => showCalendarPopup(size, true),
                  child: Container(
                    width: size.width * 0.4,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        endDate == '' ? 'Tanggal Akhir' : endDate,
                        style: blackTextstyle.copyWith(
                          fontSize: 15,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            report.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: report.map((e) {
                        return InkWell(
                            onTap: () {
                              inforTaskRep(context, size, e);
                            },
                            child: ViewReport(dt: e, size: size));
                      }).toList(),
                    ),
                  )
                : dataIsEmpty(),
          ],
        ),
      ),
    );
  }

  Container exportImport(Size size, String title, icons) {
    return Container(
      width: size.width * 0.4,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.bgMain,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: blackTextstyle.copyWith(
              fontSize: 15,
              fontWeight: bold,
            ),
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(
            icons,
            fit: BoxFit.contain,
            width: 20,
            // ignore: deprecated_member_use
            color: AppColors.bgBlack,
          )
        ],
      ),
    );
  }

  void showCalendarPopup(Size size, bool type) async {
    DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime tempSelectedDate = _selectedDate; // Variabel sementara

        return AlertDialog(
          title: Text(
            "Pilih Tanggal",
            style: blackTextstyle.copyWith(
              fontSize: 15,
              fontWeight: bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.47,
                child: TableCalendar(
                  focusedDay: tempSelectedDate,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(3100),
                  selectedDayPredicate: (day) =>
                      isSameDay(tempSelectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setStateDialog(() {
                      tempSelectedDate = selectedDay; // 🔹 Perbarui UI kalender
                    });
                  },
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
                    selectedBuilder: (context, date, events) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.bgMain,
                              width: 2), // 🔹 Border kotak
                          borderRadius: BorderRadius.circular(
                              5), // Opsional: Ubah ke 0 untuk kotak tajam
                          color: AppColors.bgMain
                              .withOpacity(0.1), // Warna latar belakang seleksi
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
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null), // Batal
              child: Text(
                "Batal",
                style: blackTextstyle.copyWith(
                  fontSize: 15,
                  fontWeight: bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, tempSelectedDate), // Simpan
              child: Text(
                "Pilih",
                style: blackTextstyle.copyWith(
                  fontSize: 15,
                  fontWeight: bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (pickedDate != null) {
      if (type) {
        endDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      } else {
        startDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      }
      setState(() {
        _selectedDate = pickedDate;
        getFilterTask();
      });
    }
  }

  void getFilterTask() {
    if (startDate != '' && endDate != '') {
      reportAll(startDate, endDate);
    }
  }
}
