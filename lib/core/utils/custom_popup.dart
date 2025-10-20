import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/botton.dart';
import 'package:mitask/core/utils/page_route.dart';

class Popup {
  /// Popup Sukses
  static Future<void> showSuccess(
    BuildContext context, {
    String? title,
    String? message,
    String? buttonText, // Tambahan
    VoidCallback? onButtonPressed, // Tambahan
  }) {
    return _showDialog(
      context,
      icon: Icons.check_circle_rounded,
      iconColor: AppColors.success,
      title: title ?? 'Berhasil',
      message: message ?? 'Aksi telah berhasil dilakukan',
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  /// Popup Gagal
  static Future<void> showError(
    BuildContext context, {
    String? title,
    String? message,
    String? buttonText, // Tambahan
    VoidCallback? onButtonPressed, // Tambahan
  }) {
    return _showDialog(
      context,
      icon: Icons.error_rounded,
      iconColor: AppColors.error,
      title: title ?? 'Gagal',
      message: message ?? 'Terjadi kesalahan',
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  /// Popup Info
  static Future<void> showInfo(
    BuildContext context, {
    String? title,
    String? message,
    String? buttonText, // Tambahan
    VoidCallback? onButtonPressed, // Tambahan
  }) {
    return _showDialog(
      context,
      icon: Icons.info_rounded,
      iconColor: AppColors.warning,
      title: title ?? 'Informasi',
      message: message ?? 'Info penting aplikasi',
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    String? buttonText, // Tambahan: Teks untuk tombol
    VoidCallback? onButtonPressed, // Tambahan: Fungsi saat tombol ditekan
  }) {
    // 1. Tentukan aksi yang akan dilakukan saat tombol ditekan.
    // Aksi default adalah menutup dialog.
    void finalOnPressed() {
      // Selalu tutup dialog terlebih dahulu
      context.popPage();
      // Kemudian, jalankan callback kustom jika ada
      if (onButtonPressed != null) {
        onButtonPressed();
      }
    }

    // 2. Tentukan teks pada tombol
    final String finalButtonText = buttonText ?? 'OK';

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: AppColors.background,
          // Mengatur clipBehavior agar border radius diterapkan dengan benar
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 20,
              left: 20,
              bottom: 15, // Ditingkatkan agar ada sedikit jarak dengan tombol
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Icon(icon, color: iconColor, size: 64),
                const SizedBox(height: 20),
                Text(
                  title,
                  textAlign:
                      TextAlign.center, // Tambahkan agar judul panjang terpusat
                  style: AppTextStyle.h3,
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body,
                ),
                const SizedBox(height: 15),
                // Tombol
                UIButton(
                  // Menggunakan properti child yang sudah dimodifikasi (Text dari label)
                  label: finalButtonText,
                  type: UIButtonType.filled,
                  size: UIButtonSize.medium,
                  onPressed: finalOnPressed, // Menggunakan finalOnPressed
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
