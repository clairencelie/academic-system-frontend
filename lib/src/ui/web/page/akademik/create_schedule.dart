import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/bloc/schedule_management/schedule_management_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/new_schedule.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/day_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/dosen_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/mata_kuliah_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/room_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSchedulePage extends StatefulWidget {
  final KrsSchedule krsSchedule;
  const CreateSchedulePage({
    super.key,
    required this.krsSchedule,
  });

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  final formKey = GlobalKey<FormState>();

  TextStyle textStyle = const TextStyle(fontSize: 14);

  TextEditingController idDosen = TextEditingController();
  TextEditingController idMK = TextEditingController();
  TextEditingController waktuMulai = TextEditingController();
  TextEditingController waktuSelesai = TextEditingController();
  TextEditingController hari = TextEditingController();
  TextEditingController ruangan = TextEditingController();

  void callback(String idDosen) {
    setState(() {
      this.idDosen.text = idDosen;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const Text(
                              'Tambah Jadwal',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'T.A ${widget.krsSchedule.semester[0].toUpperCase()}${widget.krsSchedule.semester.substring(1)} - ${widget.krsSchedule.tahunAkademik}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Pilihan mata kuliah.
                    Text(
                      'Mata Kuliah',
                      style: textStyle,
                    ),
                    // Diganti MataKuliahChoice()
                    MataKuliahChoice(
                      callback: callback,
                      idMK: idMK,
                      idDosen: idDosen,
                      krsSchedule: widget.krsSchedule,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Pilihan dosen.
                    Text(
                      'Dosen',
                      style: textStyle,
                    ),
                    DosenChoice(dosenId: idDosen),
                    const SizedBox(
                      height: 10,
                    ),
                    // Pilihan waktu.
                    Text(
                      'Waktu',
                      style: textStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimeField(
                          validator: (value) {
                            if (value == '') {
                              return 'Field waktu mulai belum terisi!';
                            }
                            return null;
                          },
                          hintText: 'Mulai',
                          controller: waktuMulai,
                        ),
                        const Text('   -   '),
                        TimeField(
                          validator: (value) {
                            if (value == '') {
                              return 'Field waktu selesai belum terisi!';
                            }
                            return null;
                          },
                          hintText: 'Selesai',
                          controller: waktuSelesai,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Hari
                    Text(
                      'Hari',
                      style: textStyle,
                    ),
                    DayChoice(hari: hari),
                    const SizedBox(
                      height: 10,
                    ),
                    // Ruangan
                    Text(
                      'Ruangan',
                      style: textStyle,
                    ),
                    RoomChoice(ruangan: ruangan),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Batal'),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 100,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 53, 230, 112)),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<ScheduleManagementBloc>().add(
                                      CreateSchedule(
                                        newSchedule: NewSchedule(
                                          learningSubId: idMK.text,
                                          lecturerId: idDosen.text,
                                          startsAt: waktuMulai.text,
                                          endsAt: waktuSelesai.text,
                                          day: hari.text,
                                          room: ruangan.text,
                                          information: 'masuk',
                                          tahunAkademik:
                                              widget.krsSchedule.tahunAkademik,
                                          semester: widget.krsSchedule.semester,
                                        ),
                                      ),
                                    );
                              }
                            },
                            child: const Text('Tambah'),
                          ),
                        ),
                      ],
                    ),

                    BlocListener<ScheduleManagementBloc,
                        ScheduleManagementState>(
                      listener: (context, state) {
                        if (state is NewScheduleCreated) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Info'),
                                content:
                                    const Text('Jadwal berhasil ditambahkan.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      context
                                          .read<ScheduleBloc>()
                                          .add(RequestAllSchedule(
                                            tahunAkademik: widget
                                                .krsSchedule.tahunAkademik,
                                            semester:
                                                widget.krsSchedule.semester,
                                          ));
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (state is ScheduleFailed) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Info'),
                                content:
                                    const Text('Jadwal gagal ditambahkan.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    idDosen.dispose();
    idMK.dispose();
    waktuMulai.dispose();
    waktuSelesai.dispose();
    hari.dispose();
    ruangan.dispose();
  }
}
