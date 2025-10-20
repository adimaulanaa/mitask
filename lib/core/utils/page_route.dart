import 'package:flutter/material.dart';

/// --- CONTOH PENGGUNAAN ---
///
//! // Dorong halaman baru:
/// context.pushPage(const SecondPage(), type: TransitionType.slide);
///
/// // Ganti halaman sekarang:
/// context.replacePage(const LoginPage(), type: TransitionType.fade);
///
//! // Dorong halaman baru & hapus semua sebelumnya:
/// context.pushAndRemoveUntilPage(const HomePage());
///
//! // Pop halaman:
/// context.popPage();
///
//! // Pop sampai route dengan nama tertentu:
/// context.popUntilPage(ModalRoute.withName('/home'));
///
//! // Cek apakah bisa pop:
/// if (context.canPopPage()) {
///   context.popPage();
/// }

/// Jenis transisi animasi
enum TransitionType {
  none,
  fade,
  scale,
  centerScale,
  slide,
  slideRightToLeft,
  slideLeftToRight,
  slideTopToBottom,
  slideBottomToTop,
  rotation,
  size,
  fadeSlide,
}

/// Fungsi utilitas untuk membuat PageRoute dengan animasi
Route<T> animatedRoute<T>(
  Widget page, {
  TransitionType type = TransitionType.slide,
  Duration duration = const Duration(milliseconds: 300),
}) {
  if (type == TransitionType.none) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.scale:
          return ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        case TransitionType.centerScale:
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: FadeTransition(
              opacity: animation, // opsional
              child: child,
            ),
          );
        case TransitionType.slide:
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );
        case TransitionType.slideRightToLeft:
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );

        case TransitionType.slideLeftToRight:
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );

        case TransitionType.slideTopToBottom:
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );

        case TransitionType.slideBottomToTop:
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );

        case TransitionType.rotation:
          return RotationTransition(
            turns: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );

        case TransitionType.size:
          return Align(
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            ),
          );
        default:
          return child;
      }
    },
    transitionDuration: duration,
  );
}

/// Extension Navigator supaya pemanggilan lebih simpel
extension NavigatorExtension on BuildContext {
  /// Dorong page baru
  Future<T?> pushPage<T>(
    Widget page, {
    TransitionType type = TransitionType.slide,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(
      this,
    ).push<T>(animatedRoute(page, type: type, duration: duration));
  }

  /// Ganti page sekarang
  Future<T?> replacePage<T>(
    Widget page, {
    TransitionType type = TransitionType.slide,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(this).pushReplacement<T, T>(
      animatedRoute(page, type: type, duration: duration),
    );
  }

  /// Dorong page baru dan hapus semua page sebelumnya
  Future<T?> pushAndRemoveUntilPage<T>(
    Widget page, {
    TransitionType type = TransitionType.slide,
    Duration duration = const Duration(milliseconds: 300),
    RoutePredicate? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      animatedRoute(page, type: type, duration: duration),
      predicate ?? (Route<dynamic> route) => false,
    );
  }

  /// Kembali ke page sebelumnya
  void popPage<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Kembali sampai ketemu route tertentu
  void popUntilPage(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Cek apakah bisa pop
  bool canPopPage() {
    return Navigator.of(this).canPop();
  }

  /// Pop kalau bisa
  Future<bool> maybePopPage<T extends Object?>([T? result]) {
    return Navigator.of(this).maybePop<T>(result);
  }
}
