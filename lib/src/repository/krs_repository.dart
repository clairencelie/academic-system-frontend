import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/kartu_rencana_studi.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/new_kartu_rencana_studi.dart';
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
      NewKartuRencanaStudi krs, List<String> listMataKuliahDiambil) async {
    Map<String, dynamic> data = {
      'krs': krs,
      'list_matkul': listMataKuliahDiambil
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

  Future<String> updateKrs(String idKrs, NewKartuRencanaStudi krs,
      List<String> listMataKuliahDiambil) async {
    Map<String, dynamic> data = {
      'id_krs': idKrs,
      'krs': krs,
      'list_matkul': listMataKuliahDiambil
    };

    Uri url = Uri.parse('$apiUrl/update/krs');

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
          ? await updateKrs(idKrs, krs, listMataKuliahDiambil)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> lockKrs(String idKrs) async {
    Uri url = Uri.parse('$apiUrl/commit/krs');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id_krs': idKrs,
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await lockKrs(idKrs)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> approveKrs(String idKrs) async {
    Uri url = Uri.parse('$apiUrl/approve/krs');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id_krs': idKrs,
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await approveKrs(idKrs)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> unApproveKrs(String idKrs) async {
    Uri url = Uri.parse('$apiUrl/unapprove/krs');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id_krs': idKrs,
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await approveKrs(idKrs)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<List<KartuRencanaStudi>> getKrs(String nim) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/krs');

    var response = await post(
      url,
      body: {
        'nim': nim,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((krs) => KartuRencanaStudi.createFromJson(krs))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response) ? await getKrs(nim) : [];
    }

    return [];
  }

  Future<List<KartuRencanaStudiLengkap>> getKrsLengkap(String nim) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/krs');

    var response = await post(
      url,
      body: {
        'nim': nim,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((krs) => KartuRencanaStudiLengkap.createFromJson(krs))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getKrsLengkap(nim)
          : [];
    }

    return [];
  }

  Future<List<KartuRencanaStudiLengkap>> getAllKrs() async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/get/krs');

    var response = await get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((krs) => KartuRencanaStudiLengkap.createFromJson(krs))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response) ? await getAllKrs() : [];
    }

    return [];
  }
}
