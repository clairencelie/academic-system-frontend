import 'package:flutter/material.dart';
import 'dart:async';

class MobileTimerVA extends StatefulWidget {
  final int targetUnixTime;

  const MobileTimerVA({super.key, required this.targetUnixTime});

  @override
  MobileTimerVAState createState() => MobileTimerVAState();
}

class MobileTimerVAState extends State<MobileTimerVA> {
  Timer? countdownTimer;
  Duration countdownDuration = const Duration();
  bool isCountdownComplete = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    final currentUnixTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final remainingTime = widget.targetUnixTime - currentUnixTime;
    if (remainingTime > 0) {
      countdownDuration = Duration(seconds: remainingTime);
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          countdownDuration = countdownDuration - const Duration(seconds: 1);
          if (countdownDuration.inSeconds <= 0) {
            countdownTimer?.cancel();
            isCountdownComplete = true;
          }
        });
      });
    } else {
      isCountdownComplete = true;
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return isCountdownComplete
        ? const Text(
            'Nomor virtual akun sudah kedaluwarsa',
            style: TextStyle(fontSize: 14),
          )
        : Column(
            children: [
              const Text(
                'Sisa Waktu Pembayaran',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                formatTime(countdownDuration),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
  }
}
