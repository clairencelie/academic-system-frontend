import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs_header.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/student_detail.dart';
import 'package:flutter/material.dart';

class KRSWebPage extends StatelessWidget {
  final Student user;
  const KRSWebPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Kartu Rencana Studi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StudentDetail(user: user),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Pengisian KRS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '12 Mei 2023 - 17 Mei 2023',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ListMatkulKrsHeader(),
              const Divider(),
              // TODO: Cek terlebih dahulu, apakah sudah memenuhi persyaratan atau belum (bisa pakai ternary operator).
              ListMatkulKRS(user: user),
              // TODO: Disable Info
              // const Text(
              //   'Pengisian KRS untuk semester selanjutnya belum dimulai',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.grey,
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
