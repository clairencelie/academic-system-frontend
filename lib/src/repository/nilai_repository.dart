import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/matkul_dosen.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/model/tahun_akademik.dart';
import 'package:http/http.dart';
import 'dart:convert';

class NilaiRepository {
  Future<List<MatkulDosen>> getMatkulDosen(String idDosen) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/dosen/daftar_matkul');

    var response = await post(
      url,
      body: {
        'id_dosen': idDosen,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse
          .map((json) => MatkulDosen.createFromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getMatkulDosen(idDosen)
          : [];
    }

    return [];
  }

  Future<List<NilaiMahasiswa>> getNilaiMhs(
      String idMataKuliah, String tahunAkademik, String semester) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/mata_kuliah/nilai');

    var response = await post(
      url,
      body: {
        'id_mata_kuliah': idMataKuliah,
        'tahun_akademik': tahunAkademik,
        'semester': semester,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse
          .map((json) => NilaiMahasiswa.createFromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getNilaiMhs(idMataKuliah, tahunAkademik, semester)
          : [];
    }

    return [];
  }

  Future<List<TahunAkademik>> getTahunAkademik() async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/dosen/tahun_akademik');

    var response = await get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse
          .map((json) => TahunAkademik.createFromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getTahunAkademik()
          : [];
    }

    return [];
  }
}
