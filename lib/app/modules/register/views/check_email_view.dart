import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/register/controllers/register_controller.dart';

class CheckEmailView extends GetView<RegisterController> {
  const CheckEmailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        isLeading: true,
        leadingAction: controller.prevStep,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(() {
          final isValid = controller.isValidEmail.value;
          final error = controller.errorEmail.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              TitleWidget(
                title: 'Verifikasi Email',
                subtitle: 'Masukkan email yang valid untuk verifikasi',
              ),
              const SizedBox(height: 32),
              TextF(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                hint: 'Email',
                hintText: 'Contoh: Jhon@gmail.com',
                onChanged: (value) => controller.errorEmail.value = null,
                validator: (String? value) {
                  return error;
                },
              ),
              const SizedBox(height: 24),
              Button(
                title: 'Lanjut',
                color: isValid
                    ? Constants.get.primaryColor
                    : Constants.get.secondaryColor,
                onPressed: () {
                  if (isValid) {
                    controller.requestCode();
                  }
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
