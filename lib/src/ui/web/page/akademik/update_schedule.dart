import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/bloc/schedule_management/schedule_management_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/new_schedule.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/custom_text_form_field.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/day_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/dosen_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/room_choice.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateSchedulePage extends StatefulWidget {
  final KrsSchedule krsSchedule;
  final Schedule schedule;

  const UpdateSchedulePage({
    super.key,
    required this.schedule,
    required this.krsSchedule,
  });

  @override
  State<UpdateSchedulePage> createState() => _UpdateSchedulePageState();
}

class _UpdateSchedulePageState extends State<UpdateSchedulePage> {
  final formKey = GlobalKey<FormState>();

  TextStyle textStyle = const TextStyle(fontSize: 13);

  TextEditingController idDosen = TextEditingController();
  TextEditingController waktuMulai = TextEditingController();
  TextEditingController waktuSelesai = TextEditingController();
  TextEditingController hari = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController ruangan = TextEditingController();

  @override
  void initState() {
    super.initState();
    idDosen.text = widget.schedule.lecturerId;
    waktuMulai.text = widget.schedule.startsAt;
    waktuSelesai.text = widget.schedule.endsAt;
    hari.text = widget.schedule.day;
    keterangan.text = widget.schedule.information;
    ruangan.text = widget.schedule.room;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Text(
                        widget.schedule.learningSubName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Dosen',
                        style: textStyle,
                      ),
                      DosenChoice(dosenId: idDosen),
                      const SizedBox(
                        height: 10,
                      ),
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
                      Text(
                        'Hari',
                        style: textStyle,
                      ),
                      DayChoice(hari: hari),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ruangan',
                        style: textStyle,
                      ),
                      RoomChoice(ruangan: ruangan),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Keterangan',
                        style: textStyle,
                      ),
                      CustomTextFormField(
                        hintText: 'Keterangan...',
                        controller: keterangan,
                        validator: (value) {
                          if (value == '') {
                            return 'Field keterangan belum terisi!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocListener<ScheduleManagementBloc,
                          ScheduleManagementState>(
                        listener: (context, state) {
                          if (state is ScheduleUpdated) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Info'),
                                  content: const Text('Update berhasil.'),
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
                          } else if (state is ScheduleUpdateFailed) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Update Jadwal'),
                                  content: const Text('Update gagal.'),
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
                        child: SizedBox(
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
                                      UpdateSchedule(
                                        newSchedule: NewSchedule(
                                          id: widget.schedule.id,
                                          learningSubId:
                                              widget.schedule.learningSubId,
                                          lecturerId: idDosen.text,
                                          startsAt: waktuMulai.text,
                                          endsAt: waktuSelesai.text,
                                          day: hari.text,
                                          room: ruangan.text,
                                          information: keterangan.text,
                                          tahunAkademik:
                                              widget.krsSchedule.tahunAkademik,
                                          semester: widget.krsSchedule.semester,
                                        ),
                                      ),
                                    );
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
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
                    ],
                  ),
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
    waktuMulai.dispose();
    waktuSelesai.dispose();
    keterangan.dispose();
    hari.dispose();
    ruangan.dispose();
  }
}
