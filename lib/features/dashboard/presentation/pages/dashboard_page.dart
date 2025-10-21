import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:mitask/features/dashboard/presentation/widgets/dashboard_stats.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _dashboardBloc;
  String myName = 'Adi';
  int notes = 0;

  @override
  void initState() {
    super.initState();
    _dashboardBloc = context.read<DashboardBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dashboardBloc = context.read<DashboardBloc>();
    _dashboardBloc.add(DashboardRequested());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: null,
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoading) {
            LoadingScreen.show(context);
          } else if (state is DashboardLoaded) {
            LoadingScreen.hide(context);
          } else if (state is DashboardFailure) {
            LoadingScreen.hide(context);
            Popup.showError(context, title: 'Gagal', message: state.message);
          }
        },
        child: _bodyForm(context, size),
      ),
    );
  }

  Widget _bodyForm(BuildContext context, Size size) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: ListView(
          children: [
            buildGreetingSection(myName, notes),
            SizedBox(height: 15),
            Text(
              'Quick Stats',
              style: AppTextStyle.textPrimary.copyWith(
                fontWeight: bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 7),
            QuickStatsSection(
              totalTask: 24,
              pinnedTask: 5,
              favoriteTask: 4,
              archivedTask: 5,
            ),
            SizedBox(height: 15),
            Text(
              'Recent Task',
              style: AppTextStyle.textPrimary.copyWith(
                fontWeight: bold,
                fontSize: 18,
              ),
            ),
            RecentTask(),
            RecentTask(),
            RecentTask(),
          ],
        ),
      ),
    );
  }

  Widget buildGreetingSection(String myName, int notes) {
    final bool hasTasks = notes > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, $myName 👋',
          style: AppTextStyle.primaryDark.copyWith(
            fontWeight: bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hasTasks
              ? 'Ada $notes catatan yang menunggu untuk kamu selesaikan 🌿'
              : 'Belum ada catatan hari ini, waktu yang pas untuk bersantai ☕️',
          style: AppTextStyle.textSecondary.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
