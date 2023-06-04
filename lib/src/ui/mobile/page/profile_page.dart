import 'package:academic_system/src/model/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({
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
            const Text('Profile Page'),
            Text('ID: ${user.id}'),
            Text('Name: ${user.name}'),
            Text('Role: ${user.role}'),
          ],
        ),
      ),
    );
  }
}
