import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/login_page.dart';
import 'package:flutter/material.dart';

class WebConfigurationPage extends StatelessWidget {
  final User user;

  const WebConfigurationPage({
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
                    builder: (context) => const WebLoginPage(),
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
