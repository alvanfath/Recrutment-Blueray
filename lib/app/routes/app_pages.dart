import 'package:get/get.dart';

import '../binding.dart';
import '../core/core.dart';
import '../modules/authenticated/create_address/views/create_address_view.dart';
import '../modules/authenticated/edit_address/views/edit_address_view.dart';
import '../modules/authenticated/home/views/home_view.dart';
import '../modules/authenticated/list_address/views/list_address_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: GlobalBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: GlobalBindings(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: Routes.CREATE_ADDRESS,
      page: () => const CreateAddressView(),
      binding: GlobalBindings(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: Routes.LIST_ADDRESS,
      page: () => const ListAddressView(),
      binding: GlobalBindings(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: Routes.EDIT_ADDRESS,
      page: () => const EditAddressView(),
      binding: GlobalBindings(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
  ];
}
