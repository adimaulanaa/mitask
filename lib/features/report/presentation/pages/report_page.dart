import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';
import 'package:mitask/core/utils/custom_select_field.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';
import 'package:mitask/features/report/presentation/bloc/report_bloc.dart';
import 'package:mitask/features/report/presentation/bloc/report_event.dart';
import 'package:mitask/features/report/presentation/bloc/report_state.dart';
import 'package:mitask/features/report/presentation/widgets/widget_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late ReportBloc _reportBloc;
  ReportEntity? _report;
  ProductivityEntity? productivityItems;
  List<ReportItemEntity> recentItems = [];
  String progressMonth = '';
  int days = 0;
  SelectOption? selectedPeriode;
  bool isSelected = false;
  final List<SelectOption> periodeOptions = [
    SelectOption(
      id: '1w',
      name: '1 Minggu Terakhir',
      label: '1 Minggu',
      days: 7,
    ),
    SelectOption(
      id: '2w',
      name: '2 Minggu Terakhir',
      label: '2 Minggu',
      days: 14,
    ),
    SelectOption(
      id: '3w',
      name: '3 Minggu Terakhir',
      label: '3 Minggu',
      days: 21,
    ),
    SelectOption(
      id: '1m',
      name: '1 Bulan Terakhir',
      label: '1 Bulan',
      days: 30,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _reportBloc = context.read<ReportBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.background,
      showAppBar: false,
      body: BlocListener<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is ReportLoading) {
            LoadingScreen.show(context);
          } else if (state is ReportLoaded) {
            LoadingScreen.hide(context);
            setState(() {
              _report = state.data;
              recentItems.clear();
              recentItems = _report?.recentItems ?? [];
              productivityItems = _report?.productivity;
            });
          } else if (state is ReportFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          }
        },
        child: _bodyForm(context),
      ),
    );
  }

  Widget _bodyForm(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'REPORT DASHBOARD',
                  style: AppTextStyle.h3.copyWith(fontWeight: semiBold),
                ),
                SvgPicture.asset(
                  MediaRes.totalTask,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryDark,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomSelectField(
              label: 'Periode',
              hintText: 'Pilih Periode',
              items: periodeOptions,
              selected: selectedPeriode,
              onChanged: (option) {
                setSelected(option);
              },
            ),
            SizedBox(height: 15),
            isSelected ? _summaryData() : SizedBox.shrink(),
            isSelected ? _summaryProgress() : SizedBox.shrink(),
            isSelected ? _heightPriority() : SizedBox.shrink(),
            isSelected ? _progressData() : SizedBox.shrink(),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _summaryData() {
    return Column(
      children: [
        SummaryItem(
          title: 'Total',
          value: _report?.total ?? 0,
          iconPath: MediaRes.totalTask,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Completed',
          value: _report?.complated ?? 0,
          iconPath: MediaRes.complated,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Pending',
          value: _report?.pending ?? 0,
          iconPath: MediaRes.notComplated,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Pinned',
          value: _report?.pinned ?? 0,
          iconPath: MediaRes.pinned,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Favorite',
          value: _report?.favorite ?? 0,
          iconPath: MediaRes.favorite,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        SizedBox(height: 10),
        SummaryItem(
          title: 'Archived',
          value: _report?.archived ?? 0,
          iconPath: MediaRes.archived,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        SizedBox(height: 10),
        const Divider(color: AppColors.border, thickness: 1, height: 20),
      ],
    );
  }

  Widget _summaryProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Productivity ($days Days)',
          style: AppTextStyle.body.copyWith(fontWeight: medium),
        ),
        SizedBox(height: 15),
        ProgressItems(title: 'Mon', value: productivityItems?.mon ?? 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Tue', value: productivityItems?.tue ?? 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Wed', value: productivityItems?.wed ?? 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Thu', value: productivityItems?.thu ?? 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Fri', value: productivityItems?.fri ?? 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Sat', value: productivityItems?.sat ?? 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Sun', value: productivityItems?.sun ?? 0.0),
        const SizedBox(height: 15),
        const Divider(color: AppColors.border, thickness: 1, height: 20),
      ],
    );
  }

  Widget _progressData() {
    final sum = productivityItems?.total ?? 0.0; // ini sudah 0.0–1.0
    final percent = (sum * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress kamu $progressMonth ini: $percent%',
          style: AppTextStyle.body.copyWith(fontWeight: medium),
        ),
        const SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: sum, // <-- langsung pakai nilai 0.0–1.0
            backgroundColor: AppColors.border.withValues(alpha: 0.7),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _heightPriority() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'High Priority',
          style: AppTextStyle.body.copyWith(fontWeight: medium),
        ),
        SizedBox(height: 15),
        recentItems.isNotEmpty
            ? Column(
                children: recentItems.map((e) {
                  // return Container();
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '•',
                        style: AppTextStyle.body.copyWith(
                          fontWeight: regular,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          e.title,
                          style: AppTextStyle.caption.copyWith(
                            fontWeight: regular,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )
            : Text(
                'Tidak ada data perioritas',
                style: AppTextStyle.caption.copyWith(fontWeight: regular),
              ),
        SizedBox(height: 10),
        const Divider(color: AppColors.border, thickness: 1, height: 20),
      ],
    );
  }

  void setSelected(SelectOption option) {
    setState(() {
      selectedPeriode = option;
      progressMonth = option.label;
      days = option.days;
      isSelected = true;
    });
    final data = ReportFilterParams(periodType: option.id);

    _reportBloc.add(ReportRequested(data: data));
  }
}
