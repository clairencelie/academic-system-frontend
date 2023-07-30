import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormJadwalKrs extends StatefulWidget {
  const FormJadwalKrs({super.key});

  @override
  State<FormJadwalKrs> createState() => _FormJadwalKrsState();
}

class _FormJadwalKrsState extends State<FormJadwalKrs> {
  final formKey = GlobalKey<FormState>();

  DateTime dateMulai = DateTime.now();
  DateTime dateSelesai = DateTime.now();

  TextEditingController tanggalMulai = TextEditingController();
  TextEditingController tanggalSelesai = TextEditingController();
  TextEditingController semester = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Set Jadwal KRS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Tanggal Mulai'),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal Mulai Belum Terisi!';
                      } else {
                        return null;
                      }
                    },
                    controller: tanggalMulai,
                    cursorColor: const Color.fromARGB(255, 0, 32, 96),
                    onTap: () async {
                      final newDate = await showDatePicker(
                          context: context,
                          initialDate: dateMulai,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2025));

                      if (newDate == null) return;

                      setState(() {
                        dateMulai = newDate;
                        tanggalMulai.text =
                            '${dateMulai.day}-${dateMulai.month}-${dateMulai.year}';
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Tanggal Mulai...',
                      errorStyle: TextStyle(
                        height: 0.7,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(55, 112, 112, 112),
                        ),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(55, 112, 112, 112),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Tanggal Selesai'),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal Selesai Belum Terisi!';
                      } else {
                        return null;
                      }
                    },
                    controller: tanggalSelesai,
                    cursorColor: const Color.fromARGB(255, 0, 32, 96),
                    onTap: () async {
                      final newDate = await showDatePicker(
                          context: context,
                          initialDate: dateSelesai,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2025));

                      if (newDate == null) return;

                      setState(() {
                        dateSelesai = newDate;
                        tanggalSelesai.text =
                            '${dateSelesai.day}-${dateSelesai.month}-${dateSelesai.year}';
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Tanggal Selesai...',
                      errorStyle: TextStyle(
                        height: 0.7,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(55, 112, 112, 112),
                        ),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(55, 112, 112, 112),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<ScheduleKrsBloc, ScheduleKrsState>(
                  listener: (context, state) {
                    if (state is ScheduleKrsUpdateSuccess) {
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

                              context
                                  .read<ScheduleKrsBloc>()
                                  .add(GetScheduleKrs());
                            },
                          );
                        },
                      );
                    } else if (state is ScheduleKrsUpdateFailed) {
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
                    } else if (state is ScheduleKrsLoading) {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 193, 47, 47)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Batal'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 53, 230, 112)),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<ScheduleKrsBloc>().add(
                                    UpdateScheduleKrs(
                                        tanggalMulai: tanggalMulai.text,
                                        tanggalSelesai: tanggalSelesai.text),
                                  );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Set Jadwal KRS'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
