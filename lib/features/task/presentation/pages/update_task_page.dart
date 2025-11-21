import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/botton.dart';
import 'package:mitask/core/utils/color_tag_selector.dart';
import 'package:mitask/core/utils/custm_checklist.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/core/utils/date_utils.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/domain/usecases/params/update_task_params.dart';
import 'package:mitask/features/task/presentation/bloc/task_bloc.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';

class UpdateTaskPage extends StatefulWidget {
  final TaskEntity data;
  const UpdateTaskPage({super.key, required this.data});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late TaskBloc _taskBloc;
  TaskEntity? _task;
  final TextEditingController titleCtr = TextEditingController();
  final TextEditingController subtitleCtr = TextEditingController();
  final TextEditingController notesCtr = TextEditingController();
  final TextEditingController dateCtr = TextEditingController();
  final TextEditingController reminderDateCtr = TextEditingController();
  String? errorTitle;
  String? errorReminderDate;
  int priority = 0;
  int tagColors = 0;
  bool isPinned = false;
  bool isFavorite = false;
  bool isArchived = false;
  bool isSaved = false;
  String statusName = '-';
  Color colors = AppColors.primary;

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    _task = widget.data;
    setInit();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      title: 'Task',
      showBackButton: true,
      backgroundColor: AppColors.background,
      actions: [
        CustomInkWell(
          onTap: () {
            _taskBloc.add(DeleteRequested(id: widget.data.id));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                MediaRes.trash,
                width: 30,
                height: 33,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is UpdateLoading || state is DeleteLoading) {
            LoadingScreen.show(context);
          } else if (state is UpdateLoaded) {
            LoadingScreen.hide(context);
            Popup.showSuccess(
              context,
              title: 'Berhasil',
              message: state.data,
              onButtonPressed: () => setState(() => isSaved = false),
            );
          } else if (state is DeleteLoaded) {
            LoadingScreen.hide(context);
            Popup.showSuccess(
              context,
              title: 'Berhasil',
              message: state.data,
              onButtonPressed: () => context.popPage(),
            );
          } else if (state is UpdateFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          } else if (state is DeleteFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          }
        },
        child: _bodyForm(context, size),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: UIButton(
          type: isSaved ? UIButtonType.filled : UIButtonType.tonal,
          size: UIButtonSize.medium,
          child: Text(
            'Saved',
            style: AppTextStyle.background.copyWith(fontWeight: semiBold),
          ),
          onPressed: () {
            if (validateForm() && isSaved) {
              onSaved();
            }
          },
        ),
      ),
    );
  }

  Widget _bodyForm(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: ListView(
        children: [
          UIButton(
            type: UIButtonType.outlined,
            size: UIButtonSize.medium,
            color: colors,
            child: Text(
              statusName,
              style: AppTextStyle.body.copyWith(
                fontWeight: semiBold,
                color: colors,
              ),
            ),
          ),
          SizedBox(height: 15),
          CustomTextField(
            label: 'Title',
            isRequired: true,
            hintText: 'Masukkan judul task kamu',
            controller: titleCtr,
            errorText: errorTitle,
            onChanged: (value) => saved(),
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: 'Subtitle',
            hintText: 'Deskripsi singkat / detail task',
            controller: subtitleCtr,
            onChanged: (value) => saved(),
          ),
          SizedBox(height: 10),
          CustomNoteField(
            label: 'Notes',
            hintText: 'Catatan tambahan',
            controller: notesCtr,
            onChanged: (value) => saved(),
          ),
          SizedBox(height: 10),
          Text(
            'Task Date',
            style: AppTextStyle.body.copyWith(fontWeight: medium),
          ),
          SizedBox(height: 10),
          CustomDateInput(
            controller: dateCtr,
            hintText: 'Pilih tanggal dan waktu',
            onTap: () => saved(),
          ),
          SizedBox(height: 10),
          Text(
            'Reminder Date',
            style: AppTextStyle.body.copyWith(fontWeight: medium),
          ),
          SizedBox(height: 10),
          CustomDateInput(
            controller: reminderDateCtr,
            hintText: 'Pilih tanggal pengingat',
            errorText: errorReminderDate,
            onTap: () => saved(),
          ),
          SizedBox(height: 10),
          PrioritySelector(
            selectedValue: priority,
            onChanged: (val) {
              setState(() {
                priority = val;
                isSaved = true;
              });
            },
          ),
          SizedBox(height: 10),
          CustomOneSelector(
            title: 'Pinned',
            hint: 'Mark as pin',
            isSelected: isPinned,
            onTap: () {
              setState(() {
                isPinned = !isPinned;
                isSaved = true;
              });
            },
          ),
          SizedBox(height: 10),
          CustomOneSelector(
            title: 'Favorite',
            hint: 'Mark as favorite',
            isSelected: isFavorite,
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
                isSaved = true;
              });
            },
          ),
          SizedBox(height: 10),
          CustomOneSelector(
            title: 'Archived',
            hint: 'Mark as archived',
            isSelected: isArchived,
            onTap: () {
              setState(() {
                isArchived = !isArchived;
                isSaved = true;
              });
            },
          ),
          SizedBox(height: 10),
          TagColorsSelector(
            selectedValue: tagColors,
            onChanged: (val) {
              setState(() {
                tagColors = val;
                isSaved = true;
              });
            },
          ),
          SizedBox(height: size.height * 0.08),
        ],
      ),
    );
  }

  void saved() {
    isSaved = true;
    setState(() {});
  }

  void setInit() {
    titleCtr.text = _task?.title ?? '';
    subtitleCtr.text = _task?.subtitle ?? '';
    notesCtr.text = _task?.notes ?? '';
    dateCtr.text = timestampToDateString(_task?.dateOn);
    reminderDateCtr.text = timestampToDateString(_task?.reminderOn);
    priority = _task?.priority ?? 0;
    isPinned = _task?.isPinned == 1 ? true : false;
    isFavorite = _task?.isFavorite == 1 ? true : false;
    isArchived = _task?.isArchived == 1 ? true : false;
    tagColors = _task?.colorTag ?? 0;

    // status
    statusName = _task?.statusName ?? '-';
    if (_task?.statusName == StringResources.statusHoldProgres) {
      colors = AppColors.warning;
    } else if (_task?.statusName == StringResources.statusComplated) {
      colors = AppColors.primary;
    } else {
      colors = AppColors.disabledText;
    }
    setState(() {});
  }

  bool validateForm() {
    errorTitle = null;
    errorReminderDate = null;
    final title = titleCtr.text.trim();
    // --- 1. Validasi Title ---
    if (title.isEmpty) {
      errorTitle = 'Title task wajib diisi';
    }

    // --- 2. Validasi Reminder vs Date ---
    final date = parseDate(dateCtr.text);
    final reminderDate = parseDate(reminderDateCtr.text);

    if (date != null && reminderDate != null) {
      // Cek apakah tanggal reminder (reminderDate) LEBIH AWAL dari tanggal utama (date)
      // .isBefore akan mengembalikan true jika reminderDate < date.
      if (reminderDate.isBefore(date)) {
        errorReminderDate = 'Pengingat harus setelah tanggal tugas.';
      }
    }

    setState(() {});
    if (errorTitle != null || errorReminderDate != null) {
      return false;
    }
    return true;
  }

  void onSaved() {
    final int createdOn = DateTime.now().millisecondsSinceEpoch;
    final int reminderAndDateOn = dateStringToTimestamp(reminderDateCtr.text);
    final int dateOn = dateStringToTimestamp(dateCtr.text);
    final UpdateTaskParams params = UpdateTaskParams(
      id: widget.data.id,
      title: titleCtr.text.trim(),
      subtitle: subtitleCtr.text.trim(),
      notes: notesCtr.text.trim(),
      isFavorite: isFavorite ? 1 : 0,
      isPinned: isPinned ? 1 : 0,
      priority: priority,
      reminderOn: reminderAndDateOn,
      dateOn: dateOn,
      createdOn: widget.data.createdOn ?? 0,
      updatedOn: createdOn,
      colorTag: tagColors,
    );
    _taskBloc.add(UpdateRequested(data: params));
  }
}
