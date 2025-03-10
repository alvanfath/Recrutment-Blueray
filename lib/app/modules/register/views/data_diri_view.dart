import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/register/controllers/register_controller.dart';

class DataDiriView extends GetView<RegisterController> {
  const DataDiriView({super.key});
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
          final isValid = controller.isValidDataDiri.value;
          final password = controller.passwordValue.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              TitleWidget(
                title: 'Data diri',
                subtitle: 'Silakan isi data diri anda',
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: TextF(
                      controller: controller.firstNameController,
                      hint: 'Nama awal',
                      hintText: 'Contoh: Jhon',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextF(
                      hint: 'Nama akhir',
                      hintText: 'Contoh: Doe',
                      controller: controller.lastNameController,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextF(
                hint: 'Password',
                hintText: 'Masukan Password',
                onChanged: (value) {
                  controller.passwordValue.value = value;
                },
                controller: controller.password,
              ),
              const SizedBox(height: 8),
              PasswordValidate(password: password),
              const SizedBox(height: 24),
              Button(
                title: 'Lanjut',
                color: isValid
                    ? Constants.get.primaryColor
                    : Constants.get.secondaryColor,
                onPressed: () {
                  if (isValid) {
                    controller.register();
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
