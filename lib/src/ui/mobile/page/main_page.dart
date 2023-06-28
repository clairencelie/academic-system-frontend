import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/configuration_page.dart';
import 'package:academic_system/src/ui/mobile/page/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({
    super.key,
    required this.user,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> passiveUserBarItem = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Beranda',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Pengaturan',
      ),
    ];

    List<Widget> widgetOptions = <Widget>[
      HomePage(
        user: widget.user,
      ),
      MobileConfigurationPage(
        user: widget.user,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          unselectedFontSize: 10,
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(255, 136, 136, 136),
          items: passiveUserBarItem,
          selectedFontSize: 10,
          selectedItemColor: const Color.fromARGB(255, 0, 32, 96),
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
