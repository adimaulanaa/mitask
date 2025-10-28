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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(MediaRes.onboarding, height: size.height * 0.3),
          const SizedBox(height: 30),
          Text(
            "Mari Kenalan 👋",
            style: AppTextStyle.h3.copyWith(
              fontWeight: bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Berikan nama kamu agar kami bisa menyapamu setiap hari.",
            textAlign: TextAlign.center,
            style: AppTextStyle.body.copyWith(color: AppColors.disabledText),
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: "Nama Kamu",
            hintText: "Masukan nama kamu (Opsional)",
            controller: widget.controller,
            errorText: _errorText,
          ),
          const SizedBox(height: 20),
          UIButton(
            type: UIButtonType.filled,
            size: UIButtonSize.medium,
            child: Text(
              'Mulai Sekarang',
              style: AppTextStyle.background.copyWith(fontWeight: semiBold),
            ),
            onPressed: () => widget.onNext(),
          ),
          const SizedBox(height: 12),
          Text(
            "Kamu bisa ubah nama ini nanti di Pengaturan.",
            style: AppTextStyle.small.copyWith(color: AppColors.disabledText),
          ),
        ],
      ),
    );
  }
}
