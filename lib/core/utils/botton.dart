import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';

enum UIButtonType { filled, tonal, outlined, text }

enum UIButtonSize { verySmall, extraSmall, small, medium }

class UIButton extends StatelessWidget {
  final String? label;
  final UIButtonType type;
  final UIButtonSize size;
  final Color color;
  final Color? colorText;
  final bool enabled;
  final bool expanded;
  final double radius;
  final Widget? child;
  final VoidCallback? onPressed;

  const UIButton({
    super.key,
    this.label,
    this.type = UIButtonType.filled,
    this.size = UIButtonSize.medium,
    this.color = AppColors.primary,
    this.colorText,
    this.enabled = true,
    this.expanded = true,
    this.radius = 8.0,
    this.child,
    this.onPressed,
  });

  EdgeInsets get _padding {
    switch (size) {
      case UIButtonSize.verySmall:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
      case UIButtonSize.extraSmall:
        return const EdgeInsets.symmetric(vertical: 6, horizontal: 24);
      case UIButtonSize.small:
        return const EdgeInsets.symmetric(vertical: 9, horizontal: 24);
      case UIButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: 14, horizontal: 24);
    }
  }

  TextStyle getTextStyle(Color effectiveTextColor) {
    switch (size) {
      case UIButtonSize.verySmall:
      case UIButtonSize.extraSmall:
        return AppTextStyle.small.copyWith(color: effectiveTextColor);
      case UIButtonSize.small:
        return AppTextStyle.caption.copyWith(color: effectiveTextColor);
      case UIButtonSize.medium:
        return AppTextStyle.body.copyWith(color: effectiveTextColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = type == UIButtonType.filled
        ? AppColors.background
        : color;

    // radius fixed 8
    final BorderRadius borderRadius = BorderRadius.circular(radius);

    final ButtonStyle baseStyle = switch (type) {
      UIButtonType.filled => FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: effectiveTextColor,
        padding: _padding,
        textStyle: getTextStyle(effectiveTextColor),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      UIButtonType.tonal => FilledButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        padding: _padding,
        textStyle: getTextStyle(color),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      UIButtonType.outlined => OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        foregroundColor: color,
        padding: _padding,
        textStyle: getTextStyle(color),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      UIButtonType.text => TextButton.styleFrom(
        foregroundColor: color,
        padding: _padding,
        textStyle: getTextStyle(color),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
    };

    final Widget btnChild = switch (type) {
      UIButtonType.filled || UIButtonType.tonal => FilledButton(
        onPressed: enabled ? onPressed : null,
        style: baseStyle,
        child: label != null ? Text(label!) : child,
      ),
      UIButtonType.outlined => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: baseStyle,
        child: label != null ? Text(label!) : child,
      ),
      UIButtonType.text => TextButton(
        onPressed: enabled ? onPressed : null,
        style: baseStyle,
        child: label != null ? Text(label!) : child!,
      ),
    };

    // wrapper Expanded otomatis kalau expanded == true
    final Widget wrapped = expanded
        ? SizedBox(width: double.infinity, child: btnChild)
        : btnChild;

    // InkWell opsional (kalau mau efek ripple manual)
    return wrapped;
  }
}

class UICustomButton extends StatelessWidget {
  final String? label;
  final UIButtonType type;
  final UIButtonSize size;
  final Color color;
  final Color? colorText;
  final bool enabled;
  final bool expanded;
  final double radius;
  final Widget? child;
  final VoidCallback? onPressed;
  final Widget? icon;

  const UICustomButton({
    super.key,
    this.label,
    this.type = UIButtonType.filled,
    this.size = UIButtonSize.medium,
    this.color = AppColors.primary,
    this.colorText,
    this.enabled = true,
    this.expanded = true,
    this.radius = 8.0,
    this.child,
    this.onPressed,
    this.icon, // ⭐️ Tambahkan ke konstruktor
  });

  // [Kode _padding dan getTextStyle tetap sama]
  EdgeInsets get _padding {
    switch (size) {
      case UIButtonSize.verySmall:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
      case UIButtonSize.extraSmall:
        return const EdgeInsets.symmetric(vertical: 6, horizontal: 24);
      case UIButtonSize.small:
        return const EdgeInsets.symmetric(vertical: 9, horizontal: 24);
      case UIButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: 14, horizontal: 24);
    }
  }

  TextStyle getTextStyle(Color effectiveTextColor) {
    switch (size) {
      case UIButtonSize.verySmall:
      case UIButtonSize.extraSmall:
        return AppTextStyle.small.copyWith(color: effectiveTextColor);
      case UIButtonSize.small:
        return AppTextStyle.caption.copyWith(color: effectiveTextColor);
      case UIButtonSize.medium:
        return AppTextStyle.body.copyWith(color: effectiveTextColor);
    }
  }

  // ⭐️ FUNGSI HELPER BARU: Membuat widget anak untuk tombol
  Widget _buildButtonContent(Color effectiveTextColor) {
    final Widget textWidget = label != null
        ? Text(label!, style: getTextStyle(effectiveTextColor))
        : (child ?? const SizedBox.shrink()); // Gunakan child jika label null

    // Jika tidak ada ikon, kembalikan widget teks/child saja
    if (icon == null) {
      return textWidget;
    }

    // Jika ada ikon, kembalikan Row (Ikon + Jarak + Teks)
    return Row(
      mainAxisSize: MainAxisSize.min, // Penting agar Row tidak melebar
      children: [
        icon!, // Widget Ikon SVG Anda
        const SizedBox(width: 8), // Jarak antara ikon dan teks
        textWidget,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = type == UIButtonType.filled
        ? AppColors.background
        : color;

    final BorderRadius borderRadius = BorderRadius.circular(radius);

    final ButtonStyle baseStyle = switch (type) {
      UIButtonType.filled => FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: effectiveTextColor,
        padding: _padding,
        // Hapus textStyle di sini agar tidak konflik saat menggunakan Row
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      UIButtonType.tonal => FilledButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        padding: _padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      UIButtonType.outlined => OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        foregroundColor: color,
        padding: _padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      UIButtonType.text => TextButton.styleFrom(
        foregroundColor: color,
        padding: _padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
    };

    // ⭐️ MODIFIKASI PENTING: Gunakan _buildButtonContent() sebagai child tombol
    final Widget buttonContent = _buildButtonContent(effectiveTextColor);

    final Widget btnChild = switch (type) {
      UIButtonType.filled || UIButtonType.tonal => FilledButton(
        onPressed: enabled ? onPressed : null,
        style: baseStyle,
        child: buttonContent, // ⬅️ Gunakan konten yang sudah di-wrap
      ),
      UIButtonType.outlined => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: baseStyle,
        child: buttonContent, // ⬅️ Gunakan konten yang sudah di-wrap
      ),
      UIButtonType.text => TextButton(
        onPressed: enabled ? onPressed : null,
        style: baseStyle,
        child: buttonContent, // ⬅️ Gunakan konten yang sudah di-wrap
      ),
    };

    final Widget wrapped = expanded
        ? SizedBox(width: double.infinity, child: btnChild)
        : btnChild;

    return wrapped;
  }
}
