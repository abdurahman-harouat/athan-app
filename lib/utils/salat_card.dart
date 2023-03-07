import 'package:flutter/material.dart';

class SalatCard extends StatelessWidget {
  final String prayerTime;
  final String prayerName;

  const SalatCard(
      {required this.prayerName, required this.prayerTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(prayerTime,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Tajawal')),
            Text(
              prayerName,
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
            )
          ],
        ),
      ),
    );
  }
}
