import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/circular_progress_indicator.dart';
import 'package:mitask/core/utils/page_route.dart';

class LoadingScreen {
  static void show(BuildContext context, {String? text, Color? colorText}) {
    showDialog(
      context: context,
      barrierDismissible: false, // supaya tidak bisa tap luar untuk close
      barrierColor: Colors.black54, // warna background semi transparan
      builder: (_) => PopScope(
        canPop: false, // disable tombol back
        child: LoadingPageIndicator(text: text, colorText: colorText),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (context.canPopPage()) {
      context.popPage(); // ini sudah otomatis animasi reverse route yang tadi
    }
  }
}

class LoadingPage extends StatelessWidget {
  final String? text;
  final Color? colorText;
  const LoadingPage({super.key, this.text, this.colorText});

  @override
  Widget build(BuildContext context) {
    // Kalau text null → gunakan default
    final displayText = text ?? 'Loading...';
    // Kalau colorText null → default putih
    final displayColor = colorText ?? Colors.transparent;
    return Scaffold(
      backgroundColor: displayColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(MediaRes.logo, width: 100, height: 100, color: AppColors.primary),
            const SizedBox(height: 10),
            // Text Dynamic
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: AppTextStyle.h3.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingPageIndicator extends StatelessWidget {
  final String? text;
  final Color? colorText;
  const LoadingPageIndicator({super.key, this.text, this.colorText});

  @override
  Widget build(BuildContext context) {
    // Kalau text null → gunakan default
    final displayText = text ?? 'Loading...';
    // Kalau colorText null → default putih
    final displayColor = colorText ?? Colors.transparent;
    return Scaffold(
      backgroundColor: displayColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.asset(MediaRes.logo, width: 100, height: 100, color: AppColors.primary),
            RoundedLoadingIndicators(
              color: AppColors.primary,
              strokeWidth: 6, // bisa tebal berapa pun
              size: 50, // bisa custom ukuran
            ),
            const SizedBox(height: 10),
            // Text Dynamic
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: AppTextStyle.h3.copyWith(color: AppColors.textOnPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
