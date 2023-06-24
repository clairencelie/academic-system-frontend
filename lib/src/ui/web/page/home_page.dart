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
                    color: const Color.fromARGB(255, 177, 214, 244),
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 100,
                    color: const Color.fromARGB(255, 218, 177, 244),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 100,
                    color: const Color.fromARGB(255, 177, 244, 198),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 100,
                    color: const Color.fromARGB(255, 244, 213, 177),
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
            // DateTime.now().hour < 11
            //     ? "Selamat pagi, ${user.name}"
            //     : DateTime.now().hour < 15
            //         ? 'Selamat siang, ${user.name}'
            //         : DateTime.now().hour < 18
            //             ? 'Selamat sore, ${user.name}'
            //             : 'Selamat malam, ${user.name}',
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
                getFirstName(user),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                user.id,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
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
            width: 10,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 224, 224),
              image: const DecorationImage(
                image: AssetImage('img/avatar/default-avatar.jpg'),
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
