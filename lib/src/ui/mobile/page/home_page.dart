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
                    const ArticleCard(
                      title: 'Apa Itu Program Studi Sistem Informasi?',
                      imgPath: 'assets/img/article/si.jpg',
                    ),
                    const ArticleCard(
                      title: 'Apa Itu Program Studi Teknik Informatika?',
                      imgPath: 'assets/img/article/ti.jpg',
                    ),
                    const ArticleCard(
                      title:
                          'Ini Dia List Bahasa Pemrograman Yang Sedang Tren!',
                      imgPath: 'assets/img/article/eb.jpg',
                    ),
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

class ArticleCard extends StatelessWidget {
  final String title;
  final String imgPath;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Color.fromARGB(59, 0, 0, 0),
          ),
        ],
      ),
      child: Material(
        color: const Color.fromARGB(190, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
