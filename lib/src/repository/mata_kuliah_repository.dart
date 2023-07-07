import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/master_matkul.dart';
import 'package:academic_system/src/model/matkul_baru.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MataKuliahRepository {
  Future<List<MasterMatkul>> getAllMataKuliahMaster() async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse("$apiUrl/master/matkul");

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
          .map((mataKuliahMaster) =>
              MasterMatkul.createFromJson(mataKuliahMaster))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getAllMataKuliahMaster()
          : [];
    }

    return [];
  }

  Future<List<LearningSubject>> getAllMataKuliah() async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse("$apiUrl/learning_subjects");

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
          .map((learningSubject) =>
              LearningSubject.createFromJson(learningSubject))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getAllMataKuliah()
          : [];
    }

    return [];
  }

  Future<String> tambahMataKuliah({required MatkulBaru matkulBaru}) async {
    Uri url = Uri.parse('$apiUrl/create/matkul');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'new_matkul': jsonEncode(matkulBaru),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await tambahMataKuliah(matkulBaru: matkulBaru)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> updateMataKuliah({required LearningSubject matkulBaru}) async {
    Uri url = Uri.parse('$apiUrl/update/matkul');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'new_matkul': jsonEncode(matkulBaru),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await updateMataKuliah(matkulBaru: matkulBaru)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> deleteMataKuliah(String id) async {
    Uri url = Uri.parse('$apiUrl/delete/matkul');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id_mata_kuliah': jsonEncode([id]),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await deleteMataKuliah(id)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }
}
