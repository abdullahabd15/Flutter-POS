import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';

class DateTimeHeader extends StatelessWidget {
  const DateTimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CalendarHourHeader(
          text: "Mon, 23 December 2024",
          icon: Ph.calendar_blank_light,
        ),
        Iconify(Ph.minus_light),
        CalendarHourHeader(
          text: "13:23",
          icon: Ph.clock_light,
        ),
      ],
    );
  }
}

class CalendarHourHeader extends StatelessWidget {
  final String text;
  final String icon;

  const CalendarHourHeader({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Iconify(icon, size: 24),
            const SizedBox(width: 8),
            Text(text)
          ],
        ),
      ),
    );
  }
}
