import 'package:academic_system/src/ui/web/component/custom_widget/cms_item.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/schedule_table.dart';
import 'package:academic_system/src/ui/web/page/akademik/create_schedule.dart';
import 'package:academic_system/src/ui/web/page/akademik/form_tahun_akademik.dart';
import 'package:academic_system/src/ui/web/page/akademik/krs_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CMSPage extends StatelessWidget {
  const CMSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    'Content Management System',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CMSItem(
                        title: 'Tambah',
                        icons: Icons.post_add_rounded,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateSchedulePage(),
                            ),
                          );
                        },
                      ),
                      CMSItem(
                        title: 'KRS',
                        icons: Icons.library_books,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KRSManagementPage(),
                              ));
                        },
                      ),
                      CMSItem(
                        title: 'Tahun Akademik',
                        icons: Icons.view_timeline,
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: SizedBox(
                                  width: 430,
                                  child: FormTahunAkademik(),
                                ), // TODO: FormSetTahunAkademik
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const ScheduleTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
