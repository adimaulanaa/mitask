import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/botton.dart';
import 'package:mitask/core/utils/color_tag_selector.dart';
import 'package:mitask/core/utils/custm_checklist.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/core/utils/date_utils.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';
import 'package:mitask/features/task/presentation/bloc/task_bloc.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late TaskBloc _taskBloc;
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

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    setInit();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      title: 'Add New Task',
      backgroundColor: AppColors.background,
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is CreateLoading) {
            LoadingScreen.show(context);
          } else if (state is CreateLoaded) {
            LoadingScreen.hide(context);
            Popup.showSuccess(
              context,
              title: 'Berhasil',
              message: state.data,
              onButtonPressed: () => context.popPage(),
            );
          } else if (state is CreateFailure) {
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
          type: UIButtonType.filled,
          size: UIButtonSize.medium,
          child: Text(
            'Saved',
            style: AppTextStyle.background.copyWith(fontWeight: semiBold),
          ),
          onPressed: () {
            if (validateForm()) {
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
          CustomTextField(
            label: 'Title',
            isRequired: true,
            hintText: 'Masukkan judul task kamu',
            controller: titleCtr,
            errorText: errorTitle,
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: 'Subtitle',
            hintText: 'Deskripsi singkat / detail task',
            controller: subtitleCtr,
          ),
          SizedBox(height: 10),
          CustomNoteField(
            label: 'Notes',
            hintText: 'Catatan tambahan',
            controller: notesCtr,
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
            onTap: () {},
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
            onTap: () {},
          ),
          SizedBox(height: 10),
          PrioritySelector(
            selectedValue: priority,
            onChanged: (val) {
              setState(() {
                priority = val;
              });
            },
          ),
          SizedBox(height: 10),
          CustomOneSelector(
            title: 'Pinned',
            hint: 'Mark as pin',
            isSelected: isPinned,
            onTap: () => setState(() => isPinned = !isPinned),
          ),
          SizedBox(height: 10),
          CustomOneSelector(
            title: 'Favorite',
            hint: 'Mark as favorite',
            isSelected: isFavorite,
            onTap: () => setState(() => isFavorite = !isFavorite),
          ),
          SizedBox(height: 10),
          TagColorsSelector(
            selectedValue: tagColors,
            onChanged: (val) {
              setState(() {
                tagColors = val;
              });
            },
          ),
          SizedBox(height: size.height * 0.08),
        ],
      ),
    );
  }

  void setInit() {
    DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd MMM yyyy').format(now);
    dateCtr.text = formattedDate;
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
    final CreateTaskParams params = CreateTaskParams(
      title: titleCtr.text.trim(),
      subtitle: subtitleCtr.text.trim(),
      notes: notesCtr.text.trim(),
      isFavorite: isFavorite ? 1 : 0,
      isPinned: isPinned ? 1 : 0,
      priority: priority,
      reminderOn: reminderAndDateOn,
      dateOn: dateOn,
      createdOn: createdOn,
      updatedOn: createdOn,
      colorTag: tagColors,
    );
    _taskBloc.add(CreateRequested(data: params));
  }
}
