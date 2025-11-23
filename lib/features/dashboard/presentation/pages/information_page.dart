import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/dashboard/presentation/widgets/information_widget.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  bool isAbout = false;
  bool isFeature = false;
  bool isSocialContact = false;
  bool isPrivasi = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      showBackButton: false,
      showAppBar: false,
      backgroundColor: AppColors.disabledBg,
      // title: 'Informasi Aplikasi',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _headerContent(size, context),
                  SizedBox(height: 10),
                  _aboutApps(size),
                  SizedBox(height: 10),
                  _aboutFeatures(size),
                  SizedBox(height: 10),
                  _socialContact(size),
                  SizedBox(height: 10),
                  _privasiUsed(size),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // FOOTER (FIX DI BAWAH)
          Padding(
            padding: const EdgeInsets.only(bottom: 25, top: 10),
            child: Text(
              "Developed by · Adi Maulana · Bantraka",
              style: AppTextStyle.caption.copyWith(
                fontWeight: regular,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialContact(Size size) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER (Title + Icon Arrow)
          CustomInkWell(
            onTap: () => setState(() => isSocialContact = !isSocialContact),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sosial & Kontak",
                  style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                ),
                SvgPicture.asset(
                  isSocialContact ? MediaRes.up : MediaRes.down,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          // CONTENT (Expanded Area)
          if (isSocialContact)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialContact(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: "adimaulana0777@email.com",
                  ),
                  SocialContact(
                    icon: Icons.code_outlined,
                    title: "GitHub",
                    value: "github.com/adimaulanaa",
                  ),
                  SocialContact(
                    icon: Icons.link_outlined,
                    title: "LinkedIn",
                    value: "linkedin.com/in/adi-maulana",
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _aboutFeatures(Size size) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER (Title + Icon Arrow)
          CustomInkWell(
            onTap: () => setState(() => isFeature = !isFeature),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fitur Aplikasi",
                  style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                ),
                SvgPicture.asset(
                  isFeature ? MediaRes.up : MediaRes.down,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          // CONTENT (Expanded Area)
          if (isFeature)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bullets(value: "Mengelola tugas harian dengan mudah"),
                  Bullets(value: "Sematkan tugas penting (Pinned Task)"),
                  Bullets(value: "Tandai sebagai favorit"),
                  Bullets(value: "Status & checklist tugas"),
                  Bullets(value: "Pengingat tugas (Reminder)"),
                  Bullets(value: "Arsip tugas"),
                  Bullets(value: "Semua data tersimpan secara offline"),
                  Bullets(value: "Soft delete — tugas tidak langsung hilang"),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _aboutApps(Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(color: AppColors.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInkWell(
            onTap: () => setState(() => isAbout = !isAbout),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tentang Aplikasi",
                  style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                ),
                SvgPicture.asset(
                  isAbout ? MediaRes.up : MediaRes.down,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          // CONTENT (Expanded Area)
          if (isAbout)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    "MiTask adalah aplikasi manajemen tugas yang dirancang untuk membantu pengguna mengatur aktivitas dan meningkatkan produktivitas.",
                    textAlign: TextAlign.justify,
                    style: AppTextStyle.caption.copyWith(
                      fontWeight: regular,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _privasiUsed(Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(color: AppColors.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInkWell(
            onTap: () => setState(() => isPrivasi = !isPrivasi),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Privasi Pengguna",
                  style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                ),
                SvgPicture.asset(
                  isPrivasi ? MediaRes.up : MediaRes.down,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          // CONTENT (Expanded Area)
          if (isPrivasi)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    "Aplikasi ini hanya menyimpan data secara lokal dan tidak mengirimkan data apa pun ke server luar.",
                    textAlign: TextAlign.justify,
                    style: AppTextStyle.caption.copyWith(
                      fontWeight: regular,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _headerContent(Size size, BuildContext context) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          // BACK BUTTON (kiri atas)
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            child: IconButton(
              onPressed: () => context.popPage(),
              icon: SvgPicture.asset(
                MediaRes.back,
                width: 23,
                height: 23,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // HEADER CONTENT (tengah di atas)
          Padding(
            padding: EdgeInsets.only(
              top:
                  MediaQuery.of(context).padding.top +
                  50, // kasih jarak dari atas
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset(MediaRes.logo, height: size.height * 0.1),
                  const SizedBox(height: 5),
                  Text(
                    "MiTask",
                    style: AppTextStyle.h3.copyWith(
                      fontWeight: semiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "v1.0.0",
                    style: AppTextStyle.body.copyWith(
                      fontWeight: medium,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Manajemen Tugas Harian",
                    style: AppTextStyle.body.copyWith(
                      fontWeight: medium,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
