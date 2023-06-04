import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/login_page.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  final User user;

  const ConfigurationPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text('ID: ${user.id}'),
            Text('Name: ${user.name}'),
            Text('Role: ${user.role}'),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                SecureStorage.deleteToken('jwt');
                SecureStorage.deleteToken('refreshToken');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileLoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
