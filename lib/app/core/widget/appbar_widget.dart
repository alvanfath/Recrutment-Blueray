import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final bool isLeading;
  final String? title;
  final Function()? leadingAction;
  final List<Widget>? actions;
  final Color? background;
  final PreferredSize? bottom;
  final double? elevation;
  final double? height;
  final bool centerTitle;
  final double padding;

  const AppBarWidget({
    super.key,
    required this.context,
    required this.isLeading,
    this.title,
    this.leadingAction,
    this.actions,
    this.background,
    this.bottom,
    this.elevation,
    this.height,
    this.centerTitle = true,
    this.padding = 24,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      backgroundColor: background ?? Colors.white,
      surfaceTintColor: Colors.white,
      elevation: elevation ?? 0,
      scrolledUnderElevation: 0.0,
      shadowColor: const Color.fromARGB(50, 0, 0, 0),
      title: TextWidget(
        text: title ?? '',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        align: TextAlign.center,
      ),
      leadingWidth: MediaQuery.of(context).size.width / 4,
      leading: isLeading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: leadingAction ??
                      () {
                        Get.back();
                      },
                  child: Container(
                    margin: EdgeInsets.only(left: padding),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffDFE4EA),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xff333333),
                      size: 16,
                    ),
                  ),
                ),
              ],
            )
          : null,
      actions: actions,
      bottom: bottom ??
          const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox.shrink(),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
