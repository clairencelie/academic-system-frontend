import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String convertToDartDateFormat(String inputDate) {
    initializeDateFormatting('id_ID', null);

    final originalFormat = DateFormat('dd-MM-yyyy');
    final convertedFormat = DateFormat('dd MMMM yyyy', 'id_ID');

    final dateTime = originalFormat.parse(inputDate);
    final result = convertedFormat.format(dateTime);

    return result;
  }
}
