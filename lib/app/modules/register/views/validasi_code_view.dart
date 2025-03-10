import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/register/controllers/register_controller.dart';

class ValidasiCodeView extends GetView<RegisterController> {
  const ValidasiCodeView({super.key});
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
          final isValid = controller.isValidcode.value;
          final error = controller.errorCode.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              TitleWidget(
                title: 'Validasi kode',
                subtitle:
                    'Silakan check gmail ${controller.emailController.text} untuk validasi kode',
              ),
              const SizedBox(height: 32),
              TextF(
                controller: controller.codeController,
                inputFormatter: [
                  UpperCaseAlphaNumericFormatter(),
                ],
                hint: 'Kode',
                hintText: 'Masukan kode',
                onChanged: (value) => controller.errorCode.value = null,
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
                    controller.validasiCode();
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
