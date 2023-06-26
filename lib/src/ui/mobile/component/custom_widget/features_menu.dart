import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/feature_card.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/transkrip_page.dart';
import 'package:academic_system/src/ui/mobile/page/schedule_page.dart';
import 'package:flutter/material.dart';

class FeaturesMenu extends StatelessWidget {
  const FeaturesMenu({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final List<Widget> studentFeatures = [
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 255, 245, 213),
        title: 'Jadwal',
      ),
      FeatureCard(
        page: MobileTranskripPage(mahasiswa: user),
        color: const Color.fromARGB(255, 213, 255, 223),
        title: 'Transkrip',
      ),
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 189, 214, 248),
        title: 'KRS',
      ),
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 231, 189, 248),
        title: 'Tagihan',
      ),
    ];

    final List<Widget> lecturerFeatures = [
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 255, 245, 213),
        title: 'Jadwal',
      ),
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 213, 255, 223),
        title: 'Nilai',
      ),
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 231, 189, 248),
        title: 'DPMK',
      ),
    ];

    final List<Widget> academicFeatures = [
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 255, 245, 213),
        title: 'Jadwal',
      ),
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 189, 214, 248),
        title: 'KRS',
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 40),
      color: const Color.fromARGB(255, 225, 241, 255),
      child: Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 20,
        runSpacing: 20,
        children: (user is Student)
            ? studentFeatures
            : (user is Lecturer)
                ? lecturerFeatures
                : academicFeatures,
      ),
    );
  }
}
