import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/presentation/bloc/task_bloc.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';
import 'package:mitask/features/task/presentation/widgets/custom_floating.dart';
import 'package:mitask/features/task/presentation/widgets/list_task.dart';
import 'package:mitask/features/task/presentation/widgets/widget_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskBloc _taskBloc;
  final TextEditingController searchCtr = TextEditingController();
  final TextEditingController startDateCtr = TextEditingController();
  final TextEditingController endDateCtr = TextEditingController();
  List<TaskEntity> taskData = [];
  bool isFilter = false;
  bool isAll = true;
  bool isPin = false;
  bool isFav = false;
  bool isArch = false;

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    _taskBloc.add(TaskRequested());
  }

  @override
  Widget build(BuildContext context) {
    // Catatan: SizedBox(height: size.height * 0.08) 
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: null,
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskLoading) {
            LoadingScreen.show(context);
          } else if (state is TaskLoaded) {
            taskData.addAll(state.data);
            LoadingScreen.hide(context);
          } else if (state is TaskFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          }
        },
        child: _bodyForm(context),
      ),
      floatingActionButton: CustomExpandedFAB(
        onPressed: () {
          debugPrint('Tombol Add Task Kustom Ditekan');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                SearchTextField(hintText: 'Cari Task..', controller: searchCtr),
                const SizedBox(height: 10),
                isFilter ? _advFilter() : _iconsFilter(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 70),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ListTask();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconsFilter() {
    return Row(
      children: [
        const Spacer(),
        CustomInkWell(
          onTap: () {
            setState(() {
              isFilter = !isFilter;
            });
          },
          child: SvgPicture.asset(
            MediaRes.filter,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _advFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDateInput(
                controller: startDateCtr,
                hintText: 'Awal',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomDateInput(controller: endDateCtr, hintText: 'Akhir'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            BoxTypeAllFilter(
              text: 'All',
              active: isAll,
              onTap: () => selectTpye(0),
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.pinned,
              active: isPin,
              onTap: () => selectTpye(1),
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.favorite,
              active: isFav,
              onTap: () => selectTpye(2),
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.archived,
              active: isArch,
              onTap: () => selectTpye(3),
            ),
          ],
        ),
        SizedBox(height: 5),
        CustomInkWell(
          onTap: () {
            setState(() {
              isAll = true;
              isPin = false;
              isFav = false;
              isArch = false;
              startDateCtr.clear();
              endDateCtr.clear();
              isFilter = !isFilter;
            });
          },
          child: SvgPicture.asset(
            MediaRes.filterRemove,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  void selectTpye(int idx) {
    if (idx == 0) {
      isAll = true;
      isPin = false;
      isFav = false;
      isArch = false;
    } else if (idx == 1) {
      isPin = !isPin;
      isAll = false;
    } else if (idx == 2) {
      isFav = !isFav;
      isAll = false;
    } else if (idx == 3) {
      isArch = !isArch;
      isAll = false;
    }
    setState(() {});
  }
}
