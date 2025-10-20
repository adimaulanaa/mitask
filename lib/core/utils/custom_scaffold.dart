import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';
import 'package:mitask/core/utils/page_route.dart';

class CustomScaffold extends StatelessWidget {
  final bool showAppBar;
  final Widget body;
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const CustomScaffold({
    super.key,
    required this.body,
    this.showAppBar = true,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.floatingActionButton,
    this.backgroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.bgColor,
      appBar: showAppBar
          ? AppBar(
              elevation: 0,
              scrolledUnderElevation: 0.0,
              surfaceTintColor:
                  Colors.transparent, // hilangkan background saat scroll
              backgroundColor: backgroundColor ?? AppColors.bgColor,
              centerTitle: true,
              leading: showBackButton
                  ? IconButton(
                      onPressed: onBackPressed ?? () => context.popPage(),
                      icon: SvgPicture.asset(
                        MediaRes.back, // path svg kamu
                        width: 23,
                        height: 23,
                        colorFilter: const ColorFilter.mode(
                          AppColors.bgBlack,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
              title: title != null
                  ? Text(
                      title!,
                      style: blackTextstyle.copyWith(fontWeight: bold),
                    )
                  : null,
              actions: actions,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
