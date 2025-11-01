import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/botton.dart';
import 'package:mitask/core/utils/custom_text_field.dart';

class NameInputPage extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onNext;
  const NameInputPage({
    super.key,
    required this.controller,
    required this.onNext,
  });

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  String? _errorText;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(MediaRes.onboarding, height: size.height * 0.3),
              const SizedBox(height: 30),
              Text(
                "Mari Kenalan 👋",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: bold,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Berikan nama kamu agar kami bisa menyapamu setiap hari.",
                textAlign: TextAlign.center,
                style: AppTextStyle.body.copyWith(color: AppColors.background),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                label: "Nama Kamu",
                colorLabel: AppColors.background,
                hintText: "Masukan nama kamu (Opsional)",
                controller: widget.controller,
                errorText: _errorText,
              ),
              const SizedBox(height: 20),
              UIButton(
                type: UIButtonType.filled,
                size: UIButtonSize.medium,
                color: AppColors.background,
                child: Text(
                  'Mulai Sekarang',
                  style: AppTextStyle.primary.copyWith(fontWeight: semiBold),
                ),
                onPressed: () => widget.onNext(),
              ),
              const SizedBox(height: 12),
              Text(
                "Kamu bisa ubah nama ini nanti di Pengaturan.",
                style: AppTextStyle.small.copyWith(color: AppColors.background),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
