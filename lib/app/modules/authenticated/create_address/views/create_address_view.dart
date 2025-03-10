import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recrutment_blueray/app/core/core.dart';
import 'package:recrutment_blueray/app/modules/authenticated/create_address/views/create_address_component.dart';
import 'package:recrutment_blueray/app/modules/authenticated/maps/maps_widget.dart';

import '../controllers/create_address_controller.dart';

class CreateAddressView extends GetView<CreateAddressController> {
  const CreateAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        isLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            TitleWidget(
              title: 'Tambah Alamat Pengiriman',
              subtitle: 'Mohon isi form dibawah ini',
            ),
            const SizedBox(height: 24),
            TextF(
              hint: 'Label Alamat',
              hintText: 'Contoh: Rumah Ayang',
              controller: controller.addressLabelController,
              isRequired: true,
            ),
            const SizedBox(height: 12),
            TextF(
              hint: 'Nama Penerima',
              hintText: 'Contoh: Jhon Doe',
              controller: controller.nameController,
              isRequired: true,
            ),
            const SizedBox(height: 12),
            TextF(
              hint: 'Nomor Telepon',
              hintText: 'Contoh: 08938123xxxx',
              controller: controller.phoneController,
              keyboardType: TextInputType.number,
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              isRequired: true,
            ),
            const SizedBox(height: 12),
            TextF(
              hint: 'Email',
              hintText: 'Contoh: jhone@gmail.com',
              controller: controller.emailController,
            ),
            const SizedBox(height: 12),
            Obx(() {
              final data = controller.district.value;
              return TextFormSelectCustom(
                dataSelected: data,
                textDisplay: 'address',
                placeHolder: 'Cari kecamatan',
                label: 'Kecamatan',
                isRequired: true,
                onTap: () {
                  Get.bottomSheet(
                    ModalSearchKecamatan(
                      onChangeValue: controller.searchKecamatan,
                      onSelected: (value) {
                        controller.district.value = value;
                      },
                      data: data,
                    ),
                    isScrollControlled: true,
                    ignoreSafeArea: true,
                  );
                },
              );
            }),
            const SizedBox(height: 12),
            Obx(() {
              final error = controller.errorKodePos.value;
              return TextF(
                hint: 'Kode Pos',
                hintText: 'Contoh: 12345',
                controller: controller.kodePosController,
                onChanged: controller.checkKodePos,
                keyboardType: TextInputType.number,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                isRequired: true,
                validator: (String? value) {
                  return error;
                },
              );
            }),
            const SizedBox(height: 12),
            TextArea(
              size: 100,
              maxLine: 3,
              hintText: 'Contoh: Alamat rumahku',
              controller: controller.addressController,
              isRequired: true,
              hint: 'Alamat Lengkap',
            ),
            const SizedBox(height: 12),
            Obx(() {
              final location = controller.locationMap.value;
              return PinAlamat(
                label: 'Pin Alamat',
                value: location?.alamatLengkap,
                onTap: () async {
                  final data = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsWidget(
                        lat: location?.lat,
                        long: location?.long,
                      ),
                    ),
                  );
                  if (data != null) {
                    LatLng latLng = data;
                    final String? location =
                        await LocationHelper.getNamedLocation(latLng);
                    if (location != null) {
                      final response = LocationModel(
                        lat: latLng.latitude,
                        long: latLng.longitude,
                        alamatLengkap: location,
                      );
                      controller.locationMap.value = response;
                    }
                  }
                },
              );
            }),
            const SizedBox(height: 12),
            TextF(
              hint: 'NPWP',
              hintText: 'Contoh: 1234351321',
              keyboardType: TextInputType.number,
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              controller: controller.npwpController,
            ),
            const SizedBox(height: 16),
            Obx(() {
              final value = controller.npwpFile.value;
              return ImageBuilder(
                image: value,
                onRemove: () {
                  controller.npwpFile.value = null;
                },
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    controller.uploadNpwp(image.path);
                  }
                },
                label: 'Unggah File',
              );
            }),
            const SizedBox(height: 24),
            Obx(() {
              final isValid = controller.validButton.value;
              return Button(
                title: 'Simpan',
                color: isValid
                    ? Constants.get.primaryColor
                    : Constants.get.secondaryColor,
                onPressed: () {
                  if (isValid) {
                    controller.postAlamat();
                  }
                },
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
