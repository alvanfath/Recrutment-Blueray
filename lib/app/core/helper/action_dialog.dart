import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class ActionDialog {
  static void showLoading() {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
    }
  }

  static void hideLoadingDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void errorGeneralBottom({
    String? title,
    required String subtitle,
    VoidCallback? onClose,
    String image = 'assets/images/warning.svg',
    String textButton = 'OK',
  }) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.bottomSheet(
      ModaLBottomWidget(
        icon: image,
        title: title ?? 'Sepertinya terjadi kesalahan',
        subtitle: subtitle,
        additionalContent: [
          Button(
            title: textButton,
            paddingY: 12.5,
            fontSize: 12,
            onPressed: () {
              if (Get.isBottomSheetOpen == true) {
                Get.back();
              }
            },
          )
        ],
      ),
    ).then((value) {
      onClose?.call();
    });
  }

  static void successPopUp({
    required String image,
    required String title,
    required String subtitle,
    required List<Widget> additional,
    VoidCallback? onClose,
  }) {
    //jika ada dialog
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    //bottom sheet
    Get.dialog(
      ModalPopUpNoClose(
        icon: image,
        title: title,
        message: subtitle,
        actions: additional,
      ),
      barrierDismissible: false,
    ).then((value) {
      onClose?.call();
    });
  }
}
