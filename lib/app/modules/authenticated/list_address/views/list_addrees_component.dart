import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class AddressComponent extends StatelessWidget {
  final int idAddress;
  final bool isPrimary;
  final String addressLabel;
  final String name;
  final String noHp;
  final String address;
  final String addressMap;
  final Function(int id) onDelete;
  final Function(int id) onSetDefault;
  final VoidCallback onEdit;
  const AddressComponent({
    super.key,
    required this.name,
    required this.noHp,
    required this.address,
    required this.addressLabel,
    required this.addressMap,
    required this.idAddress,
    required this.onDelete,
    required this.onEdit,
    required this.isPrimary,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Constants.get.borderPrimary,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextWidget(
                  text: addressLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onEdit,
                    child: HeroIcon(
                      HeroIcons.pencil,
                      size: 24,
                      color: Constants.get.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onDelete(idAddress);
                    },
                    child: HeroIcon(
                      HeroIcons.trash,
                      size: 24,
                      color: Constants.get.errorColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          TextWidget(
            text: name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            fontSize: 13,
          ),
          const SizedBox(height: 8),
          TextWidget(
            text: noHp,
            color: Constants.get.textSecondary,
            fontSize: 13,
          ),
          const SizedBox(height: 8),
          TextWidget(
            text: address,
            color: Constants.get.textSecondary,
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: addressMap,
            color: Constants.get.textSecondary,
          ),
          const SizedBox(height: 8),
          if (isPrimary) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffE9F6EB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextWidget(
                text: 'Alamat Utama',
                color: Color(0xff288C50),
              ),
            ),
          ] else ...[
            GestureDetector(
              onTap: () {
                onSetDefault(idAddress);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(width: 1, color: Constants.get.borderPrimary),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextWidget(
                  text: 'Atur sebagai alamat utama',
                  color: Constants.get.textSecondary,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
