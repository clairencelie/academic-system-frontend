import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Widget page;
  final Color color;
  final String title;

  const FeatureCard({
    Key? key,
    required this.page,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        width: 60,
        height: 60,
        color: color,
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
