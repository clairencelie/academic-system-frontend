import 'package:academic_system/src/model/administrator.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:flutter/material.dart';

class IdentityCard extends StatelessWidget {
  final User user;

  const IdentityCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 32, 96),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Color.fromARGB(55, 0, 0, 0),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 224, 224),
              image: const DecorationImage(
                image: AssetImage('assets/img/avatar/default-avatar.jpg'),
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 230,
                child: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                user.id,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                user is Administrator
                    ? 'Tata Usaha'
                    : '${user.role[0].toUpperCase()}${user.role.substring(1)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
