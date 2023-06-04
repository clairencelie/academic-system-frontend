import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/repository/user_repository.dart';

class UserTokenCheck {
  static Future<User?> isSet() async {
    String? token = await SecureStorage.getToken("jwt");

    if (token != null) {
      UserRepository userRepository = UserRepository();

      return await userRepository.getUser();
    }

    return null;
  }
}
