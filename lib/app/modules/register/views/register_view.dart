import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:recrutment_blueray/app/modules/register/views/check_email_view.dart';
import 'package:recrutment_blueray/app/modules/register/views/data_diri_view.dart';
import 'package:recrutment_blueray/app/modules/register/views/validasi_code_view.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: PageView(
        controller: controller.pageController,
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CheckEmailView(),
          ValidasiCodeView(),
          DataDiriView(),
        ],
      ),
      onWillPop: () async {
        controller.prevStep();
        return false;
      },
    );
  }
}
