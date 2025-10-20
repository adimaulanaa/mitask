import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_loading.dart';
import 'package:mitask/core/utils/custom_popup.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _dashboardBloc;

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
      child: Column(
        children: [
          Container(
            height: size.height * 0.31,
            width: size.width,
            padding: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),

          Center(child: Text('Dashboard Page', style: AppTextStyle.body)),
        ],
      ),
    );
  }
}
