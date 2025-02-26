import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/utils/loading_helpers.dart';
import 'package:mitask/core/utils/snackbar_extension.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/presentation/bloc/bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DateModel> listDate = [];

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const GetDashboard());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            if (state.error != '') {
              context.showErrorSnackBar(
                state.error,
                onNavigate: () {}, // bottom close
              );
            }
          } else if (state is DashboardLoaded) {
            if (state.data.isNotEmpty) {
              listDate = state.data;
            }
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Stack(
              children: [
                _bodyData(context, size), // Latar belakang utama
                if (state is DashboardLoading ) ...[
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
    );
  }

  Column _bodyData(BuildContext context, Size size) {
    return Column(
      children: [
        Container(
          height: size.height * 0.33,
          width: size.width,
          decoration: const BoxDecoration(
            color: AppColors.bgMain,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.1),
        const Center(child: Text('dashboard')),
      ],
    );
  }
}
