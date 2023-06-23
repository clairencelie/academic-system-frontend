import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/rincian_tagihan.dart';
import 'package:academic_system/src/model/tagihan_perkuliahan.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TagihanRepository {
  Future<List<TagihanPerkuliahan>> getTagihanMahasiswa(String nim) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/mahasiswa/tagihan');

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
      var jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse
          .map((json) => TagihanPerkuliahan.createFromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getTagihanMahasiswa(nim)
          : [];
    }

    return [];
  }

  Future<List<RincianTagihan>> getRincianTagihan(
      String idTagihanPembayaran) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/mahasiswa/tagihan/rincian');

    var response = await post(
      url,
      body: {
        'id_pembayaran_kuliah': idTagihanPembayaran,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse
          .map((json) => RincianTagihan.createFromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getRincianTagihan(idTagihanPembayaran)
          : [];
    }

    return [];
  }
}
