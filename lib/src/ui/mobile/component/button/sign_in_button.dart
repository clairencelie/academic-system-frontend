import 'package:flutter/material.dart';

class MobileSignInButton extends StatelessWidget {
  final Function() onTap;

  const MobileSignInButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 0, 32, 96),
        ),
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(25),
            child: const Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
