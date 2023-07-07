import 'package:flutter/material.dart';

class CMSItem extends StatelessWidget {
  final String title;
  final IconData icons;
  final double width;
  final double height;
  final Function()? onTap;
  final Color? color;
  final Color? contentColor;
  final double? fontSize;
  final double? iconSize;

  const CMSItem({
    Key? key,
    required this.title,
    required this.icons,
    required this.onTap,
    this.width = 70,
    this.height = 70,
    this.color = const Color.fromARGB(255, 248, 250, 252),
    this.contentColor = const Color.fromARGB(255, 0, 32, 96),
    this.fontSize = 11,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        color: color,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashFactory: NoSplash.splashFactory,
          overlayColor: const MaterialStatePropertyAll(
            Color.fromARGB(255, 234, 239, 241),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icons,
                  color: contentColor,
                  size: iconSize,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: contentColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
