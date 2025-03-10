import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

class HomeController extends GetxController with StorageProvider {
  final PostUsecase postUsecase;
  HomeController({
    required this.postUsecase,
  });
  final count = 0.obs;
  final user = Rxn<Map<String, dynamic>>();

  @override
  void onReady() async {
    super.onReady();
    final data = getData(KeyStorage.user);
    if (data is Map) {
      user.value = Map<String, dynamic>.from(data);
    } else {
      user.value = null;
    }
  }

  Future<void> logout() async {
    await postUsecase.call(
      url: 'api/blueray/customer/logout',
      body: {},
      converter: (value) {
        if (value is String && value.isEmpty) {
          return {};
        }
        return value;
      },
    );
    await logoutBox();
    Get.offAllNamed(Routes.LOGIN);
  }
}
