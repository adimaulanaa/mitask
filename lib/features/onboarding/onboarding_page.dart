import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/onboarding/name_input_page.dart';
import 'package:mitask/features/onboarding/onboarding_content.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/navigator_page.dart';
import 'package:mitask/services_locator.dart';
import 'package:sqflite/sqflite.dart';

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

  void _finishOnboarding() async {
    final name = nameController.text.trim();
    storage.displayName = name;

    // STEP 1 — Clear old database (only once, during onboarding finish)
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/mitask_database.db';

    await DatabaseService().closeDatabase(); // tutup koneksi
    await deleteDatabase(path); // hapus database lama

    // STEP 2 — Mark as initialized → app won’t reset DB again next launch
    storage.isInitialization = true;

    // STEP 3 — Navigate to home
    // ignore: use_build_context_synchronously
    context.pushAndRemoveUntilPage(
      const NavigatorPage(),
      type: TransitionType.slide,
    );
  }

  late final List<Widget> _pages = [
    const OnboardingContent(
      image: MediaRes.onboarding,
      title: 'Selamat Datang di MiTask',
      subtitle:
          'Aplikasi manajemen tugas sederhana untuk membantumu tetap teratur dan produktif setiap hari.',
    ),
    const OnboardingContent(
      image: MediaRes.onboarding,
      title: 'Kelola Tugas Tanpa Ribet',
      subtitle:
          'Catat, susun, dan selesaikan tugas harianmu dengan lebih mudah dan cepat.',
    ),
    const OnboardingContent(
      image: MediaRes.onboarding,
      title: 'Prioritas & Pengingat Otomatis',
      subtitle:
          'Tandai tugas penting dan aktifkan pengingat agar tidak ada lagi jadwal yang terlewat.',
    ),
    NameInputPage(controller: nameController, onNext: _finishOnboarding),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
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
                  color: AppColors.background,
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
                      ? AppColors.background
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
                color: AppColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
