import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/core/utils/empty_list.dart';
import 'package:mitask/features/report/domain/usecases/params/all_notes_params.dart';
import 'package:mitask/features/report/presentation/bloc/report_bloc.dart';
import 'package:mitask/features/report/presentation/bloc/report_event.dart';
import 'package:mitask/features/report/presentation/bloc/report_state.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/presentation/widgets/list_task.dart';

class AllNotesPage extends StatefulWidget {
  const AllNotesPage({super.key});

  @override
  State<AllNotesPage> createState() => _AllNotesPageState();
}

class _AllNotesPageState extends State<AllNotesPage> {
  late ReportBloc _reportBloc;
  final TextEditingController startCtr = TextEditingController();
  final TextEditingController endCtr = TextEditingController();
  String start = '';
  String end = '';
  List<TaskEntity> _taskData = [];

  @override
  void initState() {
    super.initState();
    _reportBloc = context.read<ReportBloc>();
    setInitial();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: true,
      title: 'Semua Notes',
      body: BlocListener<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is AllNotesLoading) {
            LoadingScreen.show(context);
          } else if (state is AllNotesLoaded) {
            LoadingScreen.hide(context);
            setState(() {
              _taskData = state.data;
            });
          } else if (state is AllNotesFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          }
        },
        child: _bodyForm(context),
      ),
    );
  }

  Widget _bodyForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomDateInput(
                  controller: startCtr,
                  isPrefix: false,
                  hintText: start,
                  onTap: () => onFiltered(),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomDateInput(
                  controller: endCtr,
                  isPrefix: false,
                  hintText: end,
                  onTap: () => onFiltered(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: _taskData.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 70),
                    itemCount: _taskData.length,
                    itemBuilder: (context, index) {
                      final task = _taskData[index];
                      return ListTask(
                        data: task,
                        onTap: () {},
                        onTapCheck: () {},
                      );
                    },
                  )
                : ListIsEmpty(),
          ),
        ],
      ),
    );
  }

  void onFiltered() {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final startData = startCtr.text != '' ? startCtr.text : start;
    final endData = endCtr.text != '' ? endCtr.text : end;
    DateTime startDate = formatter.parse(startData);
    DateTime endDate = formatter.parse(endData);
    final AllNotesParams data = AllNotesParams(
      startDate: startDate,
      endDate: endDate,
    );
    _reportBloc.add(AllNotesRequested(data: data));
  }

  void setInitial() {
    DateTime now = DateTime.now();

    // Tanggal pertama bulan ini
    DateTime firstDay = DateTime(now.year, now.month, 1);

    // Tanggal terakhir bulan ini → trik: bulan+1, tanggal 0 = last day previous month
    DateTime lastDay = DateTime(now.year, now.month + 1, 0);

    start = DateFormat('dd MMM yyyy').format(firstDay);
    end = DateFormat('dd MMM yyyy').format(lastDay);
    final AllNotesParams data = AllNotesParams(
      startDate: firstDay,
      endDate: lastDay,
    );
    _reportBloc.add(AllNotesRequested(data: data));
  }
}
