import 'dart:convert';

class JWTExtractor {
  static String getSub(String token) {
    return jsonDecode(
      utf8.fuse(base64).decode(
            base64.normalize(token.split(".")[1]),
          ),
    )["sub"];
  }
}
