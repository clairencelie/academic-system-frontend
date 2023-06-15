import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/kartu_rencana_studi.dart';
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

  Future<String> createKrs(
      KartuRencanaStudi krs, List<String> listMataKuliahDiambil) async {
    Map<String, dynamic> data = {
      'krs': jsonEncode(krs),
      'list_matkul': jsonEncode(listMataKuliahDiambil)
    };

    Uri url = Uri.parse('$apiUrl/create/krs');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'krs': jsonEncode(data),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await createKrs(krs, listMataKuliahDiambil)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }
}
