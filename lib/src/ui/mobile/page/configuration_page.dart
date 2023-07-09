import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/administrator.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/about_us_page.dart';
import 'package:academic_system/src/ui/mobile/page/login_page.dart';
import 'package:academic_system/src/ui/mobile/page/visi_misi_page.dart';
import 'package:flutter/material.dart';

class MobileConfigurationPage extends StatelessWidget {
  final User user;
  const MobileConfigurationPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              color: const Color.fromARGB(255, 0, 32, 96),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/img/avatar/default-avatar.jpg'),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              user is Student
                                  ? (user as Student).name
                                  : user is Academic
                                      ? (user as Academic).name
                                      : user is Lecturer
                                          ? (user as Lecturer).name
                                          : user is Administrator
                                              ? (user as Administrator).name
                                              : '',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            user is Administrator
                                ? 'Tata Usaha'
                                : '${user.role[0].toUpperCase()}${user.role.substring(1)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            user.id,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text(
                      'Pengaturan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SettingChoice(
                    iconData: Icons.wb_incandescent_outlined,
                    text: 'Visi Misi',
                    rotateIcon: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VisiMisiPage(),
                        ),
                      );
                    },
                  ),
                  SettingChoice(
                    iconData: Icons.info_outlined,
                    text: 'Tentang Kami',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsPage(),
                        ),
                      );
                    },
                  ),
                  SettingChoice(
                    iconData: Icons.exit_to_app_rounded,
                    text: 'Logout',
                    iconColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'Konfirmasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 32, 96),
                            ),
                          ),
                          content: const Text('Apakah anda ingin logout akun?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                SecureStorage.deleteToken('jwt');
                                SecureStorage.deleteToken('refreshToken');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MobileLoginPage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 32, 96),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const AppVersion(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppVersion extends StatelessWidget {
  const AppVersion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: const [
          Icon(
            Icons.phone_android_sharp,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Versi 1.0.0',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingChoice extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool rotateIcon;
  final Color iconColor;
  final Function() onTap;
  const SettingChoice({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.rotateIcon = false,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            rotateIcon
                ? RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      iconData,
                      color: iconColor,
                    ),
                  )
                : Icon(
                    iconData,
                    color: iconColor,
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
