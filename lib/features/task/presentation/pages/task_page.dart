import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/core/utils/date_utils.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/domain/usecases/params/task_filter_params.dart';
import 'package:mitask/features/task/presentation/bloc/task_bloc.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';
import 'package:mitask/features/task/presentation/pages/create_task_page.dart';
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
  List<TaskEntity> _taskData = [];
  List<TaskEntity> _filterTaskData = [];
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
          if (state is TaskLoading || state is FilterLoading) {
            LoadingScreen.show(context);
          } else if (state is TaskLoaded) {
            LoadingScreen.hide(context);
            setState(() {
              _taskData = state.data;
              _filterTaskData = _taskData;
            });
          } else if (state is FilterLoaded) {
            LoadingScreen.hide(context);
            setState(() {
              _taskData = state.data;
              _filterTaskData = _taskData;
            });
          } else if (state is TaskFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          } else if (state is FilterFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          }
        },
        child: _bodyForm(context, _taskData),
      ),
      floatingActionButton: CustomExpandedFAB(
        onPressed: () async {
          await context.pushPage(
            const CreateTaskPage(),
            type: TransitionType.slide,
          );
          _taskBloc.add(TaskRequested());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyForm(BuildContext context, List<TaskEntity> taskData) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                SearchTextField(
                  hintText: 'Cari Task..',
                  controller: searchCtr,
                  onChanged: (value) {
                    filterData();
                  },
                ),
                const SizedBox(height: 10),
                isFilter ? _advFilter() : _iconsFilter(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: _filterTaskData.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 70),
                    itemCount: _filterTaskData.length,
                    itemBuilder: (context, index) {
                      final task = _filterTaskData[index];
                      return ListTask(data: task);
                    },
                  )
                : ListIsEmpty(),
          ),
        ],
      ),
    );
  }

  void filterData() {
    TaskFilterParams currentParams = TaskFilterParams(
      query: searchCtr.text.trim(),
      isPin: isPin,
      isFav: isFav,
      isArch: isArch,
      startDate: parseDate(startDateCtr.text),
      endDate: parseDate(endDateCtr.text),
    );
    _taskBloc.add(FilterRequested(data: currentParams));
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
                onTap: () {
                  filterData();
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomDateInput(
                controller: endDateCtr,
                hintText: 'Akhir',
                onTap: () {
                  filterData();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            BoxTypeAllFilter(
              text: 'All',
              active: isAll,
              onTap: () {
                selectTpye(0);
                filterData();
              },
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.pinned,
              active: isPin,
              onTap: () {
                selectTpye(1);
                filterData();
              },
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.favorite,
              active: isFav,
              onTap: () {
                selectTpye(2);
                filterData();
              },
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.archived,
              active: isArch,
              onTap: () {
                selectTpye(3);
                filterData();
              },
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
