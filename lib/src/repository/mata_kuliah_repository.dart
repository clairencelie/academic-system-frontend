import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MataKuliahRepository {
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
}
