import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/schedule_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchedulePage(user: user),
                    ),
                  );
                },
                child: const Text('Jadwal'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('KHS'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('KRS'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Pembayaran'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Transkrip Nilai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
