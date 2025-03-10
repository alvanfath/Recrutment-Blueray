import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class ModalSearchKecamatan extends StatefulWidget {
  final Map<String, dynamic>? data;
  final Function(Map<String, dynamic>) onSelected;
  final Future<List<dynamic>> Function(String) onChangeValue;

  const ModalSearchKecamatan({
    super.key,
    this.data,
    required this.onChangeValue,
    required this.onSelected,
  });

  @override
  State<ModalSearchKecamatan> createState() => _ModalSearchKecamatanState();
}

class _ModalSearchKecamatanState extends State<ModalSearchKecamatan> {
  List<dynamic>? listKecamatan = [];
  bool isEmpty = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: 'Kota/Kecamatan',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: HeroIcon(
                      HeroIcons.xMark,
                      size: 24,
                      color: Constants.get.textSecondary,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xffEEEEEE)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 16,
              ),
              width: MediaQuery.of(context).size.width,
              child: TextF(
                isHintVisible: false,
                onChanged: getKecamatan,
                hintText: 'Cari Kota/Kecamatan',
                suffixIcon: const HeroIcon(
                  HeroIcons.magnifyingGlass,
                  size: 16,
                ),
              ),
            ),
            const Divider(height: 1),
            if (listKecamatan != null) ...[
              if (listKecamatan!.isNotEmpty) ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listKecamatan!.map((e) {
                        final bool isSelected =
                            widget.data?['sub_district_id'] ==
                                e['sub_district_id'];
                        return itemWidget(
                          address: e['address'] ?? '',
                          provinsi: e['province'] ?? '',
                          isSelected: isSelected,
                          onTap: () {
                            if (!isSelected) {
                              Get.back();
                              widget.onSelected(e);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ] else ...[
                if (!isEmpty) ...[
                  const SizedBox(height: 100),
                  const Center(
                    child: TextWidget(
                      text: 'Tidak ada data berdasarkan apa yang anda cari',
                      align: TextAlign.center,
                    ),
                  )
                ],
              ],
            ] else ...[
              const SizedBox(height: 24),
              const Center(
                child: CircularProgressIndicator(),
              )
            ]
          ],
        ),
      ),
    );
  }

  Timer? debuounce;

  Future<void> getKecamatan(String value) async {
    if (debuounce?.isActive ?? false) {
      debuounce?.cancel();
    }
    setState(() {
      listKecamatan = null;
    });
    // Create a new Timer for debouncing the request
    debuounce = Timer(
      const Duration(seconds: 1),
      () async {
        if (value.isEmpty) {
          setState(() {
            listKecamatan = null;
            isEmpty = true;
          });
        } else {
          final data = await widget.onChangeValue(value);
          setState(() {
            listKecamatan = data;
            isEmpty = false;
          });
        }
      },
    );
  }

  Widget itemWidget({
    required String address,
    required String provinsi,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffFEF7F1) : Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  text: address,
                  color: isSelected
                      ? Constants.get.primaryColor
                      : Constants.get.textPrimary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
                TextWidget(
                  text: provinsi,
                  color: isSelected
                      ? Constants.get.primaryColor
                      : Constants.get.textSecondary,
                  fontSize: 11,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(
              height: 1,
              color: Color(0xffDFE4EA),
            )
          ],
        ),
      ),
    );
  }
}

class PinAlamat extends StatelessWidget {
  final String? value;
  final String label;
  final VoidCallback onTap;
  const PinAlamat({
    super.key,
    required this.value,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            TextWidget(
              text: '*',
              color: Constants.get.errorColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: Constants.get.borderPrimary,
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                HeroIcon(
                  HeroIcons.mapPin,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 12),
                if (value != null) ...[
                  Flexible(
                    child: TextWidget(
                      text: value!,
                      color: Constants.get.primaryColor,
                    ),
                  )
                ] else ...[
                  TextWidget(text: 'Tandai Alamat'),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ImageBuilder extends StatelessWidget {
  final String? image;
  final String label;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  const ImageBuilder({
    super.key,
    required this.image,
    required this.onTap,
    required this.onRemove,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            if (image != null) ...[
              GestureDetector(
                onTap: onRemove,
                behavior: HitTestBehavior.opaque,
                child: HeroIcon(
                  HeroIcons.trash,
                  size: 24,
                  color: Constants.get.errorColor,
                ),
              )
            ]
          ],
        ),
        const SizedBox(height: 8),
        if (image != null) ...[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image!,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
        ] else ...[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: Constants.get.borderPrimary,
                ),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: TextWidget(
                text: 'Unggah File',
              ),
            ),
          ),
        ]
      ],
    );
  }
}
