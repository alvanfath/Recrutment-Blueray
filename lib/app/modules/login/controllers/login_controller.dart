import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

class LoginController extends GetxController with StorageProvider {
  final PostUsecase postUsecase;
  LoginController({required this.postUsecase});

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final errorText = Rxn<String>();
  final hidePassword = true.obs;
  final buttonStatus = false.obs;
  void validateButton() {
    if (emailController.text.isNotEmpty &&
        pwController.text.isNotEmpty &&
        errorText.value == null) {
      buttonStatus.value = true;
    } else {
      buttonStatus.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validateButton);
    pwController.addListener(validateButton);
    errorText.listen((value) => validateButton());
  }

  Future<void> login() async {
    ActionDialog.showLoading();
    try {
      final response = await postUsecase.call(
        url: 'api/blueray/customer/login',
        body: {
          'user_id': emailController.text,
          'password': pwController.text,
        },
        isUseToken: false,
        converter: (value) => LoginModel.fromJson(value),
      );
      response.fold(
        (left) {
          ActionDialog.errorGeneralBottom(
            title: left.detail,
            subtitle: left.message ?? '',
          );
        },
        (right) async {
          ActionDialog.hideLoadingDialog();
          if (right.login) {
            await addData(KeyStorage.token, right.token);
            await addData(KeyStorage.user, right.customer);
            Get.offAllNamed(Routes.HOME);
          } else {
            errorText.value = 'Email atau password salah';
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }
}
