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
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/presentation/bloc/bloc.dart';
import 'package:mitask/features/dashboard/presentation/pages/create_task_screen.dart';
import 'package:mitask/features/dashboard/presentation/widgets/view_date.dart';
import 'package:mitask/features/dashboard/presentation/widgets/view_list.dart';
import 'package:mitask/features/report/presentation/pages/report_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  DateTime now = DateTime.now();
  List<DateModel> listDate = [];
  List<TaskModel> listTask = [];
  List<TaskModel> viewListTask = [];
  String inDay = '';
  String inDayName = '';
  String inDayTask = '0';
  String inDayFinishTask = '0';
  String inDayPenddingTask = '0';
  String filterDate = '';

  @override
  void initState() {
    super.initState();
    getDash();
  }

  void getDash() {
    context.read<DashboardBloc>().add(const GetDashboard());
  }

  void getTask(String date) {
    context.read<DashboardBloc>().add(GetTask(date: date));
  }

  void scrollToToday() {
    int todayIndex = listDate.indexWhere((e) => e.date == now.day.toString());
    if (todayIndex != -1) {
      double targetOffset = todayIndex * 70.0; // 70 = perkiraan lebar tiap item
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is TaskError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is ChecklistError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is DeleteTaskError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is ChangeDateTaskError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is DashboardLoaded) {
            if (state.data.isNotEmpty) {
              listDate = state.data;
              // selectedDate(now.day.toString());
              filterDate = DateFormat('yyyy-MM-dd').format(now);
              inDay = now.day.toString();
              getTask(filterDate);
              scrollToToday();
            }
          } else if (state is TaskLoaded) {
            if (state.data.isNotEmpty) {
              listTask = state.data;
              setViewTask();
            } else {
              listTask = [];
              setViewTask();
            }
          } else if (state is ChecklistSuccess) {
            if (state.data.isSucces) {
              getDash();
              getTask(filterDate);
            }
          } else if (state is DeleteTaskSuccess) {
            if (state.data.isSucces) {
              getDash();
              getTask(filterDate);
            }
          } else if (state is ChangeDateTaskSuccess) {
            if (state.data.isSucces) {
              getDash();
              getTask(filterDate);
            } else {
              context.showErrorSnackBar(
                state.data.message,
                onNavigate: () {}, // bottom close
              );
            }
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Stack(
              children: [
                _bodyData(context, size), // Latar belakang utama
                if (state is DashboardLoading ||
                    state is ChecklistLoading ||
                    state is DeleteTaskLoading ||
                    state is ChangeDateTaskLoading) ...[
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
      child: Column(
        children: [
          Container(
            height: size.height * 0.31,
            width: size.width,
            padding: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mini Task',
                      style: blackTextstyle.copyWith(
                        fontSize: 25,
                        fontWeight: bold,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReportScreen(),
                              ),
                            );
                          },
                          child: iconTitleRight(MediaRes.allTask),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateTaskScreen(),
                              ),
                            );
                          },
                          child: iconTitleRight(MediaRes.addTask),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: size.height * 0.04),
                infoTitleTask(MediaRes.task, inDayTask, 'Task'),
                infoTitleTask(MediaRes.finishTask, inDayFinishTask, 'Finish'),
                infoTitleTask(
                    MediaRes.penddingTask, inDayPenddingTask, 'Pendding'),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: listDate.map((e) {
                      return InkWell(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        onTap: () => selectedDate(e.date.toString()),
                        child: DateCircle(
                          dt: e,
                          inDay: inDay,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          // const Center(child: Text('dashboard')),
          Expanded(
            child: viewListTask.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: viewListTask.map((e) {
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          onTap: () {},
                          child: ViewList(
                            dt: e,
                            size: size,
                            onTapCheckBox: () {
                              checklistStatus(
                                e.id.toString(),
                                e.isStatus.toString(),
                              );
                            },
                            onDelete: () {
                              context
                                  .read<DashboardBloc>()
                                  .add(DeleteTask(id: e.id.toString()));
                            },
                            onInfo: () {
                              informationTaskDash(context, size, e);
                            },
                            onChange: () async {
                              String? selected =
                                  await changeDate(context, size, e.dateOn);
                              if (selected != null) {
                                reloadTask(e.id.toString(), selected);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : dataIsEmpty(),
          ),
          SizedBox(height: size.height * 0.01),
        ],
      ),
    );
  }

  Container iconTitleRight(String icons) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: AppColors.bgColor.withOpacity(0.7),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: SvgPicture.asset(
        icons,
        fit: BoxFit.contain,
        width: 20,
        // ignore: deprecated_member_use
        color: AppColors.bgBlack,
      ),
    );
  }

  Row infoTitleTask(String icon, value, name) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          fit: BoxFit.contain,
          width: 20,
          // ignore: deprecated_member_use
          color: AppColors.bgBlack,
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: blackTextstyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: name,
                  style: blackTextstyle.copyWith(
                    fontSize: 15,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void selectedDate(String date) {
    var setDt = listDate.where((task) {
      return task.date == date;
    }).toList();
    inDay = setDt[0].date.toString();
    inDayName = setDt[0].day.toString();
    inDayTask = setDt[0].taskToday.toString();
    inDayFinishTask = setDt[0].taskFinish.toString();
    inDayPenddingTask = setDt[0].taskPendding.toString();
    String dates = DateFormat('yyyy-MM-dd').format(setDt[0].dateTime ?? now);
    filterDate = dates;
    getTask(dates);
  }

  void setViewTask() {
    viewListTask = [];
    viewListTask = listTask;
    if (listTask.isNotEmpty) {
      List<TaskModel> setDt = listTask.where((task) {
        return task.dateOn!.year == now.year &&
            task.dateOn!.month == now.month &&
            task.dateOn!.day == now.day;
      }).toList();
      // Hitung jumlah task
      int taskToday = setDt.length;
      int taskFinished = setDt.where((task) => task.isStatus == 'true').length;
      int taskPending = taskToday - taskFinished;
      inDayTask = taskToday.toString();
      inDayFinishTask = taskFinished.toString();
      inDayPenddingTask = taskPending.toString();
    }
    // setState(() {});
  }

  void checklistStatus(String id, String isStatus) {
    String result = '';
    if (isStatus == 'true') {
      result = 'false';
    } else {
      result = 'true';
    }
    context
        .read<DashboardBloc>()
        .add(Checklist(id: id.toString(), data: result));
  }

  void reloadTask(String id, String date) {
    bool inputDate = isValidDate(date);
    if (inputDate) {
      context
          .read<DashboardBloc>()
          .add(ChangeDateTask(id: id.toString(), date: date));
    } else {
      context.showErrorSnackBar(
        'Tanggal tidak tersedia, coba lagi',
        onNavigate: () {}, // bottom close
      );
    }
  }

  bool isValidDate(String date) {
    try {
      List<String> parts = date.split(" ");
      String datePart = parts[0]; // Ambil bagian tanggal, misalnya "2025-02-29"

      List<String> dateComponents = datePart.split("-");
      if (dateComponents.length != 3) return false;

      int year = int.parse(dateComponents[0]);
      int month = int.parse(dateComponents[1]);
      int day = int.parse(dateComponents[2]);

      // ✅ Pastikan bulan dalam rentang yang benar (1 - 12)
      if (month < 1 || month > 12) return false;

      // ✅ Pastikan hari tidak melebihi jumlah hari dalam bulan itu
      int maxDaysInMonth = DateTime(year, month + 1, 0).day;
      if (day < 1 || day > maxDaysInMonth) return false;

      return true; // ✅ Tanggal valid
    } catch (e) {
      return false; // ❌ Jika ada error, berarti tanggal tidak valid
    }
  }
}
