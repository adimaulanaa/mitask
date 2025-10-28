import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/onboarding/onboarding_page.dart';
import 'package:mitask/navigator_page.dart';
import 'package:mitask/services_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = sl<StorageProvider>();

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    // Penambahan delay 4 detik
    await Future.delayed(const Duration(seconds: 4));

    // Pastikan widget masih terpasang
    if (!mounted) return;

    // 3. Logika Navigasi
    if (storage.isInitialization) {
      if (!mounted) return;
      // Jika 'onboarding' true (sudah dilihat), pindah ke Login
      context.pushAndRemoveUntilPage(
        const NavigatorPage(),
        type: TransitionType.slide,
      );
    } else {
      if (!mounted) return;
      // Jika 'onboarding' false (belum dilihat), pindah ke Onboarding
      context.pushAndRemoveUntilPage(
        const OnboardingPage(),
        type: TransitionType.slide,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.20),

          // Logo utama
          Center(
            child: Image.asset(
              MediaRes.onboarding,
              width: size.width * 0.6,
              height: size.height * 0.2,
              fit: BoxFit.contain,
              color: AppColors.background,
            ),
          ),

          SizedBox(height: size.height * 0.08),

          // Tambahan animasi teks / pesan pembuka
          Text(
            "Selamat Datang 👋",
            style: AppTextStyle.h3.copyWith(
              color: AppColors.background,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Mulai hari dengan perencanaan yang lebih baik",
            textAlign: TextAlign.center,
            style: AppTextStyle.small.copyWith(color: AppColors.background),
          ),

          SizedBox(height: size.height * 0.25),

          // Tagline & credit
          Column(
            children: [
              Text(
                'App Mini Task — Organize your day',
                style: AppTextStyle.small.copyWith(
                  fontWeight: semiBold,
                  color: AppColors.background,
                ),
              ),
              Text(
                'by Adi Maulana',
                style: AppTextStyle.small.copyWith(color: AppColors.background),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
