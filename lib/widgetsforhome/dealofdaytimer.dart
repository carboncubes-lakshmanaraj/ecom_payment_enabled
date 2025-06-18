import 'dart:async';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  final DateTime endTime; // The date/time when the deal ends

  const DealOfTheDay({super.key, required this.endTime});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  late Duration remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    calculateRemainingTime();
    startTimer();
  }

  void calculateRemainingTime() {
    final now = DateTime.now();
    remainingTime = widget.endTime.difference(now);
    if (remainingTime.isNegative) {
      remainingTime = Duration.zero;
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        calculateRemainingTime();
      });

      if (remainingTime <= Duration.zero) {
        timer?.cancel();
      }
    });
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours h $minutes m $seconds s';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Color(0xFF4392F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ' Deal of the Day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                remainingTime > Duration.zero
                    ? 'Time remaining: ${formatDuration(remainingTime)}'
                    : 'Deal has ended',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('View all', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_right_alt, color: Colors.white, size: 25),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
