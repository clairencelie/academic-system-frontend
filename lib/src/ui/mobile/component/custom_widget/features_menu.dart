import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/feature_card.dart';
import 'package:academic_system/src/ui/mobile/page/akademik/krs_management.dart';
import 'package:academic_system/src/ui/mobile/page/dosen/dpmk.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/krs_mobile.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/tagihan_pembayaran.dart';
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
        icon: Icons.schedule,
      ),
      FeatureCard(
        page: MobileTranskripPage(mahasiswa: user),
        color: const Color.fromARGB(255, 213, 255, 223),
        title: 'Transkrip',
        icon: Icons.star,
      ),
      FeatureCard(
        page: MobileKRSPage(user: user),
        color: const Color.fromARGB(255, 189, 214, 248),
        title: 'KRS',
        icon: Icons.description_rounded,
      ),
      FeatureCard(
        page: MobileTagihanPembayaran(user: user),
        color: const Color.fromARGB(255, 231, 189, 248),
        title: 'Tagihan',
        icon: Icons.payment,
      ),
    ];

    final List<Widget> lecturerFeatures = [
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 255, 245, 213),
        title: 'Jadwal',
        icon: Icons.schedule,
      ),
      FeatureCard(
        page: MobileDPMKPage(dosen: user),
        color: const Color.fromARGB(255, 231, 189, 248),
        title: 'DPMK',
        icon: Icons.people,
      ),
    ];

    final List<Widget> academicFeatures = [
      FeatureCard(
        page: SchedulePage(user: user),
        color: const Color.fromARGB(255, 255, 245, 213),
        title: 'Jadwal',
        icon: Icons.schedule,
      ),
      const FeatureCard(
        page: MobileKRSManagementPage(),
        color: Color.fromARGB(255, 189, 214, 248),
        title: 'KRS',
        icon: Icons.description_rounded,
      ),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        spacing: 20,
        runSpacing: 30,
        children: (user is Student)
            ? studentFeatures
            : (user is Lecturer)
                ? lecturerFeatures
                : academicFeatures,
      ),
    );
  }
}
