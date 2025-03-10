import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

class ListAddressController extends GetxController with StorageProvider {
  final GetUsecase getUsecase;
  final DeleteUsecase deleteUsecase;
  final PostUsecase postUsecase;
  ListAddressController({
    required this.getUsecase,
    required this.deleteUsecase,
    required this.postUsecase,
  });

  final count = 0.obs;
  final listAddress = Rxn<List<dynamic>>();

  @override
  void onReady() async {
    super.onReady();
    await getListAddress();
  }

  Future<void> getListAddress() async {
    listAddress.value = null;
    try {
      final response = await getUsecase.call(
        url: 'api/blueray/customer/address',
        converter: (value) => List.from(value),
      );
      response.fold(
        (left) {
          if (left.statusCode == 401) {
            ActionDialog.errorGeneralBottom(
              title: 'Sesion sudah berakhir',
              subtitle: 'Silakan login ulang',
              onClose: () async {
                await logoutBox();
                Get.offAllNamed(Routes.LOGIN);
              },
            );
          } else {
            ActionDialog.errorGeneralBottom(
              subtitle: left.message ?? '',
              title: left.detail,
            );
          }
        },
        (right) {
          listAddress.value = right;
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }

  Future<void> setDefault(int id) async {
    ActionDialog.showLoading();
    try {
      final response = await postUsecase.call(
        url: 'api/blueray/customer/address/primary',
        body: {
          'address_id': id,
        },
        converter: (value) => SuccessModel.fromJson(value),
      );
      response.fold(
        (left) {
          if (left.statusCode == 401) {
            ActionDialog.errorGeneralBottom(
              title: 'Sesion sudah berakhir',
              subtitle: 'Silakan login ulang',
              onClose: () async {
                await logoutBox();
                Get.offAllNamed(Routes.LOGIN);
              },
            );
          } else {
            ActionDialog.errorGeneralBottom(
              subtitle: left.message ?? '',
              title: left.detail,
            );
          }
        },
        (right) async {
          ActionDialog.hideLoadingDialog();
          if (right.action) {
            await getListAddress();
          } else {
            ActionDialog.errorGeneralBottom(subtitle: right.message);
          }
        },
      );
    } catch (e) {
      ActionDialog.errorGeneralBottom(subtitle: e.toString());
    }
  }

  Future<void> deleteAddress(int id) async {
    ActionDialog.showLoading();
    try {
      final response = await deleteUsecase.call(
        url: 'api/blueray/customer/address/delete',
        body: {
          'address_id': id,
        },
        converter: (value) => SuccessModel.fromJson(value),
      );
      response.fold(
        (left) {
          if (left.statusCode == 401) {
            ActionDialog.errorGeneralBottom(
              title: 'Sesion sudah berakhir',
              subtitle: 'Silakan login ulang',
              onClose: () async {
                await logoutBox();
                Get.offAllNamed(Routes.LOGIN);
              },
            );
          } else {
            ActionDialog.errorGeneralBottom(
              subtitle: left.message ?? '',
              title: left.detail,
            );
          }
        },
        (right) async {
          ActionDialog.hideLoadingDialog();
          if (right.action) {
            await getListAddress();
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
