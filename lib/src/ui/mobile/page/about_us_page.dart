import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AboutUsTitle(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/about_us/gedung.jpg'),
                    ),
                  ),
                ),
                const Text(
                  'Pada tahun 1979 beberapa pemerhati pendidikan bertemu dan membentuk suatu Yayasan Pendidikan yang bernama "Yayasan Pendidikan Dharmaputra" berlokasi di Jl. Otto Iskandardinata 80Tangerang. Tujuan serta tugas pokok Yayasan Pendidikan Dharmaputra tetap konsisten dengan gagasan dasar yaitu untuk mengupayakan peningkatan kualitas sumber daya manusia dan pemberdayaan sumber data di wilayah Kodya Tangerang.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  'Berkembangnya "Yayasan Pendidikan Dharmaputra" dimulai dengan mendirikan Taman Kanak-Kanak (TK), Sekolah Dasar (SD), Sekolah Lanjutan Tingkat Pertama (SLTP), Sekolah Menengah Umun (SMU), dan Sekolah Tinggi Manajemen Informatika dan Komputer (STMIK). Upaya peningkatan kualitas di- bidang pendidikan telah dilakukan dengan penyelenggaraan Pendidikan.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  'Untuk memenuhi kebutuhan masa depan para profesional di bidang Teknologi Informasi yaitu komputer, STMIK Dharma Putra secara resmi dibuka pada tanggal 13 Maret 2003. Berdasarkan SK No: 29/D/0/2003 yang diharapkan dapat memberikan profesional komputasi yang berwawasan luas. Dengan pengetahuan yang memadai tentang Ilmu Komputer dan Teknologi Informasi yang dibutuhkan dalam komunitas pengguna yang berkembang pesat. Selain itu, keterampilan dan pengetahuan yang diperoleh dalam program komputasi ini akan membantu mereka memperluas pilihan karir mereka.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  'STMIK Dharma Putra memungkinkan mahasiswanya memperoleh kompetensi sehingga lulusannya mampu berperan serta dalam mendukung keberhasilan pembangunan nasional khususnya sumber daya manusia di Tangerang. STMIK Dharma Putra memiliki 2 (dua) program studi, yaitu Sistem informasi dan Teknik Informatika.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutUsTitle extends StatelessWidget {
  const AboutUsTitle({
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
              'Tentang Kami',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
