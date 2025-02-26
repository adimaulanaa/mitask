import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/loading_helpers.dart';
import 'package:mitask/core/utils/snackbar_extension.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/presentation/bloc/bloc.dart';
import 'package:mitask/features/dashboard/presentation/widgets/view_date.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  DateTime now = DateTime.now();
  List<DateModel> listDate = [];
  String inDay = '';
  String inDayName = '';
  String inDayTask = '';
  String inDayFinishTask = '';
  String inDayPenddingTask = '';

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const GetDashboard());
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
          } else if (state is DashboardLoaded) {
            if (state.data.isNotEmpty) {
              listDate = state.data;
              selectedDate(now.day.toString());
              scrollToToday();
            }
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Stack(
              children: [
                _bodyData(context, size), // Latar belakang utama
                if (state is DashboardLoading) ...[
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

  Column _bodyData(BuildContext context, Size size) {
    return Column(
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
                  Container(
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
                      MediaRes.addTask,
                      fit: BoxFit.contain,
                      // width: 20,
                      // ignore: deprecated_member_use
                      color: AppColors.bgBlack,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: size.height * 0.04),
              infoTitleTask(MediaRes.allTask, inDayTask, 'Task'),
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
                      onTap: () => selectedDate(e.date.toString()),
                      child: DateCircle(
                        date: e.date.toString(),
                        day: e.day.toString(),
                        inDay: inDay,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: size.height * 0.1),
        const Center(child: Text('dashboard')),
      ],
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
    setState(() {});
  }
}
