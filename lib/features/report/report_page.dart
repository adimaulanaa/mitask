import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_text.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(
      children: [
        Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                ),
        Center(child: Text('Report Page', style: AppTextStyle.body)),
      ],
    ));
  }
}