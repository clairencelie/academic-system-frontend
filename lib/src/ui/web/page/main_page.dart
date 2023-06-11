// import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/academic.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/cms.dart';
import 'package:academic_system/src/ui/web/page/configuration_page.dart';
import 'package:academic_system/src/ui/web/page/home_page.dart';
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
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      WebHomePage(user: widget.user),
      WebSchedulePage(user: widget.user),
      WebProfilePage(user: widget.user),
      WebConfigurationPage(user: widget.user),
    ];

    List<Widget> academicOptions = <Widget>[
      WebHomePage(user: widget.user),
      WebSchedulePage(user: widget.user),
      WebProfilePage(user: widget.user),
      WebConfigurationPage(user: widget.user),
      const CMSPage(),
    ];

    const List<NavigationRailDestination> normalUser = [
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
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
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
            destinations:
                widget.user is Academic ? academicNavigation : normalUser,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: widget.user is Academic
                ? academicOptions[_selectedIndex]
                : widgetOptions[_selectedIndex],
          )
        ],
      ),
    );
  }
}
