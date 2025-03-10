import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class CreateAddressController extends GetxController {
  final GetUsecase getUsecase;
  final PostUsecase postUseCase;
  final PostFormdataUsecase postFormData;
  CreateAddressController({
    required this.getUsecase,
    required this.postUseCase,
    required this.postFormData,
  });

  //required
  final nameController = TextEditingController();
  final addressLabelController = TextEditingController();
  final phoneController = TextEditingController();
  final kodePosController = TextEditingController();
  final district = Rxn<Map<String, dynamic>>();
  final locationMap = Rxn<LocationModel>();
  final addressController = TextEditingController();

  //nullable
  final emailController = TextEditingController();
  final npwpController = TextEditingController();
  final npwpFile = Rxn<String>();

  //error
  final errorKodePos = Rxn<String>();

  //button
  final validButton = false.obs;
  void validator() {
    if (nameController.text.isNotEmpty &&
        addressLabelController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        kodePosController.text.isNotEmpty &&
        district.value != null &&
        locationMap.value != null &&
        addressController.text.isNotEmpty &&
        errorKodePos.value == null) {
      validButton.value = true;
    } else {
      validButton.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(validator);
    addressLabelController.addListener(validator);
    phoneController.addListener(validator);
    kodePosController.addListener(validator);
    district.listen((_) => validator());
    locationMap.listen((_) => validator());
    addressController.addListener(validator);

    //nullable
    emailController.addListener(validator);
    npwpController.addListener(validator);
    npwpFile.listen((_) => validator());

    //error
    errorKodePos.listen((_) => validator());
  }

  Future<List<dynamic>> searchKecamatan(String keyword) async {
    try {
      final response = await getUsecase.call(
        url: 'api/blueray/address/subdistricts/search',
        queryParam: {
          'q': keyword,
        },
        converter: (value) => SuccessModel.fromJson(value),
      );
      return response.fold(
        (left) {
          ActionDialog.errorGeneralBottom(
            title: left.detail,
            subtitle: left.message ?? '',
          );
          return [];
        },
        (right) {
          return right.data;
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
      return [];
    }
  }

  Future<void> uploadNpwp(String path) async {
    ActionDialog.showLoading();
    try {
      final response = await postFormData.call(
        url: 'api/blueray/image/upload',
        body: {
          'image_file': path,
        },
        converter: (response) => SuccessModel.fromJson(response),
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
            npwpFile.value = right.imageUrl;
          } else {
            ActionDialog.errorGeneralBottom(
              subtitle: right.message,
            );
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }

  Timer? debounce;
  Future<void> checkKodePos(String value) async {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (value.isEmpty) {
          errorKodePos.value = null;
        } else {
          try {
            final response = await getUsecase.call(
              url: 'api/blueray/address/postalcode/validation',
              queryParam: {
                'postal_code': value,
              },
              converter: (json) => SuccessModel.fromJson(json),
            );
            response.fold(
              (left) {
                ActionDialog.errorGeneralBottom(
                  title: left.detail,
                  subtitle: left.message ?? '',
                );
              },
              (right) {
                if (right.valid == true) {
                  errorKodePos.value = null;
                } else {
                  errorKodePos.value = right.message;
                }
              },
            );
          } catch (e) {
            ActionDialog.errorGeneralBottom(subtitle: e.toString());
          }
        }
      },
    );
  }

  Future<void> postAlamat() async {
    ActionDialog.showLoading();
    final payload = {
      "address": addressController.text,
      "address_label": addressLabelController.text,
      "name": nameController.text,
      "phone_number": phoneController.text,
      "province_id": district.value?['province_id'],
      "district_id": district.value?['district_id'],
      "sub_district_id": district.value?['sub_district_id'],
      "postal_code": kodePosController.text,
      "lat": locationMap.value?.lat,
      "long": locationMap.value?.long,
      "address_map": locationMap.value?.alamatLengkap,
    };
    if (npwpController.text.isNotEmpty) {
      payload['npwp'] = npwpController.text;
    }
    if (npwpFile.value != null) {
      payload['npwp_file'] = npwpFile.value;
    }
    if (emailController.text.isNotEmpty) {
      payload['email'] = emailController.text;
    }
    try {
      final response = await postUseCase.call(
        url: 'api/blueray/customer/address',
        body: payload,
        converter: (json) => SuccessModel.fromJson(json),
      );
      response.fold(
        (left) {
          ActionDialog.errorGeneralBottom(
            title: left.detail,
            subtitle: left.message ?? '',
          );
        },
        (right) {
          if (right.action) {
            ActionDialog.successPopUp(
              image: Images.get.icSuccess,
              title: 'Alamat Berhasil ditambahkan',
              subtitle: 'Anda akan kembali ke menu list alamat dalam 2 detik',
              additional: [],
            );
            Future.delayed(const Duration(seconds: 2), () async {
              Get.back();
              Get.back();
            });
          } else {
            ActionDialog.errorGeneralBottom(
              subtitle: right.message,
            );
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }
}
