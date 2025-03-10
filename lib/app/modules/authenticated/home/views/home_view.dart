import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/authenticated/home/views/home_component.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        isLeading: false,
        title: 'Home Page',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(() {
          final Map<String, dynamic>? data = controller.user.value;
          if (data != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          data['avatar'] ?? '',
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextWidget(
                        text: "${data['first_name']} ${data['last_name']}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      TextWidget(
                        text: "${data['email']}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      TextWidget(
                        text: StringFormat.dateFormat(
                          tanggal: data['created_at'],
                          toLocal: true,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  height: 1,
                  color: Constants.get.borderPrimary,
                ),
                MenuList(
                  text: 'List Alamat',
                  icon: HeroIcons.queueList,
                  onTap: () {
                    Get.toNamed(Routes.LIST_ADDRESS);
                  },
                ),
                MenuList(
                  text: 'Logout',
                  icon: HeroIcons.arrowLeftStartOnRectangle,
                  onTap: () {
                    Get.bottomSheet(
                      ModaLBottomWidget(
                        icon: Images.get.icError,
                        title: 'Peringatan',
                        subtitle: 'Anda yakin ingin keluar?',
                        additionalContent: [
                          Button(
                            title: 'Ya',
                            onPressed: () {
                              Get.back();
                              controller.logout();
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            );
          }
          return Column(
            children: [
              const SizedBox(height: 100),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
