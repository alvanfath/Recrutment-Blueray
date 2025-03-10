import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        isLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(() {
          final bool isActive = controller.buttonStatus.value;
          final bool isHide = controller.hidePassword.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              TitleWidget(
                title: 'Masuk',
                subtitle: 'Masuk menggunakan akun anda',
              ),
              const SizedBox(height: 32),
              TextF(
                keyboardType: TextInputType.emailAddress,
                hint: 'Email',
                hintText: 'Contoh: jhon@gmail.com',
                controller: controller.emailController,
                onChanged: (value) {
                  print('value: $value');
                  controller.errorText.value = null;
                },
                validator: (String? value) {
                  return controller.errorText.value;
                },
              ),
              const SizedBox(height: 16),
              TextF(
                hint: 'Password',
                obscureText: isHide,
                hintText: 'Masukkan password anda',
                controller: controller.pwController,
                onChanged: (value) {
                  controller.errorText.value = null;
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      controller.hidePassword.value = !isHide;
                    },
                    behavior: HitTestBehavior.opaque,
                    child: HeroIcon(
                      isHide ? HeroIcons.eyeSlash : HeroIcons.eye,
                      color: const Color(0xff71808E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Belum punya akun?',
                    color: Constants.get.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  ButtonText(
                    text: 'Daftar',
                    paddingY: 0,
                    onTap: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                  )
                ],
              ),
              const SizedBox(height: 24),
              Button(
                title: 'Masuk',
                color: isActive
                    ? Constants.get.primaryColor
                    : Constants.get.secondaryColor,
                onPressed: () {
                  controller.login();
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
