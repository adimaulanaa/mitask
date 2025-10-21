import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/utils/custom_inkwell.dart';
import 'package:mitask/core/utils/custom_text_field.dart';
import 'package:mitask/features/task/custom_floating.dart';
import 'package:mitask/features/task/list_task.dart';
import 'package:mitask/features/task/widget_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController searchCtr = TextEditingController();
  final TextEditingController startDateCtr = TextEditingController();
  final TextEditingController endDateCtr = TextEditingController();
  bool isFilter = false;
  bool isPin = false;
  bool isFav = false;
  bool isArch = false;

  @override
  Widget build(BuildContext context) {
  // Catatan: SizedBox(height: size.height * 0.08) tidak diperlukan lagi

  return Scaffold(
    backgroundColor: AppColors.background,
    appBar: null,
    body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                SearchTextField(hintText: 'Cari Task..', controller: searchCtr),
                const SizedBox(height: 10),
                isFilter ? _advFilter() : _iconsFilter(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded( 
            child: ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 70, 
              ),
              itemCount: 10, 
              itemBuilder: (context, index) {
                return const ListTask(); 
              },
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: CustomExpandedFAB(
      onPressed: () {
        debugPrint('Tombol Add Task Kustom Ditekan');
      },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
}

  Widget _iconsFilter() {
    return Row(
      children: [
        const Spacer(),
        CustomInkWell(
          onTap: () {
            setState(() {
              isFilter = !isFilter;
            });
          },
          child: SvgPicture.asset(
            MediaRes.filter,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _advFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDateInput(
                controller: startDateCtr,
                hintText: 'Awal',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomDateInput(controller: endDateCtr, hintText: 'Akhir'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            BoxTypeFilter(
              icons: MediaRes.pinned,
              active: isPin,
              onTap: () => selectTpye(0),
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.favorite,
              active: isFav,
              onTap: () => selectTpye(1),
            ),
            SizedBox(width: 10),
            BoxTypeFilter(
              icons: MediaRes.archived,
              active: isArch,
              onTap: () => selectTpye(2),
            ),
          ],
        ),
        SizedBox(height: 5),
        CustomInkWell(
          onTap: () {
            setState(() {
              isPin = false;
              isFav = false;
              isArch = false;
              startDateCtr.clear();
              endDateCtr.clear();
              isFilter = !isFilter;
            });
          },
          child: SvgPicture.asset(
            MediaRes.filterRemove,
            width: 23,
            height: 23,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  void selectTpye(int idx) {
    if (idx == 0) {
      isPin = !isPin;
    } else if (idx == 1) {
      isFav = !isFav;
    } else if (idx == 2) {
      isArch = !isArch;
    }
    setState(() {});
  }
}
