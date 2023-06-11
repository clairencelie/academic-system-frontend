import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_extractor.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/administrator.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/model/user_login_request.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UserRepository {
  Future<User?> login(UserLoginRequest userLoginRequest) async {
    Uri url = Uri.parse("$apiUrl/login");

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "id": userLoginRequest.id,
        "password": userLoginRequest.password,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (jsonResponse["message"] == "login success") {
        String accessToken = jsonResponse["access_token"];
        String refreshToken = jsonResponse["refresh_token"];

        await SecureStorage.setData("jwt", accessToken);
        await SecureStorage.setData("refreshToken", refreshToken);

        return await getUser();
      }
    }
    return null;
  }

  Future<User?> getUser() async {
    String? jwt = await SecureStorage.getToken('jwt');

    String idFromToken = JWTExtractor.getSub(jwt!);

    Uri url = Uri.parse("$apiUrl/get_user/$idFromToken");

    var response = await get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      String role = jsonResponse['role'];
      switch (role) {
        case 'akademik':
          return Academic.createFromJson(jsonResponse);
        case 'dosen':
          return Lecturer.createFromJson(jsonResponse);
        case 'mahasiswa':
          return Student.createFromJson(jsonResponse);
        case 'tata_usaha':
          return Administrator.createFromJson(jsonResponse);
        default:
          return null;
      }
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response) ? await getUser() : null;
    }
    return null;
  }

  Future<List<Lecturer>> getLecturer() async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse("$apiUrl/lecturers");

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
          .map((lecturer) => Lecturer.createFromJson(lecturer))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getLecturer()
          : [];
    }

    return [];
  }
}
