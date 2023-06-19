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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Selamat malam, ${user.name}",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IdentityWidget(user: user)
              ],
            ),
          ],
        ),
      ),
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
