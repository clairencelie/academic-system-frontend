import 'package:intl/intl.dart';

class InaDay {
  static String getDayName() {
    String enDay = DateFormat('EEEEE').format(
      DateTime.now(),
    );
    String inaDay = '';
    switch (enDay) {
      case 'Monday':
        inaDay = 'Senin';
        break;
      case 'Tuesday':
        inaDay = 'Selasa';
        break;
      case 'Wednesday':
        inaDay = 'Rabu';
        break;
      case 'Thursday':
        inaDay = 'Kamis';
        break;
      case 'Friday':
        inaDay = 'Jumat';
        break;
      case 'Saturday':
        inaDay = 'Sabtu';
        break;
      case 'Sunday':
        inaDay = 'Minggu';
        break;
      default:
        break;
    }
    return inaDay;
  }
}
