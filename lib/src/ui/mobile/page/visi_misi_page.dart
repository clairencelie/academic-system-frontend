import 'package:flutter/material.dart';

class VisiMisiPage extends StatelessWidget {
  const VisiMisiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 32, 96),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VisiMisiTitle(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/img/visi_misi/logo.png'),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(141, 248, 224, 4),
                        blurRadius: 40,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const Text(
                  'VISI',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  '“Menjadi Pemimpin terdepan di Bidang Teknologi Informasi Tahun 2030”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'MISI',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  '1.	Menyelenggarakan Program Studi yang menunjang pengembangan dan menghasilkan lulusan yang berkualitas dan berorientasi kepada kebutuhan masyarakat pengguna lulusan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  '2.	Mengembangkan Sumber Daya Manusia yang mempunyai kompetensi di Bidang Teknologi melalui pelatihan dan mendorong para dosen untuk melanjutkan pendidikan ke jenjang yang lebih tinggi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  '3.	Membentuk dan mencetak sumber daya manusia yang beretika, berbudaya dan mempunyai nilai-nilai kejujuran, disiplin serta bertanggung jawab terhadap masyarakat dan lingkungan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  '4.	Melaksanakan Tri Dharma Perguruan Tinggi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  '5.	Menjalin hubungan kerjasama antar Perguruan Tinggi, Instansi Pemerintahan, Industri dan Masyarakat dalam meningkatkan serta mewujudkan Tri Dharma Perguruan Tinggi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VisiMisiTitle extends StatelessWidget {
  const VisiMisiTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        // Title
        const Center(
          child: SizedBox(
            width: 240,
            child: Text(
              'VISI & MISI\nSTMIK Dharma Putra',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
