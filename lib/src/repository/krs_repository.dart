import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:http/http.dart';
import 'dart:convert';

class KrsRepository {
  Future<KrsSchedule?> getKrsSchedule() async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/krs_schedule');

    var response = await get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return KrsSchedule.createFromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getKrsSchedule()
          : null;
    }

    return null;
  }
}
