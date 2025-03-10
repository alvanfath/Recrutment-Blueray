import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/authenticated/list_address/views/list_addrees_component.dart';
import 'package:recrutment_blueray/app/routes/app_pages.dart';

import '../controllers/list_address_controller.dart';

class ListAddressView extends GetView<ListAddressController> {
  const ListAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getListAddress();
      },
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          isLeading: true,
          title: 'List Alamat',
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await Get.toNamed(Routes.CREATE_ADDRESS);
                await controller.getListAddress();
              },
              child: HeroIcon(
                HeroIcons.plusCircle,
                color: Constants.get.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Obx(() {
                final list = controller.listAddress.value;
                if (list != null) {
                  if (list.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: list.map((e) {
                        return AddressComponent(
                          addressLabel: e['address_label'],
                          name: e['name'] ?? '',
                          noHp: e['phone_number'] ?? '',
                          address: e['address'] ?? '',
                          addressMap: e['address_map'] ?? '',
                          idAddress: e['address_id'] ?? 0,
                          onDelete: (id) {
                            Get.bottomSheet(
                              ModaLBottomWidget(
                                icon: Images.get.icError,
                                title: 'Peringatan',
                                subtitle:
                                    'Anda yakin ingin menghapus alamat ini?',
                                additionalContent: [
                                  Button(
                                    title: 'Ya',
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteAddress(id);
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                          onEdit: () async {
                            await Get.toNamed(
                              Routes.EDIT_ADDRESS,
                              arguments: e,
                            );
                            await controller.getListAddress();
                          },
                          isPrimary: e['is_primary'] ?? false,
                          onSetDefault: (id) {
                            controller.setDefault(id);
                          },
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        SvgPicture.asset(
                          Images.get.icEmpty,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          text: 'Anda tidak memiliki alamat, ayo tambah alamat',
                          align: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Button(
                          title: 'Tambah',
                          onPressed: () async {
                            await Get.toNamed(Routes.CREATE_ADDRESS);
                            await controller.getListAddress();
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      CircularProgressIndicator()
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
