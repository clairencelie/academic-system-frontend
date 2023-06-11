import 'package:academic_system/src/ui/web/component/custom_widget/cms_item.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/schedule_table.dart';
import 'package:academic_system/src/ui/web/page/create_schedule.dart';
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
                                builder: (context) =>
                                    const CreateSchedulePage(),
                              ));
                        },
                      ),
                      CMSItem(
                        title: 'Arsip',
                        icons: Icons.view_timeline,
                        onTap: () async {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return const ScheduleReferenceDialog();
                          //   },
                          // );
                        },
                      ),

                      // Schedule To PDF
                      // BlocListener<SchedulePdfBloc, SchedulePdfState>(
                      //   listener: (context, state) async {
                      //     if (state is SchedulePdfLoading) {
                      //       showDialog(
                      //         context: context,
                      //         barrierDismissible: false,
                      //         builder: (context) {
                      //           return const Center(
                      //             child: CircularProgressIndicator(
                      //               color: Color.fromARGB(255, 0, 32, 96),
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     } else if (state is SchedulePdfLoaded) {
                      //       Navigator.of(context, rootNavigator: true).pop();
                      //       final pdf =
                      //           await PDFGenerate.generatePdf(state.schedules);
                      //       PDFGenerate.openFile(pdf);
                      //     }
                      //   },
                      //   child: CMSItem(
                      //     title: 'Export',
                      //     icons: Icons.download_for_offline_rounded,
                      //     onTap: () {
                      //       context
                      //           .read<SchedulePdfBloc>()
                      //           .add(ExportSchedule());
                      //     },
                      //   ),
                      // ),
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
