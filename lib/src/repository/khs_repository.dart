import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/model/transkrip_nilai.dart';
import 'package:academic_system/src/model/transkrip_rinci.dart';
import 'package:http/http.dart';
import 'dart:convert';

class KhsRepository {
  Future<TranksripLengkap?> getTranskrip(String nim) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/transkrip');

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
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      var transkripNilai =
          TranskripNilai.createFromJson(jsonResponse['transkrip']);

      List<KartuHasilStudi> khs = (jsonResponse['khs'] as List)
          .map((value) => KartuHasilStudi.createFromJson(value))
          .toList();

      List<String> matkulLulus = (jsonResponse['nilai'] as List)
          .where((item) => item['status'] == 'lulus')
          .map((item) => item['id_mata_kuliah'].toString())
          .toList();

      Map<String, dynamic> map = {
        'transkrip': transkripNilai,
        'khs': khs,
        'matkul_lulus': matkulLulus,
      };

      return TranksripLengkap.createFromMap(map);
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getTranskrip(nim)
          : null;
    }

    return null;
  }

  Future<TranskripRinci?> getTranskripRinci(String nim) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/transkrip_terinci');

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
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      var transkripNilai =
          TranskripNilai.createFromJson(jsonResponse['transkrip']);

      List<KartuHasilStudi> khs = (jsonResponse['khs'] as List)
          .map((value) => KartuHasilStudi.createFromJson(value))
          .toList();

      List<NilaiMahasiswa> nilaiMahasiswa = (jsonResponse['nilai'] as List)
          .map((json) => NilaiMahasiswa.createFromJson(json))
          .toList();

      Map<String, dynamic> map = {
        'transkrip': transkripNilai,
        'khs': khs,
        'nilai': nilaiMahasiswa,
      };

      return TranskripRinci.createFromMap(map);
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getTranskripRinci(nim)
          : null;
    }

    return null;
  }
}
