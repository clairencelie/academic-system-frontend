import 'dart:math';

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
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IdentityCard(user: user),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    const ListArtikel(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListArtikel extends StatelessWidget {
  const ListArtikel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          height: 150,
          color: Color.fromARGB(
            255,
            Random().nextInt(255) + 220,
            Random().nextInt(255) + 220,
            Random().nextInt(255) + 220,
          ),
        );
      },
    );
  }
}
