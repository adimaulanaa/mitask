import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/onboarding/name_input_page.dart';
import 'package:mitask/features/onboarding/onboarding_content.dart';
import 'package:mitask/navigator_page.dart';
import 'package:mitask/services_locator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final storage = sl<StorageProvider>();
  final PageController _pageController = PageController();
  final TextEditingController nameController = TextEditingController();
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    final name = nameController.text.trim();
    storage.displayName = name;
    storage.isInitialization = true;
    context.pushAndRemoveUntilPage(
      const NavigatorPage(),
      type: TransitionType.slide,
    );
  }

  late final List<Widget> _pages = [
    const OnboardingContent(
      image: MediaRes.onboarding,
      title: 'Selamat Datang di Mini Task',
      subtitle:
          'Aplikasi sederhana untuk membantu kamu mengatur tugas harian dengan mudah.',
    ),
    const OnboardingContent(
      image: MediaRes.onboarding,
      title: 'Ingatkan Diri dengan Reminder',
      subtitle:
          'Jangan lewatkan tugas penting. Atur pengingat sesuai kebutuhanmu.',
    ),
    const OnboardingContent(
      image: MediaRes.onboarding,
      title: 'Atur Prioritas Tugas',
      subtitle:
          'Tandai mana yang penting dan mana yang bisa nanti. Fokus pada hal utama setiap hari.',
    ),
    NameInputPage(controller: nameController, onNext: _finishOnboarding),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemBuilder: (_, index) => _pages[index],
              ),
            ),
            const SizedBox(height: 10),
            _buildBottomControls(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    final isLastPage = currentPage == _pages.length - 1;

    if (isLastPage) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol kembali (hanya muncul jika bukan halaman pertama)
          if (currentPage != 0)
            TextButton(
              onPressed: _previousPage,
              child: Text(
                "Kembali",
                style: AppTextStyle.body.copyWith(
                  fontWeight: semiBold,
                  color: AppColors.primary,
                ),
              ),
            )
          else
            const SizedBox(width: 80),

          // Dots indicator
          Row(
            children: List.generate(
              _pages.length - 1, // tanpa halaman input nama
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Tombol lanjut
          TextButton(
            onPressed: _nextPage,
            child: Text(
              "Lanjut",
              style: AppTextStyle.body.copyWith(
                fontWeight: semiBold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
