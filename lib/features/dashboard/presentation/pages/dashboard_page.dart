import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: false,
      body: Center(
        child: Text(
          'Dashboard Page',
          style: AppTextStyle.body,
        ),
      ),
    );
  }
}