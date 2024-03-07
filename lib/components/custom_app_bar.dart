import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/components/widgets.dart';
import 'package:task_manager/utils/color_constants.dart';
import 'package:task_manager/utils/image_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Color? backgroundColor;
  final List<Widget>? actionWidgets;
  final GestureTapCallback? onBackTap;

  const CustomAppBar({super.key,
    required this.title,
    this.onBackTap,
    this.showBackButton = true,
    this.backgroundColor = ColorConstants.whiteColor,
    this.actionWidgets
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: showBackButton ? IconButton(
        icon: SvgPicture.asset(ImageConstants.backArrowIcon),
        onPressed: () {
          if (onBackTap != null) {
            onBackTap!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ) : null,
      actions: actionWidgets,
      title: Row(
        children: [
          buildText(title, ColorConstants.blackColor, 18, FontWeight.w500,
              TextAlign.start, TextOverflow.clip),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}