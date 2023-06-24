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
                  // validator: validator,
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
                  // validator: validator,
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
                child: Center(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 53, 230, 112)),
                      ),
                      onPressed: () {
                        context.read<ScheduleKrsBloc>().add(
                              UpdateScheduleKrs(
                                  tanggalMulai: tanggalMulai.text,
                                  tanggalSelesai: tanggalSelesai.text),
                            );
                        Navigator.pop(context);
                      },
                      child: const Text('Set Jadwal KRS'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 45,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
