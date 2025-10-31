import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isLabel;
  final bool isRequired;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color color;
  final Color colorLabel;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.isLabel = true,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.color = AppColors.primary,
    this.colorLabel = AppColors.textPrimary,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colors = widget.color.withValues(alpha: 0.7);
    final Color enabledColor = widget.controller.text.isEmpty
        ? AppColors.border
        : colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isLabel)
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: AppTextStyle.body.copyWith(
                    fontWeight: medium,
                    color: widget.colorLabel,
                  ),
                ),
                if (widget.isRequired) // ➕ tampilkan bintang kalau wajib
                  const Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          style: AppTextStyle.body.copyWith(fontWeight: medium),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: AppTextStyle.body.copyWith(
              fontWeight: regular,
              color: AppColors.disabledText,
            ),
            errorText: widget.errorText,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: enabledColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: widget.color, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color color;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const SearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.color = AppColors.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colors = widget.color.withValues(alpha: 0.7);
    final Color enabledColor = widget.controller.text.isEmpty
        ? AppColors.border
        : colors;

    final Widget svgSearchIcon = Padding(
      padding: const EdgeInsets.only(right: 12.0), // Beri padding di sisi kanan
      child: SvgPicture.asset(
        MediaRes.search,
        colorFilter: ColorFilter.mode(enabledColor, BlendMode.srcIn),
      ),
    );

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      style: AppTextStyle.body.copyWith(fontWeight: medium),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null ? svgSearchIcon : null,
        suffixIcon: svgSearchIcon,
        hintText: widget.hintText,
        hintStyle: AppTextStyle.textTertiary.copyWith(
          fontWeight: regular,
          fontSize: 16,
        ),
        errorText: widget.errorText,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.color, width: 2),
        ),
      ),
    );
  }
}

class CustomDateInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color color;
  final String? errorText;
  final Function onTap;

  const CustomDateInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.color = AppColors.primary, // Ganti dengan default warna aksen Anda
    required this.onTap,
  });

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  // Fungsi untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: widget.color),
          ),
          child: child!,
        );
      },
    );

    // Jika tanggal dipilih, format dan perbarui controller
    if (pickedDate != null) {
      final String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
      widget.controller.text = formattedDate;
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan logika isNotEmpty untuk menentukan warna border (seperti pada SearchTextField Anda)
    final Color enabledColor = widget.controller.text.isEmpty
        ? AppColors.border
        : AppColors.primary.withValues(alpha: 0.7);

    return TextFormField(
      controller: widget.controller,
      readOnly: true, // 🛑 PENTING: Mencegah keyboard muncul
      // Memicu date picker saat input diklik
      onTap: () => _selectDate(context),

      style: AppTextStyle.body.copyWith(fontWeight: medium),

      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        hintStyle: AppTextStyle.textTertiary.copyWith(
          fontWeight: regular,
          fontSize: 16,
        ),

        // Ikon Kalender sebagai Suffix
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              MediaRes.calendar,
              colorFilter: ColorFilter.mode(enabledColor, BlendMode.srcIn),
            ),
          ),
        ),

        filled: true,
        fillColor: AppColors
            .background, // Ganti dengan warna latar belakang input Anda

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        // Gaya Border saat non-aktif
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledColor),
        ),
        // Gaya Border saat fokus
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.color, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}

class CustomNoteField extends StatefulWidget {
  final String label;
  final bool isLabel;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomNoteField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.isLabel = true,
    this.focusNode,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomNoteField> createState() => _CustomNoteFieldState();
}

class _CustomNoteFieldState extends State<CustomNoteField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = widget.controller.text.isEmpty
        ? AppColors.border
        : AppColors.primary.withValues(alpha: 0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isLabel
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.label,
                  style: AppTextStyle.body.copyWith(fontWeight: medium),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          onChanged: widget.onChanged,
          maxLines: null, // otomatis menyesuaikan isi
          minLines: 4, // tinggi minimal
          keyboardType: TextInputType.multiline,
          style: AppTextStyle.body.copyWith(fontWeight: medium),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyle.body.copyWith(
              fontWeight: regular,
              color: AppColors.disabledText,
            ),
            errorText: widget.errorText,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
