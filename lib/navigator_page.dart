import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:mitask/features/report/report_page.dart';
import 'package:mitask/features/task/presentation/pages/task_page.dart';

class NavigatorPage extends StatefulWidget {
  final int index;
  const NavigatorPage({super.key, this.index = 0});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedIndex = 0;

  // Halaman yang akan ditampilkan (hanya 5)
  late final List<Widget> _pages;

  // Data item navigasi
  late final List<_NavItemData> _navItems;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
    // Inisialisasi langsung 5 halaman dan 5 item navigasi
    _setupPagesAndNavItems();
  }

  void _setupPagesAndNavItems() {
    // Menetapkan 5 Halaman Utama
    _pages = [
      const DashboardPage(),
      const TaskPage(),
      const ReportPage(),
    ];

    // Menetapkan 4 Item Navigasi
    _navItems = [
      _NavItemData(icon: MediaRes.dashboard, label: 'Dashboard', index: 0),
      _NavItemData(icon: MediaRes.task, label: 'Task', index: 1),
      _NavItemData(icon: MediaRes.report, label: 'Report', index: 2),
    ];
  }

  void _onItemTapped(int index) {
    // Memastikan indeks valid sebelum setState
    if (index >= 0 && index < _navItems.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // Dapatkan padding bawah dari sistem
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // Cek untuk menghindari error jika _navItems belum terinisialisasi (meskipun seharusnya tidak terjadi setelah initState)
    if (_navItems.isEmpty || _pages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      // Pastikan index tidak melebihi batas (walaupun _selectedIndex = 0 di awal)
      body: _pages[_selectedIndex],
      backgroundColor: AppColors.background,

      bottomNavigationBar: Container(
        // Tambahkan padding bawaan Anda (8) PLUS padding bawah sistem
        padding: EdgeInsets.only(top: 8, bottom: 8 + bottomPadding),
        decoration: const BoxDecoration(
          color: AppColors.background,
          // boxShadow: [
          //   // Tambahkan shadow ringan agar terpisah dari body
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 4,
          //     offset: Offset(0, -2),
          //   ),
          // ],
        ),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navItems
                .map((item) => _navItem(item.index, item.icon, item.label, 24))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, String iconPath, String label, double sizeIcons) {
    bool isSelected = _selectedIndex == index;
    double iconsSize = sizeIcons + 2;
    double finalSize = isSelected ? iconsSize : sizeIcons;

    return CustomInkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: finalSize,
            // Perbaiki penggunaan colorFilter untuk menghindari deprecated warning
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.primary : AppColors.disabledText,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle.small.copyWith(
              fontWeight: isSelected ? semiBold : medium,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
          // SizedBox(height: 5),
        ],
      ),
    );
  }

  // responseFailure dihapus karena tidak lagi digunakan
}

class _NavItemData {
  final String icon;
  final String label;
  final int index;

  _NavItemData({required this.icon, required this.label, required this.index});
}
