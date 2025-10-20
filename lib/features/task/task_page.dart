import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_text.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Task Page', style: AppTextStyle.body));
  }
}