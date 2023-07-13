import 'package:academic_system/src/model/administrator.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:flutter/material.dart';

class WebHomePage extends StatelessWidget {
  final User user;

  const WebHomePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BerandaHeader(user: user),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 177, 214, 244),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/img/about_us/pendaftaranbaru.jpg'),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: Color.fromARGB(55, 0, 0, 0),
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Visi & Misi STMIK Dharma Putra',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'VISI',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '“Menjadi Pemimpin terdepan di Bidang Teknologi Informasi Tahun 2030”',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'MISI',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '1. Menyelenggarakan Program Studi yang menunjang pengembangan dan menghasilkan lulusan yang berkualitas dan berorientasi kepada kebutuhan masyarakat pengguna lulusan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '2. Mengembangkan Sumber Daya Manusia yang mempunyai kompetensi di Bidang Teknologi melalui pelatihan dan mendorong para dosen untuk melanjutkan pendidikan ke jenjang yang lebih tinggi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '3. Membentuk dan mencetak sumber daya manusia yang beretika, berbudaya dan mempunyai nilai-nilai kejujuran, disiplin serta bertanggung jawab terhadap masyarakat dan lingkungan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '4. Melaksanakan Tri Dharma Perguruan Tinggi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '5. Menjalin hubungan kerjasama antar Perguruan Tinggi, Instansi Pemerintahan, Industri dan Masyarakat dalam meningkatkan serta mewujudkan Tri Dharma Perguruan Tinggi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Artikel',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      ArticleCard(
                        title: 'Apa Itu Program Studi Sistem Informasi?',
                        imgPath: 'assets/img/article/si.jpg',
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ArticleCard(
                        title: 'Apa Itu Program Studi Teknik Informatika?',
                        imgPath: 'assets/img/article/ti.jpg',
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ArticleCard(
                        title:
                            'Ini Dia List Bahasa Pemrograman Yang Sedang Tren!',
                        imgPath: 'assets/img/article/eb.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String imgPath;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgPath),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 2),
                color: Color.fromARGB(59, 0, 0, 0),
              ),
            ],
          ),
          child: Material(
            color: const Color.fromARGB(190, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BerandaHeader extends StatelessWidget {
  const BerandaHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            'STMIK Dharma Putra',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IdentityWidget(user: user),
      ],
    );
  }
}

class IdentityWidget extends StatelessWidget {
  const IdentityWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  String getFirstName(User user) {
    return user.name.split(' ')[0].replaceAll(",", "");
  }

  String getRole(User user) {
    if (user is Administrator) {
      return 'Tata Usaha';
    }
    return '${user.role[0].toUpperCase()}${user.role.substring(1).toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                user.id,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                getRole(user),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 224, 224),
              image: const DecorationImage(
                image: AssetImage('assets/img/avatar/default-avatar.jpg'),
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
