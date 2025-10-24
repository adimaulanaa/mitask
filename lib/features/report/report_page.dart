import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/features/report/widget_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: null,
      body: SafeArea(
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
              Text(
                'Periode: 1–21 Okt 2025',
                style: AppTextStyle.body.copyWith(fontWeight: medium),
              ),
              SizedBox(height: 15),
              _summaryData(),
              SizedBox(height: 10),
              const Divider(color: AppColors.border, thickness: 1, height: 20),
              SizedBox(height: 10),
              Text(
                'Productivity (7 Days)',
                style: AppTextStyle.body.copyWith(fontWeight: medium),
              ),
              SizedBox(height: 15),
              _summaryProgress(),
              SizedBox(height: 5),
              const Divider(color: AppColors.border, thickness: 1, height: 20),
              SizedBox(height: 10),
              Text(
                'High Priority',
                style: AppTextStyle.body.copyWith(fontWeight: medium),
              ),
              SizedBox(height: 15),
              heightPriority('Buat laporan proyek'),
              heightPriority('Kirim presentasi ke klien'),
              heightPriority('Buat laporan sales'),
              SizedBox(height: 10),
              const Divider(color: AppColors.border, thickness: 1, height: 20),
              SizedBox(height: 10),
              Text(
                'Progress kamu minggu ini: 80%',
                style: AppTextStyle.body.copyWith(fontWeight: medium),
              ),
              SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.8,
                  backgroundColor: AppColors.border.withValues(alpha: 0.7),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 8,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget heightPriority(String title) {
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
            title,
            style: AppTextStyle.caption.copyWith(fontWeight: regular),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _summaryData() {
    return Column(
      children: [
        SummaryItem(
          title: 'Completed',
          value: '24',
          iconPath: MediaRes.totalTask,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Pending',
          value: '6',
          iconPath: MediaRes.pinned,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Pinned',
          value: '3',
          iconPath: MediaRes.pinned,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
        const SizedBox(height: 10),
        SummaryItem(
          title: 'Favorite',
          value: '10',
          iconPath: MediaRes.favorite,
          iconBg: AppColors.border,
          iconColor: AppColors.primaryDark,
        ),
      ],
    );
  }

  Widget _summaryProgress() {
    return Column(
      children: [
        ProgressItems(title: 'Mon', value: 0.1),
        const SizedBox(height: 10),
        ProgressItems(title: 'Tue', value: 0.4),
        const SizedBox(height: 10),
        ProgressItems(title: 'Wed', value: 0.8),
        const SizedBox(height: 10),
        ProgressItems(title: 'Thu', value: 0.0),
        const SizedBox(height: 10),
        ProgressItems(title: 'Fri', value: 0.3),
        const SizedBox(height: 10),
        ProgressItems(title: 'Sat', value: 0.1),
        const SizedBox(height: 10),
        ProgressItems(title: 'Sun', value: 0.2),
        const SizedBox(height: 10),
      ],
    );
  }
}
