import 'package:academic_system/src/constant/colors.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/administrator.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/login_page.dart';
import 'package:flutter/material.dart';

class WebConfigurationPage extends StatelessWidget {
  final User user;

  const WebConfigurationPage({
    super.key,
    required this.user,
  });

  final TextStyle titleStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  final TextStyle valueStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: const Color.fromARGB(255, 172, 172, 172),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 224, 224, 224),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/img/avatar/default-avatar.jpg'),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${user.role[0].toUpperCase()}${user.role.substring(1)}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Informasi Personal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama',
                                  style: titleStyle,
                                ),
                                Text(
                                  user.name,
                                  style: valueStyle,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user is Student ? 'NIM' : 'NIP',
                                  style: titleStyle,
                                ),
                                Text(
                                  user.id,
                                  style: valueStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PersonDetail(
                        user: user,
                        titleStyle: titleStyle,
                        valueStyle: valueStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => mainColor),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Konfirmasi',
                                style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content:
                                  const Text('Apakah anda yakin ingin logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Batal',
                                    style: TextStyle(color: mainColor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    SecureStorage.deleteToken('jwt');
                                    SecureStorage.deleteToken('refreshToken');
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WebLoginPage(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    'Keluar',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

class PersonDetail extends StatelessWidget {
  final TextStyle titleStyle;
  final TextStyle valueStyle;
  const PersonDetail({
    Key? key,
    required this.user,
    required this.titleStyle,
    required this.valueStyle,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user is Student) {
      Student mahasiswa = user as Student;
      return InformasiMhs(
        mahasiswa: mahasiswa,
        titleStyle: titleStyle,
        valueStyle: valueStyle,
      );
    } else if (user is Lecturer) {
      Lecturer dosen = user as Lecturer;
      return InformasiDosen(
          titleStyle: titleStyle, dosen: dosen, valueStyle: valueStyle);
    } else if (user is Academic) {
      Academic akademik = user as Academic;
      return InformasiAkademik(
          titleStyle: titleStyle, akademik: akademik, valueStyle: valueStyle);
    } else if (user is Administrator) {
      Administrator admin = user as Administrator;
      return InformasiTataUsaha(
          titleStyle: titleStyle, tataUsaha: admin, valueStyle: valueStyle);
    }
    return const SizedBox();
  }
}

class InformasiAkademik extends StatelessWidget {
  const InformasiAkademik({
    Key? key,
    required this.titleStyle,
    required this.akademik,
    required this.valueStyle,
  }) : super(key: key);

  final TextStyle titleStyle;
  final Academic akademik;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat',
                    style: titleStyle,
                  ),
                  Text(
                    akademik.address,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Telp',
                    style: titleStyle,
                  ),
                  Text(
                    akademik.phoneNumber,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: titleStyle,
                ),
                Text(
                  akademik.email,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: titleStyle,
                ),
                Text(
                  akademik.status,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class InformasiMhs extends StatelessWidget {
  const InformasiMhs({
    Key? key,
    required this.mahasiswa,
    required this.titleStyle,
    required this.valueStyle,
  }) : super(key: key);

  final Student mahasiswa;
  final TextStyle titleStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jurusan',
                    style: titleStyle,
                  ),
                  Text(
                    mahasiswa.major,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semester',
                    style: titleStyle,
                  ),
                  Text(
                    mahasiswa.semester,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat',
                    style: titleStyle,
                  ),
                  Text(
                    mahasiswa.address,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Telp',
                    style: titleStyle,
                  ),
                  Text(
                    mahasiswa.phoneNumber,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Angkatan',
                    style: titleStyle,
                  ),
                  Text(
                    mahasiswa.batchOf,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: titleStyle,
                  ),
                  Text(
                    mahasiswa.status,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: titleStyle,
                ),
                Text(
                  mahasiswa.email,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class InformasiDosen extends StatelessWidget {
  const InformasiDosen({
    Key? key,
    required this.titleStyle,
    required this.dosen,
    required this.valueStyle,
  }) : super(key: key);

  final TextStyle titleStyle;
  final Lecturer dosen;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat',
                    style: titleStyle,
                  ),
                  Text(
                    dosen.address,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Telp',
                    style: titleStyle,
                  ),
                  Text(
                    dosen.phoneNumber,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: titleStyle,
                ),
                Text(
                  dosen.email,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: titleStyle,
                ),
                Text(
                  dosen.status,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class InformasiTataUsaha extends StatelessWidget {
  const InformasiTataUsaha({
    Key? key,
    required this.titleStyle,
    required this.tataUsaha,
    required this.valueStyle,
  }) : super(key: key);

  final TextStyle titleStyle;
  final Administrator tataUsaha;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat',
                    style: titleStyle,
                  ),
                  Text(
                    tataUsaha.address,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Telp',
                    style: titleStyle,
                  ),
                  Text(
                    tataUsaha.phoneNumber,
                    style: valueStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: titleStyle,
                ),
                Text(
                  tataUsaha.email,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: titleStyle,
                ),
                Text(
                  tataUsaha.status,
                  style: valueStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
