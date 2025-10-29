import 'package:flutter/material.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_text.dart';

class SelectOption {
  final String id;
  final String name;
  final String label;
  final int days;

  SelectOption({required this.id, required this.name, required this.label, required this.days});
}

class CustomSelectField extends StatefulWidget {
  final String label;
  final bool isLabel;
  final String hintText;
  final List<SelectOption> items;
  final SelectOption? selected;
  final ValueChanged<SelectOption> onChanged;
  final String? errorText;
  final Color color;

  const CustomSelectField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.selected,
    this.errorText,
    this.isLabel = true,
    this.color = AppColors.primary,
  });

  @override
  State<CustomSelectField> createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  late SelectOption? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        _selected == null ? AppColors.border : widget.color.withValues(alpha: 0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isLabel)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: AppTextStyle.body.copyWith(fontWeight: medium),
            ),
          ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: borderColor, width: 1.2),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SelectOption>(
              isExpanded: true,
              value: _selected,
              alignment: AlignmentGeometry.center,
              borderRadius: BorderRadius.circular(12),
              dropdownColor: AppColors.background,
              hint: Text(
                widget.hintText,
                style: AppTextStyle.body.copyWith(
                  fontWeight: medium,
                  color: AppColors.disabledText,
                ),
              ),
              items: widget.items.map((option) {
                return DropdownMenuItem<SelectOption>(
                  value: option,
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    option.name,
                    style: AppTextStyle.body.copyWith(fontWeight: medium),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selected = value);
                  widget.onChanged(value);
                }
              },
              icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              widget.errorText!,
              style: AppTextStyle.caption.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }
}


// CustomSelectField<SelectOption>(
//   label: "Pilih Prioritas",
//   hintText: "Pilih salah satu",
//   items: [
//     SelectOption(id: 1, name: "Rendah"),
//     SelectOption(id: 2, name: "Sedang"),
//     SelectOption(id: 3, name: "Tinggi"),
//   ],
//   itemLabel: (p) => p.name,
//   value: selectedPriority,
//   onChanged: (val) {
//     setState(() => selectedPriority = val);
//   },
// ),

// class CustomSelectField<T> extends StatefulWidget {
//   final String label;
//   final String hintText;
//   final List<T> items;
//   final String Function(T) itemLabel;
//   final ValueChanged<T?> onChanged;
//   final T? value;
//   final String? errorText;

//   const CustomSelectField({
//     super.key,
//     required this.label,
//     required this.hintText,
//     required this.items,
//     required this.itemLabel,
//     required this.onChanged,
//     this.value,
//     this.errorText,
//   });

//   @override
//   State<CustomSelectField<T>> createState() => _CustomSelectFieldState<T>();
// }

// class _CustomSelectFieldState<T> extends State<CustomSelectField<T>> {
//   void _showSelectDialog(BuildContext context) async {
//     final selected = await showDialog<T>(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: AppColors.background,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Container(
//             constraints: const BoxConstraints(maxHeight: 350),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: ListView.separated(
//               shrinkWrap: true,
//               itemCount: widget.items.length,
//               separatorBuilder: (_, __) => const Divider(height: 1),
//               itemBuilder: (context, index) {
//                 final item = widget.items[index];
//                 return InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: () => Navigator.pop(context, item),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     child: Center(
//                       child: Text(
//                         widget.itemLabel(item),
//                         textAlign: TextAlign.center,
//                         style: AppTextStyle.body.copyWith(
//                           color: AppColors.textPrimary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );

//     if (selected != null) {
//       widget.onChanged(selected);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isError = widget.errorText != null && widget.errorText!.isNotEmpty;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: AppTextStyle.body.copyWith(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 8),
//         InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: () => _showSelectDialog(context),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: isError ? Colors.red : AppColors.border,
//                 width: 1.2,
//               ),
//               color: AppColors.background,
//             ),
//             child: Text(
//               widget.value != null
//                   ? widget.itemLabel(widget.value as T)
//                   : widget.hintText,
//               style: AppTextStyle.body.copyWith(
//                 color: widget.value != null
//                     ? AppColors.textPrimary
//                     : AppColors.disabledText,
//               ),
//             ),
//           ),
//         ),
//         if (isError) ...[
//           const SizedBox(height: 6),
//           Text(
//             widget.errorText!,
//             style: AppTextStyle.small.copyWith(color: Colors.red),
//           ),
//         ],
//       ],
//     );
//   }
// }
