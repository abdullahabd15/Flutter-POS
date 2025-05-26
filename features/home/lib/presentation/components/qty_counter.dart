import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';

class QtyCounter extends StatelessWidget {
  final int value;
  final Function() onAddition;
  final Function() onSubtraction;

  const QtyCounter({
    super.key,
    required this.value,
    required this.onAddition,
    required this.onSubtraction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black87, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.grey.shade200,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onSubtraction,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Iconify(
                    Ph.minus_light,
                    size: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(value.toString()),
            const SizedBox(width: 10),
            Material(
              color: Colors.blueAccent.shade100,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onAddition,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Iconify(
                    Ph.plus,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
