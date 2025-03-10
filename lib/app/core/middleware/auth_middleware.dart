import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware with StorageProvider {
  @override
  RouteSettings? redirect(String? route) {
    final token = getData(KeyStorage.token);
    final user = getData(KeyStorage.user);
    bool isAuthenticated = token != null && user != null;
    if (!isAuthenticated) {
      return const RouteSettings(
        name: Routes.LOGIN,
      ); // Redirect ke halaman login
    }
    return null;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    debugPrint('Middleware executed before building page: $page');
    return super.onPageBuildStart(page);
  }

  @override
  Widget onPageBuilt(Widget page) {
    debugPrint('Middleware executed after page is built: $page');
    return super.onPageBuilt(page);
  }
}
