import 'package:intl/intl.dart';

class StringFormat {
  static String dateFormat({
    String format = 'dd MMMM yyyy',
    required String tanggal,
    bool toLocal = false,
  }) {
    try {
      DateTime parsedDate = DateTime.parse(tanggal);
      if (toLocal) {
        parsedDate = parsedDate.toLocal();
      }
      final outputFormat = DateFormat(format, 'id_ID');

      final formattedDate = outputFormat.format(parsedDate);
      return formattedDate;
    } catch (e) {
      return 'Tanggal tidak valid';
    }
  }
}
