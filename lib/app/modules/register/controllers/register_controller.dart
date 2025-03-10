import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final PostUsecase postUsecase;
  RegisterController({
    required this.postUsecase,
  });

  final PageController pageController = PageController(
    initialPage: 0,
  );
  final currentStep = 0.obs;
  void nextStep() {
    if (currentStep < 2) {
      FocusScope.of(Get.context!).unfocus();
      currentStep.value++;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevStep() {
    FocusScope.of(Get.context!).unfocus();
    if (currentStep > 0) {
      currentStep.value--;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validatorEmail);
    errorEmail.listen((value) => validatorEmail());
    codeController.addListener(validatorKode);
    errorCode.listen((value) => validatorKode());
    firstNameController.addListener(validatorDataDiri);
    lastNameController.addListener(validatorDataDiri);
    password.addListener(validatorDataDiri);
  }

  //step 1
  final emailController = TextEditingController();
  final errorEmail = Rxn<String>();
  final isValidEmail = false.obs;

  void validatorEmail() {
    if (Validator.isValidEmail(emailController.text) &&
        errorEmail.value == null) {
      isValidEmail.value = true;
    } else {
      isValidEmail.value = false;
    }
  }

  Future<void> requestCode() async {
    ActionDialog.showLoading();
    try {
      final response = await postUsecase.call(
        url: 'api/blueray/customer/register/mini',
        body: {
          'user_id': emailController.text,
        },
        isUseToken: false,
        converter: (value) => SuccessModel.fromJson(value),
      );
      response.fold(
        (left) {
          ActionDialog.errorGeneralBottom(
            title: left.detail,
            subtitle: left.message ?? '',
          );
        },
        (right) {
          ActionDialog.hideLoadingDialog();
          if (right.action) {
            if (currentStep.value == 0) {
              nextStep();
            }
          } else {
            if (right.message.contains('limit')) {
              ActionDialog.errorGeneralBottom(
                subtitle: 'Tunggu selama 2 menit untuk request ulang',
              );
            } else {
              errorEmail.value = 'Email sudah terdaftar';
            }
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }

  //step 2
  final codeController = TextEditingController();
  final errorCode = Rxn<String>();
  final isValidcode = false.obs;

  void validatorKode() {
    if (codeController.text.isNotEmpty && errorEmail.value == null) {
      isValidcode.value = true;
    } else {
      isValidcode.value = false;
    }
  }

  Future<void> validasiCode() async {
    ActionDialog.showLoading();
    try {
      final response = await postUsecase.call(
        url: 'api/blueray/customer/register/verify-code',
        body: {
          'user_id': emailController.text,
          'code': codeController.text,
        },
        isUseToken: false,
        converter: (value) => SuccessModel.fromJson(value),
      );
      response.fold(
        (left) {
          ActionDialog.errorGeneralBottom(
            title: left.detail,
            subtitle: left.message ?? '',
          );
        },
        (right) {
          ActionDialog.hideLoadingDialog();
          if (right.action) {
            nextStep();
          } else {
            errorCode.value = 'Kode tidak valid';
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }

  //step 3
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final password = TextEditingController();
  final passwordValue = ''.obs;
  final isValidDataDiri = false.obs;
  void validatorDataDiri() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        Validator.isValidPassword(password.text)) {
      isValidDataDiri.value = true;
    } else {
      isValidDataDiri.value = false;
    }
  }

  Future<void> register() async {
    ActionDialog.showLoading();
    try {
      final response = await postUsecase.call(
        url: 'api/blueray/customer/register/mandatory',
        body: {
          'user_id': emailController.text,
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'password': password.text,
          'code': codeController.text,
        },
        isUseToken: false,
        converter: (value) => SuccessModel.fromJson(value),
      );
      response.fold(
        (left) {
          ActionDialog.errorGeneralBottom(
            title: left.detail,
            subtitle: left.message ?? '',
          );
        },
        (right) {
          ActionDialog.hideLoadingDialog();
          if (right.action) {
            ActionDialog.successPopUp(
              image: Images.get.icSuccess,
              title: 'Akun Anda Siap Digunakan',
              subtitle: 'Silakan masuk menggunakan akun yang sudah dibuat',
              additional: [],
            );
            Future.delayed(const Duration(seconds: 2), () async {
              Get.back();
              Get.offAllNamed(Routes.LOGIN);
            });
          } else {
            ActionDialog.errorGeneralBottom(subtitle: right.message);
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }
}
