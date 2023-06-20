import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/web_form_field.dart';
import 'package:flutter/material.dart';

class FormNilai extends StatefulWidget {
  final NilaiMahasiswa nilaiMahasiswa;
  final String namaMataKuliah;
  const FormNilai({
    super.key,
    required this.nilaiMahasiswa,
    required this.namaMataKuliah,
  });

  @override
  State<FormNilai> createState() => _FormNilaiState();
}

class _FormNilaiState extends State<FormNilai> {
  final formKey = GlobalKey<FormState>();

  TextEditingController kehadiran = TextEditingController();
  TextEditingController tugas = TextEditingController();
  TextEditingController uts = TextEditingController();
  TextEditingController uas = TextEditingController();

  RegExp numberAfterZeroRegex = RegExp(r'^0$|^[1-9][0-9]*$');

  @override
  void initState() {
    super.initState();
    kehadiran.text = widget.nilaiMahasiswa.kehadiran.toString();
    tugas.text = widget.nilaiMahasiswa.tugas.toString();
    uts.text = widget.nilaiMahasiswa.uts.toString();
    uas.text = widget.nilaiMahasiswa.uas.toString();
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
              const Text(
                'Form Nilai',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.namaMataKuliah,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Nama : ${widget.nilaiMahasiswa.nama}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'NIM : ${widget.nilaiMahasiswa.nim}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kehadiran'),
                    WebFormField(
                      hintText: 'Kehadiran',
                      controller: kehadiran,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nilai kehadiran belum diisi!';
                        } else if (int.tryParse(value) is! int) {
                          return 'Nilai tidak boleh berisi huruf!';
                        } else if (!numberAfterZeroRegex.hasMatch(value)) {
                          return 'Tidak boleh ada angka lain dibelakang 0';
                        } else if (int.tryParse(value)! < 0) {
                          return 'Nilai tidak boleh lebih kecil dari 0!';
                        } else if (int.tryParse(value)! > 100) {
                          return 'Nilai tidak boleh lebih besar dari 100!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Tugas'),
                    WebFormField(
                      hintText: 'Tugas',
                      controller: tugas,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nilai tugas belum diisi!';
                        } else if (int.tryParse(value) is! int) {
                          return 'Nilai tidak boleh berisi huruf!';
                        } else if (!numberAfterZeroRegex.hasMatch(value)) {
                          return 'Tidak boleh ada angka lain dibelakang 0';
                        } else if (int.tryParse(value)! < 0) {
                          return 'Nilai tidak boleh lebih kecil dari 0!';
                        } else if (int.tryParse(value)! > 100) {
                          return 'Nilai tidak boleh lebih besar dari 100!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('UTS'),
                    WebFormField(
                      hintText: 'UTS',
                      controller: uts,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nilai UTS belum diisi!';
                        } else if (int.tryParse(value) is! int) {
                          return 'Nilai tidak boleh berisi huruf!';
                        } else if (!numberAfterZeroRegex.hasMatch(value)) {
                          return 'Tidak boleh ada angka lain dibelakang 0';
                        } else if (int.tryParse(value)! < 0) {
                          return 'Nilai tidak boleh lebih kecil dari 0!';
                        } else if (int.tryParse(value)! > 100) {
                          return 'Nilai tidak boleh lebih besar dari 100!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('UAS'),
                    WebFormField(
                      hintText: 'UAS',
                      controller: uas,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nilai UAS belum diisi!';
                        } else if (int.tryParse(value) is! int) {
                          return 'Nilai tidak boleh berisi huruf!';
                        } else if (!numberAfterZeroRegex.hasMatch(value)) {
                          return 'Tidak boleh ada angka lain dibelakang 0';
                        } else if (int.tryParse(value)! < 0) {
                          return 'Nilai tidak boleh lebih kecil dari 0!';
                        } else if (int.tryParse(value)! > 100) {
                          return 'Nilai tidak boleh lebih besar dari 100!';
                        } else {
                          return null;
                        }
                      },
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
                          width: 20,
                        ),
                        SizedBox(
                          height: 45,
                          width: 100,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 53, 230, 112)),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print(kehadiran.text);
                                print(tugas.text);
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormNilaiHeader extends StatelessWidget {
  const FormNilaiHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            // context.read<DosenBloc>().add(
            //       GetMatkulDosen(idDosen: idDosen),
            //     );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Form Nilai',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
