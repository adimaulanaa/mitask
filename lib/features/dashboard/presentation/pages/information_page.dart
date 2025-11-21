import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: true,
      backgroundColor: AppColors.background,
      title: 'Informasi Aplikasi',
      body: Container(),
    );
  }
}
