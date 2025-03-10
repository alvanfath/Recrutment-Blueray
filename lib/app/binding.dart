import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/authenticated/create_address/controllers/create_address_controller.dart';
import 'package:recrutment_blueray/app/modules/authenticated/edit_address/controllers/edit_address_controller.dart';
import 'package:recrutment_blueray/app/modules/authenticated/home/controllers/home_controller.dart';
import 'package:recrutment_blueray/app/modules/authenticated/list_address/controllers/list_address_controller.dart';
import 'package:recrutment_blueray/app/modules/login/controllers/login_controller.dart';
import 'package:recrutment_blueray/app/modules/register/controllers/register_controller.dart';

class GlobalBindings extends Bindings {
  late GetUsecase getRequest;
  late PostUsecase postUsecase;
  late PutUsecase putUsecase;
  late DeleteUsecase deleteUsecase;
  late PostFormdataUsecase postFormDataUseCase;
  GlobalBindings() {
    final ApiClient client = ApiClient();
    getRequest = GetUsecase(client);
    postUsecase = PostUsecase(client);
    putUsecase = PutUsecase(client);
    deleteUsecase = DeleteUsecase(client);
    postFormDataUseCase = PostFormdataUsecase(client);
  }

  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        postUsecase: postUsecase,
      ),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        postUsecase: postUsecase,
      ),
    );

    //authenticated
    Get.lazyPut<HomeController>(
      () => HomeController(postUsecase: postUsecase),
    );
    Get.lazyPut<CreateAddressController>(
      () => CreateAddressController(
        getUsecase: getRequest,
        postUseCase: postUsecase,
        postFormData: postFormDataUseCase,
      ),
    );
    Get.lazyPut<ListAddressController>(
      () => ListAddressController(
        getUsecase: getRequest,
        deleteUsecase: deleteUsecase,
        postUsecase: postUsecase,
      ),
    );
    Get.lazyPut<EditAddressController>(
      () => EditAddressController(
        getUsecase: getRequest,
        putUsecase: putUsecase,
        postFormData: postFormDataUseCase,
      ),
    );
  }
}
