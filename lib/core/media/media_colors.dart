import 'package:flutter/material.dart';

class AppColors {
  // 🌿 BRAND COLORS
  static const Color primary = Color(0xFF88C9A1); // Mint utama
  static const Color primaryDark = Color(0xFF6EAE89); // Mint sedikit gelap
  static const Color primaryLight = Color(0xFFA8DAB9); // Mint lebih terang

  // 🪴 BACKGROUND & SURFACE
  static const Color background = Color(
    0xFFF5FBF7,
  ); // Background utama (super soft)
  static const Color surface = Color(0xFFFFFFFF); // Card, container, sheet
  static const Color surfaceVariant = Color(
    0xFFE6F3EC,
  ); // Surface sekunder (accent)

  // ✨ BORDER & DIVIDER
  static const Color border = Color(0xFFD3E6DA); // Border soft
  static const Color divider = Color(0xFFBFDCC8); // Divider lebih kontras dikit

  // 📝 TEXT COLORS
  static const Color textPrimary = Color(0xFF1E1E1E); // Teks utama
  static const Color textSecondary = Color(0xFF4A4A4A); // Teks sekunder
  static const Color textTertiary = Color(0xFF7A7A7A); // Teks hint / label
  static const Color textOnPrimary = Color(
    0xFFFFFFFF,
  ); // Teks di atas tombol mint

  // 🟢 STATE COLORS (Status / Feedback)
  static const Color success = Color(0xFF6BBF8D); // Hijau sukses (lebih tegas)
  static const Color warning = Color(0xFFFFC94A); // Kuning soft
  static const Color error = Color(
    0xFFE57373,
  ); // Merah soft (tidak menyakitkan mata)
  static const Color info = Color(0xFF7CA9C2); // Biru lembut untuk info

  // 🌙 DISABLED / INACTIVE
  static const Color disabledBg = Color(0xFFE8F0EB);
  static const Color disabledText = Color(0xFF9FAFA5);

  // 🌫️ SHADOW & OVERLAY
  static const Color shadow = Color(0x1A000000); // 10% opacity black
  static const Color overlay = Color(0x33000000); // 20% opacity black
}

class AppDarkColors {
  static const Color background = Color(0xFF1E1F1E);
  static const Color surface = Color(0xFF2C2F2C);
  static const Color primary = Color(0xFF88C9A1);
  static const Color textPrimary = Color(0xFFF4FBF7);
  static const Color textSecondary = Color(0xFFBFDCC8);
}
