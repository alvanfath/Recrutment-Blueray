import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class PasswordValidate extends StatelessWidget {
  final String password;
  const PasswordValidate({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text: 'Password Harus Memiliki',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 8),
        validateWidget(
          title: 'Setidaknya 8 karakter',
          isCheck: Validator.isValidLengthPassWord(password),
        ),
        const SizedBox(height: 8),
        validateWidget(
          title: 'Terdapat huruf besar dan huruf kecil',
          isCheck: Validator.isValidLowerCase(password) &&
              Validator.isValidUpperCase(password),
        ),
        const SizedBox(height: 8),
        validateWidget(
          title: 'Setidaknya terdapat 1 angka',
          isCheck: Validator.isValidPasswordNumber(password),
        ),
        const SizedBox(height: 8),
        validateWidget(
          title: 'Setidaknya terdapat 1 Simbol',
          isCheck: Validator.isValidSymbol(password),
        ),
      ],
    );
  }

  Widget validateWidget({
    required String title,
    required bool isCheck,
  }) {
    if (isCheck) {
      return Row(
        children: [
          const HeroIcon(
            HeroIcons.checkCircle,
            size: 16,
            color: Color(0xff308D42),
            style: HeroIconStyle.solid,
          ),
          const SizedBox(width: 8),
          TextWidget(
            text: title,
            color: Constants.get.textSecondary,
            fontSize: 13,
          )
        ],
      );
    }
    return Row(
      children: [
        HeroIcon(
          HeroIcons.checkCircle,
          size: 16,
          color: Constants.get.textSecondary,
        ),
        const SizedBox(width: 8),
        TextWidget(
          text: title,
          color: Constants.get.textSecondary,
          fontSize: 13,
        )
      ],
    );
  }
}
