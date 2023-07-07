import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormTahunAkademik extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const FormTahunAkademik({
    super.key,
    required this.krsSchedule,
  });

  @override
  State<FormTahunAkademik> createState() => _FormTahunAkademikState();
}

class _FormTahunAkademikState extends State<FormTahunAkademik> {
  String? valueTA;
  String? valueSmt;

  final int currentYear = DateTime.now().year;

  List<DropdownMenuItem> listSemester = const [
    DropdownMenuItem<String>(
      value: 'ganjil',
      child: Text('ganjil'),
    ),
    DropdownMenuItem<String>(
      value: 'genap',
      child: Text('genap'),
    ),
  ];

  TextEditingController tahunAkademik = TextEditingController();
  // TextEditingController tahunAkademik2 = TextEditingController();
  TextEditingController semester = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> listTahunAkademik = [
      DropdownMenuItem<String>(
        value: '${currentYear - 1}/$currentYear',
        child: Text('${currentYear - 1}/$currentYear'),
      ),
      DropdownMenuItem<String>(
        value: '$currentYear/${currentYear + 1}',
        child: Text('$currentYear/${currentYear + 1}'),
      ),
    ];

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semester: ${widget.krsSchedule.semester}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tahun Akademik Berjalan: ${widget.krsSchedule.tahunAkademik}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Semester'),
              // WebFormField(
              //   hintText: 'Semester...',
              //   controller: semester,
              // ),

              DropdownButton(
                isExpanded: true,
                hint: const Text('Input Semester...'),
                value: (semester.text == '') ? valueSmt : semester.text,
                onChanged: (value) {
                  setState(() {
                    semester.text = value;
                  });
                },
                items: listSemester,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Tahun Akademik'),
              // SizedBox(
              //   width: 80,
              //   child: WebFormField(
              //     hintText: '...',
              //     controller: tahunAkademik,
              //   ),
              // ),
              DropdownButton(
                isExpanded: true,
                hint: const Text('Input Tahun Akademik...'),
                value:
                    (tahunAkademik.text == '') ? valueTA : tahunAkademik.text,
                onChanged: (value) {
                  setState(() {
                    tahunAkademik.text = value;
                  });
                },
                items: listTahunAkademik,
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
                          context.read<TahunAkademikBloc>().add(
                                SetTahunAkademik(
                                  tahunAkademik: tahunAkademik.text,
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
