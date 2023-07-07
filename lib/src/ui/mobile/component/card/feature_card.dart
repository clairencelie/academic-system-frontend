import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Widget page;
  final Color color;
  final IconData icon;
  final String title;

  const FeatureCard({
    Key? key,
    required this.page,
    required this.color,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 248, 250, 252),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Color.fromARGB(59, 0, 0, 0),
          ),
        ],
      ),
      child: Material(
        color: const Color.fromARGB(255, 248, 250, 252),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashFactory: NoSplash.splashFactory,
          overlayColor: const MaterialStatePropertyAll(
            Color.fromARGB(255, 234, 239, 241),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color.fromARGB(255, 0, 32, 96),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 32, 96),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
