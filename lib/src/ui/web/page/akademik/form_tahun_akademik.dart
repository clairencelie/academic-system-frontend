import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/web_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormTahunAkademik extends StatefulWidget {
  const FormTahunAkademik({super.key});

  @override
  State<FormTahunAkademik> createState() => _FormTahunAkademikState();
}

class _FormTahunAkademikState extends State<FormTahunAkademik> {
  TextEditingController tahunAkademik1 = TextEditingController();
  TextEditingController tahunAkademik2 = TextEditingController();
  TextEditingController semester = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetTahunAkademik());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Form Set Tahun Akademik',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<KrsBloc, KrsState>(
                builder: (context, state) {
                  if (state is KrsScheduleLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tahun Akademik Berjalan: ${state.krsSchedule.tahunAkademik}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Semester: ${state.krsSchedule.semester}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else if (state is KrsScheduleNotFound) {
                    return const Text(
                      'Data tahun akademik gagal didapatkan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Tahun Akademik'),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: WebFormField(
                      hintText: '...',
                      controller: tahunAkademik1,
                    ),
                  ),
                  const Text(
                    '   /   ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: WebFormField(
                      hintText: '...',
                      controller: tahunAkademik2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Semester'),
              WebFormField(
                hintText: 'Semester...',
                controller: semester,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 193, 47, 47)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocListener<TahunAkademikBloc, TahunAkademikState>(
                    listener: (context, state) {
                      if (state is TahunAkademikUpdateSuccess) {
                        Navigator.of(context, rootNavigator: true).pop();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return InfoDialog(
                              title: 'Informasi',
                              body: state.message,
                              onClose: () {
                                Navigator.pop(context);
                                context.read<KrsBloc>().add(GetTahunAkademik());
                              },
                            );
                          },
                        );
                      }
                      if (state is TahunAkademikUpdateFailed) {
                        Navigator.of(context, rootNavigator: true).pop();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return InfoDialog(
                              title: 'Informasi',
                              body: state.message,
                              onClose: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      } else if (state is TahunAkademikLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 0, 32, 96),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: SizedBox(
                      height: 45,
                      width: 170,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 53, 230, 112)),
                        ),
                        onPressed: () {
                          final String tahunAkademik =
                              '${tahunAkademik1.text}/${tahunAkademik2.text}';

                          print(tahunAkademik);

                          context.read<TahunAkademikBloc>().add(
                                SetTahunAkademik(
                                  tahunAkademik: tahunAkademik,
                                  semester: semester.text,
                                ),
                              );
                          Navigator.pop(context);
                        },
                        child: const Text('Set Tahun Akademik'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
