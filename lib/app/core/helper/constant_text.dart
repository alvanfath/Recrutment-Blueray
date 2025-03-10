import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static Constants get = Constants._();
  String storageName = 'blueray';
  String errorTitle504 = 'Koneksi Terputus';
  String errorSubtitle504 =
      'Ups! Sepertinya koneksi internet Anda terputus. Periksa jaringan dan coba lagi.';

  String errorTitleGeneral = 'Sepertinya terjadi kesalahan';
  String errorSubtitleGeneral = 'Mohon maaf sepertinya ada kesalahan teknis';

  String errorTitle500 = 'Sedang Dalam Perbaikan';
  String errorSubtitle500 =
      'Aplikasi sedang dalam proses peningkatan layanan. Terima kasih atas kesabarannya! Kami akan segera kembali dengan pengalaman yang lebih baik.';
  String errorTitleManyRequest = 'Terlalu banyak request';
  String errorSubtileManyRequest =
      'Kami mendeteksi bahwa anda melakukan terlalu banyak aksi, kami akan membatasi aksi anda selama satu menit mulai dari anda menerima pemberitahuan ini';
  Color primaryColor = const Color(0xFF20C2F3);
  Color secondaryColor = const Color(0xFF99DFF5);
  Color errorColor = const Color(0xffEF402B);
  Color textPrimary = const Color(0xff2D3338);
  Color textSecondary = const Color(0xff71808E);
  Color borderPrimary = const Color(0xffDFE4EA);
}
