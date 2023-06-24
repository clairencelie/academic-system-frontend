// import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/akademik/cms.dart';
import 'package:academic_system/src/ui/web/page/configuration_page.dart';
import 'package:academic_system/src/ui/web/page/dosen/dpmk.dart';
import 'package:academic_system/src/ui/web/page/home_page.dart';
import 'package:academic_system/src/ui/web/page/krs_web.dart';
import 'package:academic_system/src/ui/web/page/mahasiswa/tagihan_pembayaran.dart';
import 'package:academic_system/src/ui/web/page/mahasiswa/transkrip_page.dart';
import 'package:academic_system/src/ui/web/page/profile_page.dart';
import 'package:academic_system/src/ui/web/page/schedule_page.dart';
import 'package:flutter/material.dart';

class WebMainPage extends StatefulWidget {
  final User user;
  const WebMainPage({
    super.key,
    required this.user,
  });

  @override
  State<WebMainPage> createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    List<Widget> studentOptions = <Widget>[
      WebHomePage(user: widget.user),
      WebSchedulePage(user: widget.user),
      TranskripPage(mahasiswa: widget.user),
      KRSWebPage(user: widget.user),
      TagihanPembayaran(user: widget.user),
      WebProfilePage(user: widget.user),
      WebConfigurationPage(user: widget.user),
    ];

    List<Widget> lecturerOptions = <Widget>[
      WebHomePage(user: widget.user),
      DPMKPage(dosen: widget.user),
      WebSchedulePage(user: widget.user),
      WebProfilePage(user: widget.user),
      WebConfigurationPage(user: widget.user),
    ];

    List<Widget> academicOptions = <Widget>[
      WebHomePage(user: widget.user),
      WebSchedulePage(user: widget.user),
      WebProfilePage(user: widget.user),
      const CMSPage(),
      WebConfigurationPage(user: widget.user),
    ];

    const List<NavigationRailDestination> studentNavigation = [
      NavigationRailDestination(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.home,
          color: Colors.yellow,
        ),
        label: Text(
          'Beranda',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.schedule,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.schedule,
          color: Colors.yellow,
        ),
        label: Text(
          'Jadwal',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.grade_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.grade,
          color: Colors.yellow,
        ),
        label: Text(
          'Transkrip',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.difference_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.difference_rounded,
          color: Colors.yellow,
        ),
        label: Text(
          'KRS',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.payment,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.payment,
          color: Colors.yellow,
        ),
        label: Text(
          'Tagihan',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.person,
          color: Colors.yellow,
        ),
        label: Text(
          'Profil',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.settings_applications_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.settings_applications_rounded,
          color: Colors.yellow,
        ),
        label: Text(
          'Pengaturan',
        ),
      ),
    ];

    const List<NavigationRailDestination> lecturerNavigation = [
      NavigationRailDestination(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.home,
          color: Colors.yellow,
        ),
        label: Text(
          'Beranda',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.people_alt_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.people_alt_rounded,
          color: Colors.yellow,
        ),
        label: Text(
          'DPMK',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.schedule,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.schedule,
          color: Colors.yellow,
        ),
        label: Text(
          'Jadwal',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.person,
          color: Colors.yellow,
        ),
        label: Text(
          'Profil',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.settings_applications_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.settings_applications_rounded,
          color: Colors.yellow,
        ),
        label: Text(
          'Pengaturan',
        ),
      ),
    ];

    const List<NavigationRailDestination> academicNavigation = [
      NavigationRailDestination(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.home,
          color: Colors.yellow,
        ),
        label: Text(
          'Beranda',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.schedule,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.schedule,
          color: Colors.yellow,
        ),
        label: Text(
          'Jadwal',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.person,
          color: Colors.yellow,
        ),
        label: Text(
          'Profil',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.edit_calendar_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.edit_calendar_rounded,
          color: Colors.yellow,
        ),
        label: Text(
          'CMS',
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.settings_applications_outlined,
          color: Colors.white,
        ),
        selectedIcon: Icon(
          Icons.settings_applications_rounded,
          color: Colors.yellow,
        ),
        label: Text(
          'Pengaturan',
        ),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                  image: AssetImage('img/logo/logo_nav_web.png'),
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 1,
                    color: Color.fromARGB(55, 0, 0, 0),
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            unselectedLabelTextStyle: const TextStyle(
              color: Colors.white,
            ),
            selectedLabelTextStyle: const TextStyle(
              color: Colors.amber,
            ),
            backgroundColor: const Color.fromARGB(255, 0, 32, 96),
            destinations: widget.user is Academic
                ? academicNavigation
                : widget.user is Student
                    ? studentNavigation
                    : lecturerNavigation,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: widget.user is Academic
                ? academicOptions[_selectedIndex]
                : widget.user is Student
                    ? studentOptions[_selectedIndex]
                    : lecturerOptions[_selectedIndex],
          )
        ],
      ),
    );
  }
}
