import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/identity_card.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/features_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Selamat malam ${user.name}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                IdentityCard(user: user),
                FeaturesMenu(user: user),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Artikel',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 150,
                  color: Colors.lime,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 150,
                  color: Colors.cyan,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 150,
                  color: Colors.indigo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
