import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/navigator_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const NavigatorPage(),
        ),
      );
    });
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
          SizedBox(height: size.height * 0.25,),
          Center(
            child: Image.asset(
              MediaRes.omboarding, // Ganti dengan path gambar Anda
              width: size.width * 0.7,
              height: size.height * 0.2,
              fit: BoxFit.contain,
              color: AppColors.background,
            ),
          ),
          SizedBox(height: size.height * 0.27,),
          Center(
            child: Text(
              'App Mini Task For Everything task daily',
              style: AppTextStyle.small.copyWith(fontWeight: semiBold, color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'By Adi Maulana',
              style: AppTextStyle.small.copyWith(fontWeight: semiBold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
