# ============================================================================
# 📱 Flutter Build Commands (Android & iOS) using FVM
# ============================================================================

# 💡 Cara pakai:
# Buka terminal dan arahkan ke folder project, lalu jalankan salah satu:
#
# ANDROID - Build APK:
# make debug
# make release
# make aab

# ============================================================================
# ✅ Daftar target Makefile (agar dikenali sebagai perintah Make)
# ============================================================================
.PHONY: \
  debug \
  release \
  aab \
  update_icons

# ============================================================================
# 📦 ANDROID BUILD APK
# ============================================================================

# 🔹 Debug APK - Staging
debug:
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build apk --debug

# 🔸 Release APK - Staging
release:
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build apk --release

# 🔸 Update Icons APK
update_icons:
	@fvm flutter pub get
	@fvm flutter pub run flutter_launcher_icons:main

# 🔸 Release APK .AAB
aab:
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build appbundle --release