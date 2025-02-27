import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/loading_helpers.dart';
import 'package:mitask/core/utils/snackbar_extension.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:mitask/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:mitask/features/dashboard/presentation/widgets/view_date.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final ScrollController _scrollController = ScrollController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final notesController = TextEditingController();
  final typeController = TextEditingController();

  List<DateModel> listDate = [];
  DateTime now = DateTime.now();
  DateTime? dateOn;
  String? selectedType;
  String inDay = '';
  List<String> listType = ['Work', 'Personal'];

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
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(
          StringResources.createTask,
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
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is CreateTaskError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is DashboardError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is CreateTaskSuccess) {
            if (state.data.isSucces) {
              context.showSuccesSnackBar(
                state.data.message,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is DashboardLoaded) {
            if (state.data.isNotEmpty) {
              listDate = state.data;
              dateOn = now;
              inDay = now.day.toString();
              scrollToToday();
            }
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Stack(
              children: [
                _bodyData(context, size), // Latar belakang utama
                if (state is CreateTaskLoading) ...[
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
      floatingActionButton: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: () {
          TaskModel create = TaskModel(
            id: '',
            title: titleController.text,
            subtitle: subtitleController.text,
            notes: notesController.text,
            isStatus: 'false',
            isType: selectedType ?? '',
            dateOn: dateOn,
            createdOn: now,
            updatedOn: now,
          );
          context.read<DashboardBloc>().add(CreateTask(data: create));
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  SingleChildScrollView _bodyData(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: listDate.map((e) {
                  return InkWell(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      inDay = e.date.toString();
                      dateOn = e.dateTime;
                      setState(() {});
                    },
                    child: DateRechgel(
                      dt: e,
                      inDay: inDay,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            textFormFieldCustom(titleController, StringResources.title),
            const SizedBox(height: 16),
            textFormFieldCustom(subtitleController, StringResources.subtitle),
            const SizedBox(height: 16),
            DropdownMenu(
              menuStyle: MenuStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.bgColor),
                surfaceTintColor: WidgetStateProperty.all(Colors.white),
                maximumSize:
                    WidgetStateProperty.all(const Size.fromHeight(180)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                        color: AppColors.primary), // Warna border default
                  ),
                ),
              ),
              textStyle: blackTextstyle.copyWith(
                fontSize: 15,
                fontWeight: semiBold,
              ),
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.tertiary),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                hintStyle: greyTextstyle.copyWith(
                  fontSize: 15,
                  fontWeight: semiBold,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.92,
              hintText: StringResources.type,
              initialSelection: selectedType,
              dropdownMenuEntries: listType.map((String unt) {
                return DropdownMenuEntry<String>(
                  value: unt,
                  label: unt,
                  labelWidget: Text(
                    unt,
                    style: blackTextstyle.copyWith(
                      fontSize: 15,
                      fontWeight: semiBold,
                    ),
                  ),
                );
              }).toList(),
              onSelected: (String? newValue) {
                selectedType = newValue ?? '';
              },
            ),
            const SizedBox(height: 16),
            textFormFieldCustom(notesController, StringResources.notes),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget textFormFieldCustom(
      TextEditingController titleContr, String hintText) {
    return TextFormField(
      controller: titleContr,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 13.0),
        hintStyle: transTextstyle.copyWith(
          fontSize: 15,
          color: AppColors.bgGrey,
          fontWeight: semiBold,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.tertiary,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: blackTextstyle.copyWith(
        fontSize: 15,
        fontWeight: semiBold,
      ),
      keyboardType: TextInputType.text,
    );
  }
}
