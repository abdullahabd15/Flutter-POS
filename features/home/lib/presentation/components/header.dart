import 'package:flutter/material.dart';
import 'package:pos/data/models/user.dart';

class Header extends StatelessWidget {
  final String? currentDate;
  final User? user;
  final Function onLogout;

  const Header({
    required this.currentDate,
    required this.user,
    required this.onLogout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Point Of Sales',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentDate ?? '',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          popUpAnimationStyle: const AnimationStyle(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            reverseCurve: Curves.easeInOut,
            reverseDuration: Duration(milliseconds: 500),
          ),
          icon: Row(
            children: [
              const Icon(Icons.account_circle, size: 36),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    user?.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user?.role ?? '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          onSelected: (value) {
            if (value == 'logout') onLogout();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
