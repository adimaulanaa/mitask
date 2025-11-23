import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/core/utils/botton.dart';
import 'package:mitask/core/utils/custom_scaffold.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/core/utils/page_route.dart';
import 'package:mitask/features/dashboard/presentation/pages/information_page.dart';
import 'package:mitask/services_locator.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final storage = sl<StorageProvider>();
  final TextEditingController namaCtr = TextEditingController();
  String? errorNama;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    setInitData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              context.pushPage(
                const InformationPage(),
                type: TransitionType.slide,
              );
            },
            icon: SvgPicture.asset(
              MediaRes.info, // path svg kamu
              width: 25,
              height: 25,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListView(
            children: [
              CustomTextField(
                label: 'Nama',
                isRequired: true,
                hintText: 'Masukkan nama kamu',
                controller: namaCtr,
                errorText: errorNama,
                onChanged: (value) {
                  if (value == '') {
                    isSubmitted = false;
                  } else {
                    isSubmitted = true;
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: UIButton(
          type: isSubmitted ? UIButtonType.filled : UIButtonType.outlined,
          size: UIButtonSize.medium,
          child: Text(
            'Saved',
            style: AppTextStyle.body.copyWith(
              color: isSubmitted ? AppColors.background : AppColors.primary,
              fontWeight: semiBold,
            ),
          ),
          onPressed: () {
            if (validateForm()) {
              // HANYA BERJALAN JIKA TRUE
              onSaved();
            }
          },
        ),
      ),
    );
  }

  void setInitData() {
    namaCtr.text = storage.displayName ?? '-';
    setState(() {});
  }

  bool validateForm() {
    errorNama = null;
    final name = namaCtr.text.trim();
    if (name == '') {
      errorNama = 'Nama tidak boleh kosong';
    }
    setState(() {});
    // --- Bagian yang salah ada di sini ---
    if (errorNama != null) {
      return false; // JIKA TIDAK ADA ERROR, ANDA MENGEMBALIKAN FALSE
    }
    // -------------------------------------
    return true; // JIKA ADA ERROR, ANDA MENGEMBALIKAN TRUE
  }

  void onSaved() {
    storage.displayName = namaCtr.text.trim();
    FocusScope.of(context).unfocus();
  }
}
