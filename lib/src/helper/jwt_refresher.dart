import 'package:academic_system/src/constant/api_url.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:academic_system/src/helper/secure_storage.dart';

class JWTRefresher<T> {
  static Future<bool> refreshToken(Response response) async {
    String? refreshToken = await SecureStorage.getToken('refreshToken');

    // First check the body response
    String message = jsonDecode(response.body)['message'];

    if (message == 'Expired token') {
      String? expiredToken = await SecureStorage.getToken('jwt');

      // Refresh token
      Uri refreshUrl = Uri.parse("$apiUrl/refresh");

      var response = await post(
        refreshUrl,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "expired_token": expiredToken,
          "refresh_token": refreshToken,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        await SecureStorage.deleteToken('jwt');

        await SecureStorage.setData('jwt', jsonResponse['access_token']);

        return true;
      }
    }
    return false;
  }
}
